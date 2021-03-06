// DetailsNetworkService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol DetailsNetworkServiceProtocol: AnyObject {
    func fetchPosters(for movie: Movie, completion: @escaping (Result<[Poster], Error>) -> Void)
}

final class DetailsNetworkService: DetailsNetworkServiceProtocol {
    func fetchPosters(for movie: Movie, completion: @escaping (Result<[Poster], Error>) -> Void) {
        let params: [String: String] = [
            "api_key": "5fc2771c0dd981e40a71bb09d876d946"
        ]

        let request = NetworkingRequest.request(method: .get, route: "/movie/\(movie.id)/images", parameters: params)
        Networking.shared.perform(request: request) { response in
            response.decode(PostersResponse.self) { result in
                switch result {
                case let .data(data):
                    completion(.success(data.posters))

                case let .error(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
