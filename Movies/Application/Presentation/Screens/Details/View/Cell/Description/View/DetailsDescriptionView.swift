// DetailsDescriptionView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsDescriptionView: UITableViewCell {
    // MARK: - Properties

    let model: DetailsDescriptionModel

    // MARK: - UI Properties

    private let padding: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)

    lazy var categoryView = makeCategoryView()

    // MARK: - Initializer

    required init(model: DetailsDescriptionModel) {
        self.model = model

        super.init(style: .default, reuseIdentifier: nil)
        selectionStyle = .none

        categoryView.titleLabel.text = "Description"
        categoryView.descriptionLabel.text = model.description
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DetailsDescriptionView {
    func makeCategoryView() -> CategoryView {
        let categoryView = CategoryView()
        contentView.addSubview(categoryView)
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        categoryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding.left)
            .isActive = true
        categoryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding.right)
            .isActive = true
        categoryView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding.top).isActive = true
        categoryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding.bottom)
            .isActive = true

        return categoryView
    }
}
