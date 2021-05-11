// DetailsInfoView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsInfoView: UITableViewCell {
    // MARK: - Properties

    var model: DetailsInfoModel
    let genreProxyService: GenreProxyServiceProtocol

    // MARK: - UI Properties

    let stackView: UIStackView

    let releaseStackView: UIStackView
    let releaseTitleLabel: UILabel
    let releaseLabel: UILabel

    let genreStackView: UIStackView
    let genreTitleLabel: UILabel
    let genreLabel: UILabel

    // MARK: - Initializer

    required init(model: DetailsInfoModel, genreProxyService: GenreProxyServiceProtocol) {
        self.model = model
        self.genreProxyService = genreProxyService

        releaseTitleLabel = UILabel()
        releaseLabel = UILabel()

        genreTitleLabel = UILabel()
        genreLabel = UILabel()

        releaseStackView = UIStackView(arrangedSubviews: [releaseTitleLabel, releaseLabel])
        genreStackView = UIStackView(arrangedSubviews: [genreTitleLabel, genreLabel])

        stackView = UIStackView(arrangedSubviews: [releaseStackView, genreStackView])

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

extension DetailsInfoView {
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
        configureReleaseStackView()
        configureGenreStackView()
    }

    private func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true

        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fillEqually
    }

    private func configureReleaseStackView() {
        releaseTitleLabel.text = "Release date"
        releaseTitleLabel.font = UIFont.systemFont(ofSize: 19, weight: .semibold)

        if let date = getDate(from: model.releaseDate ?? "") {
            let formatedDate = formatDate(from: date)
            releaseLabel.text = formatedDate ?? "Undefined"
        } else {
            releaseLabel.text = "Undefined"
        }

        releaseLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        releaseLabel.numberOfLines = 0
        releaseLabel.textColor = .secondaryLabel

        releaseStackView.spacing = 8
        releaseStackView.axis = .vertical
        releaseStackView.distribution = .equalSpacing
    }

    private func configureGenreStackView() {
        genreTitleLabel.text = "Genre"
        genreTitleLabel.font = UIFont.systemFont(ofSize: 19, weight: .semibold)

        genreProxyService.getGenres(completion: { [weak self] genres in
            guard let self = self else { return }
            guard let genres = genres else { return }

            self.model.genres = genres

            let filteredGenres = genres.filter { self.model.genresId.contains($0.id) }
            let genresText = filteredGenres.map(\.name).joined(separator: ", ")

            DispatchQueue.main.async {
                self.genreLabel.text = genresText
            }
        })

        genreLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        genreLabel.textColor = .secondaryLabel

        genreStackView.spacing = 8
        genreStackView.axis = .vertical
        genreStackView.distribution = .equalSpacing
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
