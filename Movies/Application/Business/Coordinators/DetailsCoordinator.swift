// DetailsCoordinator.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol DetailsCoordinatorProtocol: Coordinatable {}

final class DetailsCoordinator: DetailsCoordinatorProtocol {
    // MARK: - Properties

    var coordinators: [Coordinatable] = []

    let navigationController: UINavigationController
    let movie: Movie

    // MARK: - Initializer

    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.movie = movie
    }

    // MARK: - Methods

    func start() {
        let viewController = ScreenBuilder.buildDetails(movie: movie, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
