// LibraryMovieView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class LibraryMovieView: UICollectionViewCell {
    // MARK: - Properties

    private(set) var movie: Movie?
    private(set) weak var imageProxy: ImageProxyServiceProtocol?

    // MARK: - UI Properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = Appearance.spacing
        return stackView
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Appearance.Image.radius
        imageView.backgroundColor = Appearance.Image.backgroundColor
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(
            ofSize: Appearance.Title.fontSize,
            weight: Appearance.Title.fontWeight
        )
        label.numberOfLines = 0
        label.textColor = Appearance.Title.textColor
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setComponentsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func prepareForReuse() {
        super.prepareForReuse()

        imageView.image = nil
        titleLabel.text = nil
    }

    // MARK: - Configuration methods

    func configure(movie: Movie, imageProxy: ImageProxyServiceProtocol) {
        self.movie = movie
        self.imageProxy = imageProxy

        titleLabel.text = movie.title

        guard let posterPath = movie.posterPath?.trimLast("/") else { return }
        imageProxy.getImage(by: posterPath) { [weak self, movie] data in
            guard movie == self?.movie else { return }
            DispatchQueue.main.async {
                guard let data = data else { return }
                self?.imageView.image = UIImage(data: data)
            }
        }
    }
}

// MARK: - UI Setup methods

private extension LibraryMovieView {
    func setComponentsConstraints() {
        setStackViewConstraints()
    }

    func setStackViewConstraints() {
        addSubview(stackView)
        stackView.set(arrangedSubviews: [imageView, titleLabel])
        stackView.anchor
            .edgesToSuperview(insets: Appearance.padding)
            .activate()
    }
}

// MARK: - Appearance

private extension LibraryMovieView {
    enum Appearance {
        enum Image {
            static let radius: CGFloat = 4.0
            static let backgroundColor: UIColor = .secondarySystemBackground
        }

        enum Title {
            static let fontSize: CGFloat = 15
            static let fontWeight: UIFont.Weight = .medium
            static let textColor: UIColor = .label
        }

        static let padding: UIEdgeInsets = .init(8)
        static let spacing: CGFloat = 4.0
    }
}
