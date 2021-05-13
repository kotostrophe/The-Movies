// GenreProxyService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol GenreProxyServiceProtocol: AnyObject {
    func getGenre(id: Int, completion: @escaping (Genre?) -> Void)
    func getGenres(completion: @escaping ([Genre]?) -> Void)
}

final class GenreProxyService: GenreProxyServiceProtocol {
    // MARK: - Properties

    let networkService: GenreNetworkServiceProtocol
    var cacheDictionary: [Int: Genre]

    // MARK: - Initializer

    private init(networkService: GenreNetworkServiceProtocol, cacheDictionary: [Int: Genre]) {
        self.networkService = networkService
        self.cacheDictionary = cacheDictionary
    }

    // MARK: - Methods

    func getGenre(id: Int, completion: @escaping (Genre?) -> Void) {
        if let data = cacheDictionary[id] {
            completion(data)
        } else {
            getGenres(completion: { genres in
                completion(genres?.first(where: { $0.id == id }))
            })
        }
    }

    func getGenres(completion: @escaping ([Genre]?) -> Void) {
        let data = cacheDictionary.values.compactMap { $0 }
        if !data.isEmpty {
            completion(data)
        } else {
            networkService.fetchGenres(completion: { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .success(genres):
                    genres.forEach {
                        self.cacheDictionary[$0.id] = $0
                    }

                    completion(genres)

                case .failure:
                    completion(nil)
                }
            })
        }
    }
}

extension GenreProxyService: Shareble {
    static let shared: GenreProxyServiceProtocol = {
        let environment = NetworkingEnvironment.base
        let network = GenreNetworkService()
        let cache = [Int: Genre]()

        return GenreProxyService(networkService: network, cacheDictionary: cache)
    }()
}
