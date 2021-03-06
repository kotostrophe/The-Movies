// DetailsViewController.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsViewController: UIViewController {
    // MARK: - Properties

    let viewModel: DetailsViewModelProtocol

    // MARK: - UI Properties

    var contentView: DetailsView? {
        view as? DetailsView
    }

    // MARK: - Initializer

    required init(
        viewModel: DetailsViewModelProtocol
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle methods

    override func loadView() {
        let view = DetailsView()
        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.tableView.estimatedRowHeight = 98
        view.tableView.rowHeight = UITableView.automaticDimension

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureCallbacks()
        viewModel.setup()
    }

    // MARK: - Configuration methods

    private func configureCallbacks() {
        viewModel.didSetupWithMovie = { [weak self] movie in
            self?.title = movie.title
        }

        viewModel.didFetchPosters = { [weak contentView] _ in
            contentView?.tableView.reloadData()
        }

        viewModel.didFetchGenres = { [weak contentView] _ in
            contentView?.tableView.reloadData()
        }
    }
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.components.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = viewModel.movie
        let genres = viewModel.genres

        switch viewModel.components[indexPath.item] {
        case .title:
            let detailsTitleModel = DetailsTitleModel(
                title: movie.title,
                popularity: movie.popularity,
                rating: movie.voteAverage
            )
            return DetailsTitleView(model: detailsTitleModel)

        case .info:
            let detailsInfoModel = DetailsInfoModel(
                releaseDate: movie.releaseDate,
                genres: genres
            )
            return DetailsInfoView(model: detailsInfoModel)

        case .description:
            let description = DetailsDescriptionModel(description: movie.overview)
            return DetailsDescriptionView(model: description)
        }
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let header = DetailsHeaderView()
        header.dataSource = self
        return header
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        270
    }
}

extension DetailsViewController: DetailsHeaderViewDataSource {
    func numberOfImages(at detailsHeaderView: DetailsHeaderView) -> Int {
        viewModel.posters.count
    }

    func detailsHeaderView(_ detailsHeaderView: DetailsHeaderView, imageDataAt index: Int) -> Data {
        viewModel.posters[index]
    }
}
