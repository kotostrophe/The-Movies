// GenreProxyService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol GenreProxyServiceProtocol: AnyObject {
    func fetchGenre(by id: Int, completion: @escaping (Result<Genre, Error>) -> Void)
    func fetchGenres(completion: @escaping (Result<[Genre], Error>) -> Void)
}

enum GenreProxyServiceError: Error {
    case genreNotFound
}

final class GenreProxyService: GenreProxyServiceProtocol {
    // MARK: - Properties

    let networkMonitor: NetworkMonitorProtocol
    let networkService: GenreNetworkServiceProtocol
    let databaseService: GenreDatabaseServiceProtocol

    // MARK: - Initializer

    init(
        networkMonitor: NetworkMonitorProtocol,
        networkService: GenreNetworkServiceProtocol,
        databaseService: GenreDatabaseServiceProtocol
    ) {
        self.networkMonitor = networkMonitor
        self.networkService = networkService
        self.databaseService = databaseService

        self.networkMonitor.start()
    }

    // MARK: - Methods

    func fetchGenre(by id: Int, completion: @escaping (Result<Genre, Error>) -> Void) {
        switch networkMonitor.isSatisfied {
        case true:
            fetchGenres(completion: { result in
                switch result {
                case let .success(genres):
                    guard let genre = genres.first(where: { $0.id == id }) else {
                        completion(.failure(GenreProxyServiceError.genreNotFound))
                        return
                    }
                    completion(.success(genre))

                case let .failure(error):
                    completion(.failure(error))
                }
            })

        case false:
            databaseService.getGenre(id: id, completion: completion)
        }
    }

    func fetchGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        switch networkMonitor.isSatisfied {
        case true:
            networkService.fetchGenres(completion: { [weak self] result in
                if case let .success(genres) = result {
                    self?.databaseService.saveGenres(genres: genres)
                }
                completion(result)
            })

        case false:
            databaseService.getGenres(completion: completion)
        }
    }
}
