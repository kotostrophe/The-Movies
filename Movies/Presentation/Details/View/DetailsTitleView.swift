// DetailsTitleView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsTitleView: UITableViewCell {
    // MARK: - Properties

    let model: DetailsTitleModel

    // MARK: - UI Properties

    let stackView: UIStackView
    let titleLabel: UILabel
    let descriptionStackView: UIStackView

    let popularityStackView: UIStackView
    let popularityIcon: UIImageView
    let popularityLabel: UILabel

    let ratingStackView: UIStackView
    let ratingIcon: UIImageView
    let ratingLabel: UILabel

    // MARK: - Initializer

    required init(model: DetailsTitleModel) {
        self.model = model

        titleLabel = UILabel()
        popularityIcon = UIImageView()
        popularityLabel = UILabel()

        ratingIcon = UIImageView()
        ratingLabel = UILabel()

        popularityStackView = UIStackView(arrangedSubviews: [popularityIcon, popularityLabel])
        ratingStackView = UIStackView(arrangedSubviews: [ratingIcon, ratingLabel])
        descriptionStackView = UIStackView(arrangedSubviews: [popularityStackView, ratingStackView])

        stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionStackView])

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

extension DetailsTitleView {
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
        configureDescriptionStackView()
        configurePopularityStackView()
        configureRatingStackView()

        configureTitleLabel()
    }

    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true

        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fill
    }

    private func configureDescriptionStackView() {
        descriptionStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionStackView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        descriptionStackView.axis = .horizontal
        descriptionStackView.distribution = .fillEqually
    }

    private func configurePopularityStackView() {
        popularityIcon.translatesAutoresizingMaskIntoConstraints = false
        popularityIcon.widthAnchor.constraint(equalTo: ratingIcon.heightAnchor).isActive = true
        popularityIcon.image = UIImage(systemName: "arrow.up.arrow.down")
        popularityIcon.tintColor = .secondaryLabel
        popularityIcon.contentMode = .scaleAspectFit

        popularityLabel.text = String(format: "Popularity %.0f", model.popularity)
        popularityLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        popularityLabel.textColor = .secondaryLabel

        popularityStackView.spacing = 8
        popularityStackView.axis = .horizontal
        popularityStackView.distribution = .fill
    }

    private func configureRatingStackView() {
        ratingIcon.translatesAutoresizingMaskIntoConstraints = false
        ratingIcon.widthAnchor.constraint(equalTo: ratingIcon.heightAnchor).isActive = true
        ratingIcon.image = UIImage(systemName: "star.fill")
        ratingIcon.tintColor = .secondaryLabel
        ratingIcon.contentMode = .scaleAspectFit

        ratingLabel.text = String(format: "Rating %.1f", model.rating)
        ratingLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        ratingLabel.textColor = .secondaryLabel

        ratingStackView.spacing = 8
        ratingStackView.axis = .horizontal
        ratingStackView.distribution = .fill
    }

    private func configureTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        titleLabel.text = model.title
    }
}
