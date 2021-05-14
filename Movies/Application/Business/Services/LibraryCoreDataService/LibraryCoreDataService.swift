// LibraryCoreDataService.swift
// Copyright © Taras Kotsur. All rights reserved.

import CoreData
import Foundation

protocol LibraryCoreDataServiceProtocol: LibraryDatabaseServiceProtocol {}

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

    func fetchMovies(
        with predicate: @escaping @autoclosure () -> NSPredicate?,
        completion: @escaping (Result<[Movie], Error>) -> ()
    ) {
        coreData.context.perform {
            let request: NSFetchRequest<CDMovie> = CDMovie.fetchRequest()
            request.predicate = predicate()

            do {
                let coreDataMovies = try request.execute().map { Movie(coreData: $0) }
                completion(.success(coreDataMovies))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func fetchMovies(with query: String, completion: @escaping (Result<[Movie], Error>) -> ()) {
        fetchMovies(with: nil, completion: completion)
    }

    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> ()) {
        fetchMovies(with: nil, completion: completion)
    }

    func fetchMovies(by genreId: Int, completion: @escaping (Result<[Movie], Error>) -> ()) {
        fetchMovies(with: nil, completion: { result in
            switch result {
            case let .success(movies):
                let filteredMovies = movies.filter { $0.genres.contains(genreId) }
                completion(.success(filteredMovies))

            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
}

extension LibraryCoreDataService: Shareble {
    static let shared: LibraryCoreDataServiceProtocol = {
        let coreData = CoreData.shared
        return LibraryCoreDataService(coreData: coreData)
    }()
}
