// MockLibraryDatabaseService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies
import XCTest

final class MockLibraryDatabaseService: LibraryDatabaseServiceProtocol {
    var movies: [Movie]

    init(movies: [Movie]) {
        self.movies = movies
    }

    func save(movies: [Movie]) {
        self.movies.append(contentsOf: movies)
    }

    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        completion(.success(movies))
    }

    func fetchMovies(using query: String, completion: @escaping (Result<[Movie], Error>) -> ()) {
        completion(.success(movies))
    }

    func fetchMovies(by genreId: Int, completion: @escaping (Result<[Movie], Error>) -> ()) {
        completion(.success(movies))
    }
}
