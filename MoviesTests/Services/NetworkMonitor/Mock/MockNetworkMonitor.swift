// MockNetworkMonitor.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies
import Network

final class MockNetworkMonitor: NetworkMonitorProtocol {
    // MARK: - Properties

    var lastPathStatus: NWPath.Status?
    var isSatisfied: Bool = true

    weak var delegate: NetworkServiceDelegate?

    // MARK: - Methods

    func start() {}

    func stop() {}
}
