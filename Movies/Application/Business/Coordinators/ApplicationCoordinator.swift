// ApplicationCoordinator.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

protocol ApplicationCoordiantorProtocol: Coordinatable {}

final class ApplicationCoordiantor: ApplicationCoordiantorProtocol {
    // MARK: - Properties

    var coordinators: [Coordinatable] = []

    weak var window: UIWindow?

    // MARK: - Initializer

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Methods

    func start() {
        let navigationController = UINavigationController()
        let libraryCoordinator = LibraryCoordinator(navigationController: navigationController)
        coordinate(to: libraryCoordinator)
        coordinators.append(libraryCoordinator)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
