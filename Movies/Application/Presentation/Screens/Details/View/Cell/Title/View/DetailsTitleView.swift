// DetailsTitleView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsTitleView: UITableViewCell {
    // MARK: - Properties

    private let model: DetailsTitleModel

    // MARK: - Private UI properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 21, weight: .semibold)
        return label
    }()

    private let attributesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let popularityAttributeView: DetailsAttributeView = {
        let attributeView = DetailsAttributeView()
        attributeView.imageView.image = UIImage(systemName: "arrow.up.arrow.down")
        attributeView.imageView.tintColor = .secondaryLabel
        attributeView.imageView.contentMode = .scaleAspectFit
        return attributeView
    }()

    private let ratingAttributeView: DetailsAttributeView = {
        let attributeView = DetailsAttributeView()
        attributeView.imageView.image = UIImage(systemName: "star.fill")
        attributeView.imageView.tintColor = .secondaryLabel
        attributeView.imageView.contentMode = .scaleAspectFit
        return attributeView
    }()

    // MARK: - Initializer

    required init(model: DetailsTitleModel) {
        self.model = model

        super.init(style: .default, reuseIdentifier: nil)

        configureComponents()
        setConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration methods

private extension DetailsTitleView {
    func configureComponents() {
        configureView()
        configurePopularityAttributeView()
        configureRatingAttributeView()
        configureTitleLabel()
    }

    func configureView() {
        selectionStyle = .none
    }

    func configurePopularityAttributeView() {
        popularityAttributeView.titleLabel.text = String(format: "Popularity %.0f", model.popularity)
    }

    func configureRatingAttributeView() {
        ratingAttributeView.titleLabel.text = String(format: "Popularity %.0f", model.popularity)
    }

    func configureTitleLabel() {
        titleLabel.text = model.title
    }
}

// MARK: - Constraints

private extension DetailsTitleView {
    func setConstraints() {
        setTitleLabelConstraints()
        setAttributesStackViewStackViewConstraints()
    }

    func setTitleLabelConstraints() {
        addSubview(titleLabel)
        titleLabel.anchor
            .leftToSuperview(constant: Appearance.padding.left)
            .rightToSuperview(constant: -Appearance.padding.right)
            .topToSuperview(constant: Appearance.padding.top)
            .activate()
    }

    func setAttributesStackViewStackViewConstraints() {
        addSubview(attributesStackView)
        attributesStackView.set(arrangedSubviews: [popularityAttributeView, ratingAttributeView])
        attributesStackView.anchor
            .leftToSuperview(constant: Appearance.padding.left)
            .rightToSuperview(constant: -Appearance.padding.right)
            .top(to: titleLabel.bottom, constant: Appearance.spacing)
            .bottomToSuperview(constant: -Appearance.padding.bottom)
            .activate()
    }
}

// MARK: - Appearance

extension DetailsTitleView {
    enum Appearance {
        static let spacing: CGFloat = 8
        static let padding: UIEdgeInsets = .init(16)
    }
}
