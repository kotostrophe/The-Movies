// DetailsDescriptionView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsDescriptionView: UITableViewCell {
    // MARK: - Properties

    let model: DetailsDescriptionModel

    // MARK: - UI Properties

    let stackView: UIStackView

    let descriptionTitleLabel: UILabel
    let descriptionLabel: UILabel

    // MARK: - Initializer

    required init(model: DetailsDescriptionModel) {
        self.model = model

        descriptionTitleLabel = UILabel()
        descriptionLabel = UILabel()
        stackView = UIStackView(arrangedSubviews: [descriptionTitleLabel, descriptionLabel])

        super.init(style: .default, reuseIdentifier: nil)
        selectionStyle = .none
        placeComponents()

        configureComponents()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsDescriptionView {
    // MARK: - Place components

    private func placeComponents() {
        placeStackView()
    }

    private func placeStackView() {
        contentView.addSubview(stackView)
    }

    // MARK: - Configurate components

    private func configureComponents() {
        configureStackView()
        configureDescription()
    }

    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true

        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
    }

    private func configureDescription() {
        descriptionTitleLabel.text = "Description"
        descriptionTitleLabel.font = UIFont.systemFont(ofSize: 19, weight: .semibold)

        descriptionLabel.text = model.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .secondaryLabel
    }
}
