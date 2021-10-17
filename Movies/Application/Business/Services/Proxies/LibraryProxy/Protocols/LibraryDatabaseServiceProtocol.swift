// LibraryDatabaseServiceProtocol.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol LibraryDatabaseServiceProtocol: AnyObject {
    func save(movies: [Movie])
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovies(using query: String, completion: @escaping (Result<[Movie], Error>) -> Void)
    func fetchMovies(by genreId: Int, completion: @escaping (Result<[Movie], Error>) -> Void)
}
