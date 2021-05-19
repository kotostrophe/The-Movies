// DetailsHeaderImageViewCell.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsHeaderImageViewCell: UICollectionViewCell {
    // MARK: - Properties

    let imageView: UIImageView

    // MARK: - Initializer

    override init(frame: CGRect) {
        imageView = UIImageView(frame: frame)
        super.init(frame: .zero)
        placeComponents()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func layoutSubviews() {
        super.layoutSubviews()

        configureComponents()
    }
}

private extension DetailsHeaderImageViewCell {
    // MARK: - Place components

    func placeComponents() {
        placeImageView()
    }

    func placeImageView() {
        addSubview(imageView)
    }

    // MARK: - Configurate components

    func configureComponents() {
        configureImageView()
    }

    func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
    }
}
