// LibraryCoreDataService.swift
// Copyright © Taras Kotsur. All rights reserved.

import CoreData
import Foundation

protocol LibraryCoreDataServiceProtocol: AnyObject {
    func save(movies: [Movie])
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> ())
    func fetchMovies(by genreId: Int, completion: @escaping (Result<[Movie], Error>) -> ())
}

final class LibraryCoreDataService: LibraryCoreDataServiceProtocol {
    // MARK: - Properties

    let coreData: CoreDataProtocol

    // MARK: - Initializer

    init(coreData: CoreDataProtocol) {
        self.coreData = coreData
    }

    // MARK: - Methods

    func save(movies: [Movie]) {
        let context = coreData.context
        movies.forEach { CDMovie.make(movie: $0, in: context) }
        coreData.saveToStore()
    }

    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        coreData.context.perform {
            let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()

            do {
                let coreDataMovies = try request.execute().map { Movie(coreData: $0) }
                completion(.success(coreDataMovies))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func fetchMovies(by genreId: Int, completion: @escaping (Result<[Movie], Error>) -> ()) {
        coreData.context.perform {
            let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
            request.predicate = NSPredicate(format: "ANY genreIds = %i", genreId)

            do {
                let coreDataMovies = try request.execute().map { Movie(coreData: $0) }
                completion(.success(coreDataMovies))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
