// CDGenre+CoreDataClass.swift
// Copyright © Taras Kotsur. All rights reserved.

import CoreData
import Foundation

@objc(CDGenre)
public final class CDGenre: NSManagedObject {
    @discardableResult
    static func make(genre: Genre, in context: NSManagedObjectContext) -> CDGenre {
        let object = getUniqueInstance(from: genre.id.toInt64, in: context)
        object.id = genre.id.toInt64
        object.name = genre.name

        debugPrint("Object created: \(type(of: self)) \(object.id)")

        return object
    }

    private static func getUniqueInstance(from id: Int64, in context: NSManagedObjectContext) -> CDGenre {
        typealias Entity = CDGenre

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
