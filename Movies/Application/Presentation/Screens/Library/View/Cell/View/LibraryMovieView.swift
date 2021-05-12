// LibraryMovieView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class LibraryMovieView: UICollectionViewCell {
    // MARK: - Properties

    private(set) var model: LibraryMovieModel?
    private(set) weak var imageProxy: ImageProxyServiceProtocol?

    // MARK: - UI Properties

    private let padding: CGFloat = 8

    private let stackView: UIStackView

    let imageView: UIImageView
    let titleLabel: UILabel

    // MARK: - Initializer

    override required init(frame: CGRect) {
        imageView = UIImageView()
        titleLabel = UILabel()

        stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        super.init(frame: frame)

        placeComponents()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        titleLabel.text = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        setComponents()
        configureComponents()
    }

    // MARK: - UI Place methods

    private func placeComponents() {
        addSubview(stackView)
    }

    // MARK: - UI Setup methods

    private func setComponents() {
        setStackViewComponent()
    }

    private func setStackViewComponent() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
    }

    // MARK: - UI Configure methods

    private func configureComponents() {
        configureStackView()
        configureImageViewComponent()
        configureTitleLabelComponent()
    }

    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
    }

    private func configureImageViewComponent() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .secondarySystemBackground
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }

    private func configureTitleLabelComponent() {
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        titleLabel.numberOfLines = 0
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
    }

    // MARK: - Configuration methods

    func configure(with model: LibraryMovieModel, imageProxy: ImageProxyServiceProtocol) {
        self.model = model
        self.imageProxy = imageProxy

        titleLabel.text = model.movie.title
        imageProxy.getImage(by: model.movie.posterPath ?? "", completion: { [weak self] data in
            DispatchQueue.main.async {
                guard let data = data else { return }
                self?.imageView.image = UIImage(data: data)
            }
        })
    }
}
