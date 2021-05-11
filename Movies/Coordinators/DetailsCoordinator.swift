// DetailsCoordinator.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol DetailsFlow: Coordinatable {}

final class DetailsCoordinator: DetailsFlow {
    // MARK: - Properties

    let navigationController: UINavigationController
    let movie: Movie

    // MARK: - Initializer

    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.movie = movie
    }

    func start() {
        let viewController = ScreenBuilder.buildDetails(movie: movie, coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
}
