//
//  LibraryDatabaseServiceProtocol.swift
//  Movies
//
//  Created by Тарас Коцур on 14.05.2021.
//

import Foundation

protocol LibraryDatabaseServiceProtocol: AnyObject {
    func save(movies: [Movie])
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> ())
    func fetchMovies(by genreId: Int, completion: @escaping (Result<[Movie], Error>) -> ())
}
