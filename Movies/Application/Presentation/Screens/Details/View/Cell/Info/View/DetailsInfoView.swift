// DetailsInfoView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsInfoView: UITableViewCell {
    // MARK: - Properties

    var model: DetailsInfoModel

    // MARK: - UI Properties

    private let padding: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)

    lazy var stackView: UIStackView = makeStackView()
    lazy var releaseCategory = CategoryView()
    lazy var genreCategory = CategoryView()

    // MARK: - Initializer

    required init(model: DetailsInfoModel) {
        self.model = model

        super.init(style: .default, reuseIdentifier: nil)
        selectionStyle = .none

        _ = stackView

        configureReleaseCategory()
        configureGenreCategory()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration methods

    private func configureReleaseCategory() {
        releaseCategory.titleLabel.text = "Release date"
        releaseCategory.descriptionLabel.text = model.releaseDate?.toDate(with: "yyyy-MM-dd")?
            .toString(with: "MMMM d, yyyy")
    }

    private func configureGenreCategory() {
        genreCategory.titleLabel.text = "Genre"
        genreCategory.descriptionLabel.text = model.genres.map(\.name).joined(separator: ", ")
    }
}

private extension DetailsInfoView {
    func makeStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [releaseCategory, genreCategory])
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true

        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }
}
