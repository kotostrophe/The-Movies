// CDMovie+CoreDataProperties.swift
// Copyright © Taras Kotsur. All rights reserved.

import CoreData
import Foundation

///
public extension CDMovie {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDMovie> {
        NSFetchRequest<CDMovie>(entityName: "CDMovie")
    }

    @NSManaged var id: Int64
    @NSManaged var adult: Bool
    @NSManaged var backdropPath: String?
    @NSManaged var genreIds: [Int]?
    @NSManaged var originalLanguage: String?
    @NSManaged var originalTitle: String?
    @NSManaged var overview: String?
    @NSManaged var popularity: Double
    @NSManaged var posterPath: String?
    @NSManaged var releaseDate: String?
    @NSManaged var title: String?
    @NSManaged var video: Bool
    @NSManaged var voteAverage: Double
    @NSManaged var voteCount: Int64
    @NSManaged var genres: NSSet?
}

///
public extension CDMovie {
    @objc(addGenresObject:)
    @NSManaged func addToGenres(_ value: CDGenre)

    @objc(removeGenresObject:)
    @NSManaged func removeFromGenres(_ value: CDGenre)

    @objc(addGenres:)
    @NSManaged func addToGenres(_ values: NSSet)

    @objc(removeGenres:)
    @NSManaged func removeFromGenres(_ values: NSSet)
}

extension CDMovie: Identifiable {}
