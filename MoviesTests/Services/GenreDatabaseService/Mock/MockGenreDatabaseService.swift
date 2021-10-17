// MockGenreDatabaseService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies

enum MockGenreDatabaseServiceError: Error {
    case notFound
}

final class MockGenreDatabaseService: GenreDatabaseServiceProtocol {
    var genres: [Genre]

    init(genres: [Genre]) {
        self.genres = genres
    }

    func saveGenres(genres: [Genre]) {
        self.genres.append(contentsOf: genres)
    }

    func getGenre(id: Int, completion: @escaping (Result<Genre, Error>) -> Void) {
        guard let genre = genres.first(where: { $0.id == id }) else {
            completion(.failure(MockGenreDatabaseServiceError.notFound))
            return
        }
        completion(.success(genre))
    }

    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        completion(.success(genres))
    }
}
