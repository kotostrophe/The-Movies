// DetailsDescriptionView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsDescriptionView: UITableViewCell {
    // MARK: - Properties

    private let model: DetailsDescriptionModel

    // MARK: - Private UI properties

    private let categoryView: CategoryView = .init()

    // MARK: - Initializer

    required init(model: DetailsDescriptionModel) {
        self.model = model

        super.init(style: .default, reuseIdentifier: nil)
        configureComponents()
        setComponentsConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI Configure methods

private extension DetailsDescriptionView {
    func configureComponents() {
        configureView()
        configureCategoryView()
    }

    func configureView() {
        selectionStyle = .none
    }

    func configureCategoryView() {
        categoryView.titleLabel.text = "Description"
        categoryView.descriptionLabel.text = model.description
    }
}

// MARK: - UI Setup methods

private extension DetailsDescriptionView {
    func setComponentsConstraints() {
        setCollectionViewConstraints()
    }

    func setCollectionViewConstraints() {
        contentView.addSubview(categoryView)
        categoryView.anchor
            .edgesToSuperview(insets: Appearance.padding)
            .activate()
    }
}

private extension DetailsDescriptionView {
    enum Appearance {
        static let padding: UIEdgeInsets = .init(16)
    }
}
