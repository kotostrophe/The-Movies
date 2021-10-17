// DetailsInfoView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsInfoView: UITableViewCell {
    // MARK: - Properties

    private let model: DetailsInfoModel

    // MARK: - Private UI properties

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let releaseCategory = CategoryView()

    private let genreCategory = CategoryView()

    // MARK: - Initializer

    required init(model: DetailsInfoModel) {
        self.model = model

        super.init(style: .default, reuseIdentifier: nil)

        configureComponents()
        setComponentsConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration methods

private extension DetailsInfoView {
    func configureComponents() {
        configureView()
        configureReleaseCategory()
        configureGenreCategory()
    }

    func configureView() {
        selectionStyle = .none
    }

    func configureReleaseCategory() {
        releaseCategory.titleLabel.text = "Release date"
        releaseCategory.descriptionLabel.text = model
            .releaseDate?
            .toDate(with: "yyyy-MM-dd")?
            .toString(with: "MMMM d, yyyy")
    }

    func configureGenreCategory() {
        genreCategory.titleLabel.text = "Genre"
        genreCategory.descriptionLabel.text = model.genres.map(\.name).joined(separator: ", ")
    }
}

// MARK: - Constraints

private extension DetailsInfoView {
    func setComponentsConstraints() {
        setStackViewConstraints()
    }

    func setStackViewConstraints() {
        contentView.addSubview(stackView)
        stackView.set(arrangedSubviews: [releaseCategory, genreCategory])
        stackView.anchor
            .edgesToSuperview(insets: Appearance.padding)
            .activate()
    }
}

private extension DetailsInfoView {
    enum Appearance {
        static let padding: UIEdgeInsets = .init(16)
    }
}
