// LibraryNetworkServiceTests.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies
import XCTest

// swiftlint:disable implicitly_unwrapped_optional

final class LibraryNetworkServiceTests: XCTestCase {
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
}
