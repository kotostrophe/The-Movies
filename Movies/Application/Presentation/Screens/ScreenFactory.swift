// ScreenFactory.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol ScreenFactoryProtocol: AnyObject {
    func makeLibrary(coordinator: LibraryCoordinatorProtocol) -> UIViewController
    func makeDetails(movie: Movie, coordinator: LibraryCoordinatorProtocol) -> UIViewController
}

final class ScreenFactory: ScreenFactoryProtocol {
    // MARK: - Properties

    let serviceFactory: ServiceFactoryProtocol

    // MARK: - Initializer

    init(serviceFactory: ServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory
    }

    convenience init() {
        let serviceFactory = ServiceFactory()
        self.init(serviceFactory: serviceFactory)
    }

    // MARK: - Methods

    func makeLibrary(coordinator: LibraryCoordinatorProtocol) -> UIViewController {
        let model = LibraryModel()
        let imageProxyService = serviceFactory.makeProxiesFactory().makeImageProxyService()
        let genresProxyService = serviceFactory.makeProxiesFactory().makeGenreProxyService()
        let networkService = serviceFactory.makeNetworkingFactory().makeLibraryNetworkingService()

        let viewModel = LibraryViewModel(
            model: model,
            networkService: networkService,
            genreProxyService: genresProxyService,
            imageProxyService: imageProxyService,
            coordinator: coordinator
        )

        return LibraryViewController(viewModel: viewModel)
    }

    func makeDetails(movie: Movie, coordinator: LibraryCoordinatorProtocol) -> UIViewController {
        let imageProxyService = serviceFactory.makeProxiesFactory().makeImageProxyService()
        let genreProxyService = serviceFactory.makeProxiesFactory().makeGenreProxyService()

        let viewModel = DetailsViewModel(
            movie: movie,
            components: [.title, .info, .description],
            genres: [],
            model: .loading,
            imageProxyService: imageProxyService,
            genreProxyService: genreProxyService,
            coordinator: coordinator
        )

        return DetailsViewController(viewModel: viewModel)
    }
}
