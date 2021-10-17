// LibraryProxyTests.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies
import XCTest

// swiftlint:disable implicitly_unwrapped_optional

final class LibraryProxyTests: XCTestCase {
    // MARK: - Properties

    var networkMonitor: MockNetworkMonitor!
    var databaseService: MockLibraryDatabaseService!
    var networkService: MockLibraryNetworkService!
    var proxyService: LibraryProxyService!

    // MARK: - Setup methods

    override func setUp() {
        super.setUp()

        networkMonitor = MockNetworkMonitor()
        networkService = MockLibraryNetworkService(movie: [])
        databaseService = MockLibraryDatabaseService(movies: [])
        proxyService = LibraryProxyService(
            networkMonitor: networkMonitor,
            networkService: networkService,
            databaseService: databaseService
        )
    }

    override func tearDown() {
        networkMonitor = nil
        networkService = nil
        databaseService = nil
        proxyService = nil

        super.tearDown()
    }

    // MARK: - Methods

    func testFetchMoviesByQueryIfNetworkIsSatisfiedAndDatabaseIsEmpty() {
        networkMonitor.lastPathStatus = .satisfied

        databaseService.movies = []
        networkService.movies = MoviesFactory().makeMovies().shuffled()
        proxyService.fetchMovies(query: "some film") { [weak self] result in
            guard let self = self else {
                XCTFail("Expected alive self")
                return
            }
            guard case let .success(movies) = result else {
                XCTFail("Expected successfull response")
                return
            }

            XCTAssertTrue(movies == self.databaseService.movies, "Expected caching to database")
            XCTAssert(movies == self.networkService.movies, "Expected movies from network")
        }
    }

    func testFetchMoviesByQueryIfNetworkIsUnsatisfiedAndDatabaseIsFull() {
        networkMonitor.lastPathStatus = .unsatisfied

        databaseService.movies = MoviesFactory().makeMovies().shuffled()
        networkService.movies = []
        proxyService.fetchMovies(query: "some film") { [weak self] result in
            guard let self = self else {
                XCTFail("Expected alive self")
                return
            }
            guard case let .success(movies) = result else {
                XCTFail("Expected successfull response")
                return
            }

            XCTAssert(movies == self.databaseService.movies)
        }
    }

    func testFetchMoviesByGenrefNetworkIsSatisfiedAndDatabaseIsEmpty() {
        networkMonitor.lastPathStatus = .satisfied

        databaseService.movies = []
        networkService.movies = MoviesFactory().makeMovies().shuffled()

        let genre = Genre(id: 0, name: "some genre")
        proxyService.fetchMovies(genre: genre) { [weak self] result in
            guard let self = self else {
                XCTFail("Expected alive self")
                return
            }
            guard case let .success(movies) = result else {
                XCTFail("Expected successfull response")
                return
            }

            XCTAssertTrue(movies == self.databaseService.movies, "Expected caching to database")
            XCTAssert(movies == self.networkService.movies, "Expected movies from network")
        }
    }

    func testFetchMoviesByGenreIfNetworkIsUnsatisfiedAndDatabaseIsFull() {
        networkMonitor.lastPathStatus = .unsatisfied

        databaseService.movies = MoviesFactory().makeMovies().shuffled()
        networkService.movies = []

        let genre = Genre(id: 0, name: "some genre")
        proxyService.fetchMovies(genre: genre) { [weak self] result in
            guard let self = self else {
                XCTFail("Expected alive self")
                return
            }
            guard case let .success(movies) = result else {
                XCTFail("Expected successfull response")
                return
            }

            XCTAssert(movies == self.databaseService.movies)
        }
    }
}
