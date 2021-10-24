// ScreenBuilder.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol ScreenBuilderProtocol: AnyObject {
    func makeLibrary(coordinator: LibraryCoordinatorProtocol) -> UIViewController
    func makeDetails(movie: Movie, coordinator: LibraryCoordinatorProtocol) -> UIViewController
}

final class ScreenBuilder: ScreenBuilderProtocol {
    // MARK: - Properties

    let serviceFactory: ServiceFactoryProtocol

    // MARK: - Initializer

    init(serviceFactory: ServiceFactoryProtocol) {
        self.serviceFactory = serviceFactory
    }

    convenience init() {
        let serviceFactory = ServiceFactory.shared
        self.init(serviceFactory: serviceFactory)
    }

    // MARK: - Methods

    func makeLibrary(coordinator: LibraryCoordinatorProtocol) -> UIViewController {
        let model = LibraryModel()
        let imageProxyService = serviceFactory.makeProxiesFactory().makeImageProxyService()
        let genresProxyService = serviceFactory.makeProxiesFactory().makeGenreProxyService()
        let libraryProxyService = serviceFactory.makeProxiesFactory().makeLibraryProxyService()
        let itemsService = serviceFactory.makeItemsServiceFactory().makeLibraryItemsService()

        let viewModel = LibraryViewModel(
            model: model,
            libraryProxyService: libraryProxyService,
            genreProxyService: genresProxyService,
            imageProxyService: imageProxyService,
            itemsService: itemsService,
            coordinator: coordinator
        )

        return LibraryViewController(viewModel: viewModel)
    }

    func makeDetails(movie: Movie, coordinator: LibraryCoordinatorProtocol) -> UIViewController {
        let imageProxyService = serviceFactory.makeProxiesFactory().makeImageProxyService()
        let genreProxyService = serviceFactory.makeProxiesFactory().makeGenreProxyService()
        let detailsNetworkService = serviceFactory.makeNetworkingFactory().makeDetailsNetworkServer()
        let model = DetailsModel(movie: movie, posters: [], genres: [], components: DetailsComponent.allCases)

        let viewModel = DetailsViewModel(
            model: model,
            networkService: detailsNetworkService,
            imageProxyService: imageProxyService,
            genreProxyService: genreProxyService,
            coordinator: coordinator
        )

        return DetailsViewController(viewModel: viewModel)
    }
}
