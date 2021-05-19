// NetworkMonitorTests.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies
import XCTest

final class NetworkMonitorTests: XCTestCase {
    // MARK: - Properties

    var networkMonitor: MockNetworkMonitor!

    // MARK: - Setup methods

    override func setUp() {
        super.setUp()

        networkMonitor = MockNetworkMonitor()
    }

    override func tearDown() {
        networkMonitor = nil

        super.tearDown()
    }

    // MARK: - Test methods

    func testSatisfyingWhenRequiredConnection() {
        networkMonitor.lastPathStatus = .requiresConnection
        XCTAssertFalse(networkMonitor.isSatisfied)
    }

    func testSatisfyingWhenConnectionIsUnsatisfied() {
        networkMonitor.lastPathStatus = .unsatisfied
        XCTAssertFalse(networkMonitor.isSatisfied)
    }

    func testSatisfyingWhenConnectionIsSatisfied() {
        networkMonitor.lastPathStatus = .satisfied
        XCTAssertTrue(networkMonitor.isSatisfied)
    }
}
