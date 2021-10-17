// GenreCoreDataService.swift
// Copyright © Taras Kotsur. All rights reserved.

//
//  GenreCoreDataService.swift
//  Movies
//
//  Created by Тарас Коцур on 14.05.2021.
//
import CoreData
import Foundation

protocol GenreCoreDataServiceProtocol: GenreDatabaseServiceProtocol {}

enum GenreCoreDataServiceError: Error {
    case genreNotFound
}

final class GenreCoreDataService: GenreCoreDataServiceProtocol {
    // MARK: - Properties

    private let coreData: CoreDataProtocol

    // MARK: - Initializer

    init(coreData: CoreDataProtocol) {
        self.coreData = coreData
    }

    // MARK: - Methods

    func saveGenres(genres: [Genre]) {
        let context = coreData.context
        genres.forEach { CDGenre.make(genre: $0, in: context) }
        coreData.saveToStore()
    }

    func getGenre(id: Int, completion: @escaping (Result<Genre, Error>) -> Void) {
        coreData.context.perform {
            let request: NSFetchRequest<CDGenre> = CDGenre.fetchRequest()
            request.predicate = NSPredicate(format: "id = %n", id)

            do {
                guard let genre = try request.execute().map({ Genre(coreData: $0) }).first
                else {
                    completion(.failure(GenreCoreDataServiceError.genreNotFound))
                    return
                }
                completion(.success(genre))
            } catch {
                completion(.failure(error))
            }
        }
    }

    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        coreData.context.perform {
            let request: NSFetchRequest<CDGenre> = CDGenre.fetchRequest()

            do {
                let genres = try request.execute().map { Genre(coreData: $0) }
                completion(.success(genres))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

extension GenreCoreDataService {
    static let shared: GenreCoreDataServiceProtocol = {
        let coreData = CoreData.shared
        return GenreCoreDataService(coreData: coreData)
    }()
}
