// MockLibraryNetworkService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies
import XCTest

final class MockLibraryNetworkService: LibraryNetworkServiceProtocol {
    var movies: [Movie]

    init(movie: [Movie]) {
        movies = movie
    }

    func fetchMovies(genreId: Int?, completion: @escaping (Result<[Movie], Error>) -> Void) {
        completion(.success(movies))
    }

    func fetchMovies(query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        completion(.success(movies))
    }
}
