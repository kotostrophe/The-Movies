// GenreProxyService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol GenreProxyServiceProtocol: AnyObject {
    func getGenre(by id: Int, completion: @escaping (Genre?) -> Void)
    func getGenres(completion: @escaping ([Genre]?) -> Void)
}

final class GenreProxyService: GenreProxyServiceProtocol {
    // MARK: - Properties

    let networkMonitor: NetworkMonitorProtocol
    let networkService: GenreNetworkServiceProtocol
    let databaseService: GenreDatabaseServiceProtocol

    // MARK: - Initializer

    private init(
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

    func getGenre(by id: Int, completion: @escaping (Genre?) -> Void) {
        switch networkMonitor.isSatisfied {
        case true:
            getGenres(completion: { genres in
                completion(genres?.first(where: { $0.id == id }))
            })

        case false:
            databaseService.getGenre(id: id, completion: { result in
                guard case let .success(genre) = result else { return }
                completion(genre)
            })
        }
    }

    func getGenres(completion: @escaping ([Genre]?) -> Void) {
        switch networkMonitor.isSatisfied {
        case true:
            networkService.fetchGenres(completion: { [weak self] result in
                guard case let .success(genres) = result else { return }
                self?.databaseService.saveGenres(genres: genres)
                completion(genres)
            })

        case false:
            databaseService.getGenres(completion: { result in
                guard case let .success(genres) = result else { return }
                completion(genres)
            })
        }
    }
}

extension GenreProxyService: Shareble {
    static let shared: GenreProxyServiceProtocol = {
        let networkMonitor = NetworkMonitor()
        let network = GenreNetworkService()
        let coreDataDatabase = GenreCoreDataService.shared

        return GenreProxyService(
            networkMonitor: networkMonitor,
            networkService: network,
            databaseService: coreDataDatabase
        )
    }()
}
