// MockGenreNetworkService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies

final class MockGenreNetworkService: GenreNetworkServiceProtocol {
    var genres: [Genre]

    init(genres: [Genre]) {
        self.genres = genres
    }

    func fetchGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        completion(.success(genres))
    }
}
