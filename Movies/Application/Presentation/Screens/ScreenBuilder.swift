// ScreenBuilder.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol ScreenBuilderProtocol: AnyObject {
    static func buildLibrary(coordinator: LibraryCoordinatorProtocol) -> UIViewController
    static func buildDetails(movie: Movie, coordinator: DetailsCoordinatorProtocol) -> UIViewController
}

final class ScreenBuilder: ScreenBuilderProtocol {
    // MARK: - Methods

    static func buildLibrary(coordinator: LibraryCoordinatorProtocol) -> UIViewController {
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

    static func buildDetails(movie: Movie, coordinator: DetailsCoordinatorProtocol) -> UIViewController {
        let model = DetailsModel(movie: movie, components: [.title, .info, .description])
        let imageProxyService = ImageProxyService.shared
        let genreProxyService = GenreProxyService.shared

        return DetailsViewController(
            model: model,
            imageProxyService: imageProxyService,
            genreProxyService: genreProxyService,
            coordinator: coordinator
        )
    }
}
