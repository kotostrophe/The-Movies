// DetailsView.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsView: UIView {
    // MARK: - Properties

    var state: DetailsModel = .loading {
        didSet { setNeedsLayout() }
    }

    // MARK: - UI Properties

    lazy var activityIndicator = makeActivityIndicator()

    lazy var tableView: UITableView = {
        let tableView = makeTableView()
//        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = .init()
        return tableView
    }()

    // MARK: - Life cycle methods

    override func layoutSubviews() {
        super.layoutSubviews()

        updateState(with: state)
    }

    // MARK: - UI Place methods

    private func updateState(with state: DetailsModel) {
        backgroundColor = .systemBackground

        switch state {
        case .loading:
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            tableView.isHidden = true

        case .data:
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            tableView.isHidden = false
            tableView.reloadData()

        case .error:
            tableView.isHidden = true
        }
    }
}

extension DetailsView: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        guard case let .data(data) = state else { return 0 }
        return data.components.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard case let .data(data) = state else { return .init() }

        switch data.components[indexPath.item] {
        case .title:
            let detailsTitleModel = DetailsTitleModel(
                title: data.movie.title,
                popularity: data.movie.popularity,
                rating: data.movie.voteAverage
            )
            return DetailsTitleView(model: detailsTitleModel)

        case .info:
            let detailsInfoModel = DetailsInfoModel(
                releaseDate: data.movie.releaseDate,
                genresId: data.movie.genres,
                genres: []
            )
            return DetailsInfoView(model: detailsInfoModel, genreProxyService: GenreProxyService.shared)

        case .description:
            let description = DetailsDescriptionModel(description: data.movie.overview)
            return DetailsDescriptionView(model: description)
        }
    }
}

extension DetailsView: UITableViewDelegate {
    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        guard case let .data(data) = state else { return .init() }

        let headerModel = DetailsHeaderModel(imagePath: data.movie.posterPath)
        return DetailsHeaderView(model: headerModel, imageProxyService: ImageProxyService.shared)
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        270
    }
}

extension DetailsView {
    func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .clear
        addSubview(tableView)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        return tableView
    }

    func makeActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        addSubview(activityIndicator)

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 48).isActive = true
        activityIndicator.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -48).isActive = true
        activityIndicator.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 48).isActive = true
        activityIndicator.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -48).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        return activityIndicator
    }
}
