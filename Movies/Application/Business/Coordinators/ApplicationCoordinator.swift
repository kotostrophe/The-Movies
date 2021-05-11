// ApplicationCoordinator.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol ApplicationFlow: Coordinatable {}

final class ApplicationCoordiantor: ApplicationFlow {
    // MARK: - Properties

    weak var window: UIWindow?

    var libraryCoordinator: LibraryFlow?

    // MARK: - Initializer

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Methods

    func start() {
        let navigationController = UINavigationController()
        let libraryCoordinator = LibraryCoordinator(navigationController: navigationController)
        self.libraryCoordinator = libraryCoordinator
        coordinate(to: libraryCoordinator)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
