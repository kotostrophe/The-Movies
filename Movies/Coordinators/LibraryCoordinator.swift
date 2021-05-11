// LibraryCoordinator.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol LibraryFlow: Coordinatable {
    func startDetails(movie: Movie)
    func startErrorAlert(error: Error)
}

final class LibraryCoordinator: LibraryFlow {
    // MARK: - Properties

    let navigationController: UINavigationController
    var detailsCoordinator: DetailsFlow?

    // MARK: - Initializer

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    func start() {
        let viewController = ScreenBuilder.buildLibrary(coordinator: self)
        navigationController.setViewControllers([viewController], animated: false)
    }

    func startDetails(movie: Movie) {
        let detailsCoordinator = DetailsCoordinator(navigationController: navigationController, movie: movie)
        self.detailsCoordinator = detailsCoordinator
        coordinate(to: detailsCoordinator)
    }

    func startErrorAlert(error: Error) {
        let alert = UIAlertController(
            title: "Occured error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "Done", style: .default))
        navigationController.present(alert, animated: true)
    }
}
