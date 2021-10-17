// CDGenre+CoreDataProperties.swift
// Copyright © Taras Kotsur. All rights reserved.

import CoreData
import Foundation

///
public extension CDGenre {
    @nonobjc
    class func fetchRequest() -> NSFetchRequest<CDGenre> {
        NSFetchRequest<CDGenre>(entityName: "CDGenre")
    }

    @NSManaged var id: Int64
    @NSManaged var name: String?
    @NSManaged var movies: NSSet?
}

///
public extension CDGenre {
    @objc(addMoviesObject:)
    @NSManaged func addToMovies(_ value: CDMovie)

    @objc(removeMoviesObject:)
    @NSManaged func removeFromMovies(_ value: CDMovie)

    @objc(addMovies:)
    @NSManaged func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged func removeFromMovies(_ values: NSSet)
}

extension CDGenre: Identifiable {}
