// LibraryCoreDataService.swift
// Copyright © Taras Kotsur. All rights reserved.

import CoreData
import Foundation

protocol LibraryCoreDataServiceProtocol: LibraryDatabaseServiceProtocol {}

final class LibraryCoreDataService: LibraryCoreDataServiceProtocol {
    // MARK: - Properties

    private let coreData: CoreDataProtocol

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

    private func fetchMovies(
        with predicate: @escaping @autoclosure () -> NSPredicate?,
        completion: @escaping (Result<[Movie], Error>) -> Void
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

    func fetchMovies(using query: String, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let predicate = NSPredicate(format: "title CONTAINS %@", query)
        fetchMovies(with: predicate, completion: completion)
    }

    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        fetchMovies(with: nil, completion: completion)
    }

    func fetchMovies(by genreId: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        fetchMovies(with: nil) { result in
            switch result {
            case let .success(movies):
                let filteredMovies = movies.filter { $0.genres.contains(genreId) }
                completion(.success(filteredMovies))

            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

extension LibraryCoreDataService: Sharable {
    static let shared: LibraryCoreDataServiceProtocol = {
        let coreData = CoreData.shared
        return LibraryCoreDataService(coreData: coreData)
    }()
}
