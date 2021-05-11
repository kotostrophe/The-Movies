// DetailsCoordinator.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol DetailsCoordinatorProtocol: Coordinatable {}

final class DetailsCoordinator: DetailsCoordinatorProtocol {
    // MARK: - Properties

    let movie: Movie

    var coordinators: [Coordinatable] = []
    let navigationController: UINavigationController
    let screenFactory: ScreenFactoryProtocol

    // MARK: - Initializer

    init(navigationController: UINavigationController, screenFactory: ScreenFactoryProtocol, movie: Movie) {
        self.navigationController = navigationController
        self.screenFactory = screenFactory
        self.movie = movie
    }

    convenience init(navigationController: UINavigationController, movie: Movie) {
        let screenFactory = ScreenFactory()
        self.init(navigationController: navigationController, screenFactory: screenFactory, movie: movie)
    }

    convenience init(movie: Movie) {
        let navigationController = UINavigationController()
        self.init(navigationController: navigationController, movie: movie)
    }

    // MARK: - Methods

    func start() {
        let viewController = screenFactory.makeDetails(movie: movie, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
