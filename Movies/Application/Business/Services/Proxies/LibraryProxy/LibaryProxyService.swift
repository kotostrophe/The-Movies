// LibaryProxyService.swift
// Copyright © Taras Kotsur. All rights reserved.

import CoreData
import Foundation

protocol LibraryProxyServiceProtocol: AnyObject {
    func fetchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> ())
    func fetchMovies(genre: Genre, completion: @escaping (Result<[Movie], Error>) -> ())
}

final class LibraryProxyService: LibraryProxyServiceProtocol {
    // MARK: - Properties

    let networkMonitor: NetworkMonitorProtocol
    let networkService: LibraryNetworkServiceProtocol
    let databaseService: LibraryDatabaseServiceProtocol

    // MARK: - Initializer

    init(
        networkMonitor: NetworkMonitorProtocol,
        networkService: LibraryNetworkServiceProtocol,
        databaseService: LibraryDatabaseServiceProtocol
    ) {
        self.networkMonitor = networkMonitor
        self.networkService = networkService
        self.databaseService = databaseService

        self.networkMonitor.start()
    }

    // MARK: - Methods

    func fetchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> ()) {
        switch networkMonitor.isSatisfied {
        case true:
            networkService.fetchMovies(query: query, completion: { [weak self] result in
                if case let .success(data) = result {
                    self?.databaseService.save(movies: data)
                }
                completion(result)
            })

        case false:
            databaseService.fetchMovies(with: query, completion: completion)
        }
    }

    func fetchMovies(genre: Genre, completion: @escaping (Result<[Movie], Error>) -> ()) {
        switch networkMonitor.isSatisfied {
        case true:
            networkService.fetchMovies(genreId: genre.id, completion: { [weak self] result in
                if case let .success(data) = result {
                    self?.databaseService.save(movies: data)
                }
                completion(result)
            })

        case false:
            databaseService.fetchMovies(by: genre.id, completion: completion)
        }
    }
}
