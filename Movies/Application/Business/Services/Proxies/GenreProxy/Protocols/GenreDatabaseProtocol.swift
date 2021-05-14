// GenreDatabaseProtocol.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol GenreDatabaseServiceProtocol: AnyObject {
    func saveGenres(genres: [Genre])
    func getGenre(id: Int, completion: @escaping (Result<Genre, Error>) -> Void)
    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void)
}
