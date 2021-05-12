// ScreenFactory.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol ScreenFactoryProtocol: AnyObject {
    func makeLibrary(coordinator: LibraryCoordinatorProtocol) -> UIViewController
    func makeDetails(movie: Movie, coordinator: LibraryCoordinatorProtocol) -> UIViewController
}

final class ScreenFactory: ScreenFactoryProtocol {
    // MARK: - Methods

    func makeLibrary(coordinator: LibraryCoordinatorProtocol) -> UIViewController {
        let model = LibraryModel()
        let imageProxyService = ImageProxyService.shared
        let genresProxyService = GenreProxyService.shared
        let networkService = LibraryNetworkService()

        return LibraryViewController(
            model: model,
            networkService: networkService,
            genreProxyService: genresProxyService,
            imageProxyService: imageProxyService,
            coordinator: coordinator
        )
    }

    func makeDetails(movie: Movie, coordinator: LibraryCoordinatorProtocol) -> UIViewController {
        let model = DetailsModel.data(.init(movie: movie, components: [.title, .info, .description]))
        let imageProxyService = ImageProxyService.shared
        let genreProxyService = GenreProxyService.shared

        let viewModel = DetailsViewModel(
            model: model,
            imageProxyService: imageProxyService,
            genreProxyService: genreProxyService,
            coordinator: coordinator
        )

        return DetailsViewController(viewModel: viewModel)
    }
}
