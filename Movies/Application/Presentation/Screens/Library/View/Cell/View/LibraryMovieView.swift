// LibraryMovieView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class LibraryMovieView: UICollectionViewCell {
    // MARK: - Properties

    private(set) var movie: Movie?
    private(set) weak var imageProxy: ImageProxyServiceProtocol?

    // MARK: - UI Properties

    private let padding: UIEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)

    private lazy var stackView: UIStackView = makeStacKView()
    lazy var imageView: UIImageView = makeImageView()
    lazy var titleLabel: UILabel = makeTitleLabel()

    // MARK: - Life cycle methods

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        titleLabel.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        _ = stackView
    }

    // MARK: - Configuration methods

    func configure(with movie: Movie, imageProxy: ImageProxyServiceProtocol) {
        self.movie = movie
        self.imageProxy = imageProxy

        titleLabel.text = movie.title

        guard let posterPath = movie.posterPath?.trimLast("/") else { return }
        imageProxy.getImage(by: posterPath) { [weak self] data in
            DispatchQueue.main.async {
                guard let data = data else { return }
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
}

extension LibraryMovieView {
    func makeStacKView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom).isActive = true

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }

    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .secondarySystemBackground
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }

    func makeTitleLabel() -> UILabel {
        let label = UILabel()

        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)

        return label
    }
}
