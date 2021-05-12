// Coordinatable.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol Coordinatable: AnyObject {
    var coordinators: [Coordinatable] { get }

    func start()
    func coordinate(to coordinator: Coordinatable)
}

extension Coordinatable {
    func coordinate(to coordinator: Coordinatable) {
        coordinator.start()
    }
}
