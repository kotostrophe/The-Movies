// GenreNetworkService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol GenreNetworkServiceProtocol: AnyObject {
    func fetchGenres(completion: @escaping (Result<[Genre], Error>) -> Void)
}

final class GenreNetworkService: GenreNetworkServiceProtocol {
    func fetchGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        let params: [String: String] = [
            "api_key": "5fc2771c0dd981e40a71bb09d876d946",
            "language": "en-US"
        ]

        let request = NetworkingRequest.request(method: .get, route: "/genre/movie/list", parameters: params)
        Networking.shared.perform(request: request) { response in
            response.decode(GenreResponse.self) { result in
                switch result {
                case let .data(data):
                    completion(.success(data.genres))

                case let .error(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
