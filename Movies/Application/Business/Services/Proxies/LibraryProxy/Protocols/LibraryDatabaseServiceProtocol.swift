// LibraryDatabaseServiceProtocol.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol LibraryDatabaseServiceProtocol: AnyObject {
    func save(movies: [Movie])
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> ())
    func fetchMovies(with query: String, completion: @escaping (Result<[Movie], Error>) -> ())
    func fetchMovies(by genreId: Int, completion: @escaping (Result<[Movie], Error>) -> ())
}
