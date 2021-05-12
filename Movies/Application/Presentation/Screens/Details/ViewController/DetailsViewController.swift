// DetailsViewController.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class DetailsViewController: UIViewController {
    // MARK: - Properties

    let detailsImageProxyService: ImageProxyServiceProtocol
    let detailsGenreProxyService: GenreProxyServiceProtocol
    let detailsCoordinator: LibraryCoordinatorProtocol
    let detailsModel: DetailsModel

    // MARK: - UI Properties

    var contentView: DetailsView? {
        view as? DetailsView
    }

    // MARK: - Initializer

    required init(
        model: DetailsModel,
        imageProxyService: ImageProxyServiceProtocol,
        genreProxyService: GenreProxyServiceProtocol,
        coordinator: LibraryCoordinatorProtocol
    ) {
        detailsModel = model
        detailsImageProxyService = imageProxyService
        detailsGenreProxyService = genreProxyService
        detailsCoordinator = coordinator

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

        title = detailsModel.movie.title
    }

    // MARK: - Configuretion methods
}

extension DetailsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        detailsModel.components.count
    }

    func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch detailsModel.components[indexPath.item] {
        case .title:
            let detailsTitleModel = DetailsTitleModel(
                title: detailsModel.movie.title,
                popularity: detailsModel.movie.popularity,
                rating: detailsModel.movie.voteAverage
            )
            return DetailsTitleView(model: detailsTitleModel)

        case .info:
            let detailsInfoModel = DetailsInfoModel(
                releaseDate: detailsModel.movie.releaseDate,
                genresId: detailsModel.movie.genres,
                genres: []
            )
            return DetailsInfoView(model: detailsInfoModel, genreProxyService: detailsGenreProxyService)

        case .description:
            let description = DetailsDescriptionModel(description: detailsModel.movie.overview)
            return DetailsDescriptionView(model: description)
        }
    }
}

extension DetailsViewController: UITableViewDelegate {
    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let headerModel = DetailsHeaderModel(imagePath: detailsModel.movie.posterPath)
        return DetailsHeaderView(model: headerModel, imageProxyService: detailsImageProxyService)
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        270
    }
}
