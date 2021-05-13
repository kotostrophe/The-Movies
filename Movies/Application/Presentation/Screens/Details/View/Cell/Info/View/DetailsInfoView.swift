// DetailsInfoView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsInfoView: UITableViewCell {
    // MARK: - Properties

    var model: DetailsInfoModel
    let genreProxyService: GenreProxyServiceProtocol

    // MARK: - UI Properties

    private let padding: UIEdgeInsets = .init(top: 16, left: 16, bottom: 16, right: 16)

    lazy var stackView: UIStackView = makeStackView()
    lazy var releaseCategory = CategoryView()
    lazy var genreCategory = CategoryView()

    // MARK: - Initializer

    required init(model: DetailsInfoModel, genreProxyService: GenreProxyServiceProtocol) {
        self.model = model
        self.genreProxyService = genreProxyService

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

        if let date = getDate(from: model.releaseDate ?? "") {
            let formatedDate = formatDate(from: date)
            releaseCategory.descriptionLabel.text = formatedDate ?? "Undefined"
        } else {
            releaseCategory.descriptionLabel.text = "Undefined"
        }
    }

    private func configureGenreCategory() {
        genreCategory.titleLabel.text = "Genre"

        genreProxyService.getGenres(completion: { [weak self] genres in
            guard let self = self else { return }
            guard let genres = genres else { return }

            self.model.genres = genres

            let filteredGenres = genres.filter { self.model.genresId.contains($0.id) }
            let genresText = filteredGenres.map(\.name).joined(separator: ", ")

            DispatchQueue.main.async {
                self.genreCategory.descriptionLabel.text = genresText
            }
        })
    }

    // MARK: - Date methods

    private func getDate(from _: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: model.releaseDate ?? "")
    }

    private func formatDate(from date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        return dateFormatter.string(from: date)
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
        stackView.spacing = 4
        stackView.distribution = .fillEqually
        return stackView
    }
}
