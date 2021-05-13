// LibraryNetworkService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Describe errors for local network service
enum LibraryNetworkServiceError: Error, LocalizedError {
    case failToDecode

    var errorDescription: String? {
        switch self {
        case .failToDecode: return "Failed to decode data from the server"
        }
    }
}

protocol LibraryNetworkServiceProtocol: AnyObject {
    func fetchMovies(genreId: Int?, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
}

final class LibraryNetworkService: LibraryNetworkServiceProtocol {
    func fetchMovies(
        genreId: Int? = nil,
        completion: @escaping (Result<[Movie], Error>) -> Void
    ) {
        var params: [String: String] = [
            "api_key": "5fc2771c0dd981e40a71bb09d876d946",
            "language": "en-US",
        ]

        if let genreId = genreId {
            params["with_genres"] = "\(genreId)"
        }

        let request = NetworkingRequest.request(method: .get, route: "/discover/movie", parameters: params)
        Networking.shared.perform(request: request, completion: { response in
            response.decode(MovieResponse.self, completion: { result in
                switch result {
                case let .data(data):
                    completion(.success(data.movies))

                case let .error(error):
                    completion(.failure(error))
                }
            })
        })
    }

    func fetchMovies(
        query: String,
        completion: @escaping (Result<[Movie], Error>) -> Void
    ) {
        let params: [String: String] = [
            "api_key": "5fc2771c0dd981e40a71bb09d876d946",
            "language": "en-US",
            "query": query,
        ]

        let request = NetworkingRequest.request(method: .get, route: "/search/movie", parameters: params)
        Networking.shared.perform(request: request, completion: { response in
            response.decode(MovieResponse.self, completion: { result in
                switch result {
                case let .data(data):
                    completion(.success(data.movies))

                case let .error(error):
                    completion(.failure(error))
                }
            })
        })
    }
}
