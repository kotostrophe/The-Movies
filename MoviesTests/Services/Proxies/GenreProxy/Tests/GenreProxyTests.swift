// GenreProxyTests.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies
import XCTest

// swiftlint:disable implicitly_unwrapped_optional

final class GenreProxyTests: XCTestCase {
    // MARK: - Properties

    var networkMonitor: MockNetworkMonitor!
    var databaseService: MockGenreDatabaseService!
    var networkService: MockGenreNetworkService!
    var genresProxyService: GenreProxyService!

    // MARK: - Setup methods

    override func setUp() {
        super.setUp()

        networkMonitor = MockNetworkMonitor()
        networkService = MockGenreNetworkService(genres: [])
        databaseService = MockGenreDatabaseService(genres: [])
        genresProxyService = GenreProxyService(
            networkMonitor: networkMonitor,
            networkService: networkService,
            databaseService: databaseService
        )
    }

    override func tearDown() {
        networkMonitor = nil
        networkService = nil
        databaseService = nil
        genresProxyService = nil

        super.tearDown()
    }

    // MARK: - Methods

    func testFetchGenresIfNetworkIsSatisfiedAndDatabaseIsEmpty() {
        networkMonitor.lastPathStatus = .satisfied

        databaseService.genres = []
        networkService.genres = GenreFactory().makeGenres().shuffled()

        genresProxyService.fetchGenres { [weak self] result in
            guard let self = self else {
                XCTFail("Expected alive self")
                return
            }
            guard case let .success(genres) = result else {
                XCTFail("Expected successfull response")
                return
            }

            XCTAssertTrue(genres == self.databaseService.genres, "Expected caching to database")
            XCTAssert(genres == self.networkService.genres, "Expected genres from network")
        }
    }

    func testFetchGenresByIdIfNetworkIsUnsatisfiedAndDatabaseIsFull() {
        networkMonitor.lastPathStatus = .unsatisfied

        databaseService.genres = GenreFactory().makeGenres().shuffled()
        networkService.genres = []

        guard let firstGenre = databaseService.genres.first else {
            XCTFail("Expected array of genres")
            return
        }

        genresProxyService.fetchGenre(by: firstGenre.id) { result in
            guard case let .success(genre) = result else {
                XCTFail("Expected successfull response")
                return
            }

            XCTAssert(genre == firstGenre)
        }
    }
}
