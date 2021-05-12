// LibraryCoordinator.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol LibraryCoordinatorProtocol: Coordinatable {
    func startDetails(movie: Movie)
    func startErrorAlert(error: Error)
}

final class LibraryCoordinator: LibraryCoordinatorProtocol {
    // MARK: - Properties

    var coordinators: [Coordinatable] = []

    let navigationController: UINavigationController
    let screenFactory: ScreenFactoryProtocol

    // MARK: - Initializer

    init(navigationController: UINavigationController, screenFactory: ScreenFactoryProtocol) {
        self.navigationController = navigationController
        self.screenFactory = screenFactory
    }

    convenience init(navigationController: UINavigationController) {
        let screenFactory = ScreenFactory()
        self.init(navigationController: navigationController, screenFactory: screenFactory)
    }

    convenience init() {
        let navigationController = UINavigationController()
        self.init(navigationController: navigationController)
    }

    // MARK: - Methods

    func start() {
        let viewController = screenFactory.makeLibrary(coordinator: self)
        navigationController.setViewControllers([viewController], animated: true)
    }

    func startDetails(movie: Movie) {
        let viewController = screenFactory.makeDetails(movie: movie, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
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
