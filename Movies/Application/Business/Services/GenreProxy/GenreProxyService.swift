// GenreProxyService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol GenreProxyServiceProtocol: AnyObject {
    func getGenre(id: Int, completion: @escaping (Genre?) -> Void)
    func getGenres(completion: @escaping ([Genre]?) -> Void)
}

final class GenreProxyService: GenreProxyServiceProtocol {
    // MARK: - Properties

    let networkService: NetworkingProtocol
    var cacheDictionary: [Int: Genre]

    // MARK: - Initializer

    private init(networkService: NetworkingProtocol, cacheDictionary: [Int: Genre]) {
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
            let params: [String: String] = [
                "api_key": "5fc2771c0dd981e40a71bb09d876d946",
                "language": "en-US",
            ]

            let request = NetworkingRequest.request(method: .get, route: "/genre/movie/list", parameters: params)
            networkService.perform(request: request, completion: { [weak self] result in
                switch result {
                case let .success(data):
                    guard let response = try? JSONDecoder().decode(GenreResponse.self, from: data) else {
                        completion(nil)
                        return
                    }

                    completion(response.genres)

                    response.genres.forEach {
                        self?.cacheDictionary[$0.id] = $0
                    }

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
        let network = Networking(environment: environment)
        let cache = [Int: Genre]()

        return GenreProxyService(networkService: network, cacheDictionary: cache)
    }()
}
