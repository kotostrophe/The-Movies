// CDMovie+CoreDataClass.swift
// Copyright © Taras Kotsur. All rights reserved.

import CoreData
import Foundation

@objc(CDMovie)
public final class CDMovie: NSManagedObject {
    @discardableResult
    static func make(movie: Movie, in context: NSManagedObjectContext) -> CDMovie {
        let object = getUniqueInstance(from: movie.id.toInt64, in: context)
        object.id = movie.id.toInt64
        object.adult = movie.adult
        object.title = movie.title
        object.originalTitle = movie.originalTitle
        object.originalLanguage = movie.originalLanguage
        object.posterPath = movie.posterPath
        object.backdropPath = movie.backdropPath
        object.genreIds = movie.genres
        object.overview = movie.overview
        object.popularity = movie.popularity
        object.releaseDate = movie.releaseDate
        object.voteAverage = movie.voteAverage
        object.voteCount = movie.voteCount.toInt64

        debugPrint("Object created: \(type(of: self)) \(object.id)")

        return object
    }

    private static func getUniqueInstance(from id: Int64, in context: NSManagedObjectContext) -> CDMovie {
        typealias Entity = CDMovie

        let request: NSFetchRequest<Entity> = Entity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %i", id)

        let results = try? request.execute()
        guard let existed = results?.first else {
            debugPrint("\(type(of: Entity.self)) with \(id) already created")
            return Entity(entity: entity(), insertInto: context)
        }

        return existed
    }
}
