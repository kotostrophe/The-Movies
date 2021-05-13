// DetailsHeaderView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsHeaderView: UIView {
    // MARK: - Properties

    let detailImageProxyService: ImageProxyServiceProtocol
    var detailHeaderModel: DetailsHeaderModel

    // MARK: - UI Properties

    let imageView: UIImageView

    // MARK: - Initializer

    required init(model: DetailsHeaderModel, imageProxyService: ImageProxyServiceProtocol) {
        detailHeaderModel = model
        detailImageProxyService = imageProxyService

        imageView = UIImageView()

        super.init(frame: .zero)
        placeComponents()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        configureComponents()
    }
}

extension DetailsHeaderView {
    // MARK: - Place components

    private func placeComponents() {
        placeImageView()
    }

    private func placeImageView() {
        addSubview(imageView)
    }

    // MARK: - Configurate components

    private func configureComponents() {
        configureImageView()
    }

    private func configureImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .secondarySystemBackground

        guard let posterPath = detailHeaderModel.imagePath?.trimLast("/") else { return }
        detailImageProxyService.getImage(by: posterPath, completion: { [weak self] data in
            guard let self = self else { return }
            guard let data = data else { return }

            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        })
    }
}
