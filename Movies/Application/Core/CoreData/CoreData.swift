// CoreData.swift
// Copyright © Taras Kotsur. All rights reserved.

import CoreData
import Foundation

protocol CoreDataProtocol: AnyObject {
    var context: NSManagedObjectContext { get }
    var privateContext: NSManagedObjectContext { get }
    func saveToStore()
}

final class CoreData: CoreDataProtocol {
    // MARK: - Properties

    private let modelName: String
    private let storeName: String

    private let storeDispatchGroup: DispatchGroup

    lazy var context: NSManagedObjectContext = {
        storeDispatchGroup.wait()

        return DispatchQueue.safeMain {
            let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            context.persistentStoreCoordinator = persistanceCoordinator
            return context
        }
    }()

    var privateContext: NSManagedObjectContext {
        storeDispatchGroup.wait()

        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = context
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }

    private lazy var persistanceCoordinator: NSPersistentStoreCoordinator = {
        NSPersistentStoreCoordinator(managedObjectModel: objectsModel)
    }()

    private lazy var objectsModel: NSManagedObjectModel = {
        guard let model = NSManagedObjectModel(contentsOf: objectsModelURL) else {
            fatalError("Error initizing mom from \(modelName)")
        }
        return model
    }()

    private lazy var objectsModelURL: URL = {
        guard let url = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        return url
    }()

    private lazy var documentsURL: URL = {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            fatalError("Unable to resolve document directory")
        }
        return url
    }()

    // MARK: - Initialzier

    private init(modelName: String, storeName: String) {
        self.modelName = modelName
        self.storeName = storeName
        storeDispatchGroup = DispatchGroup()

        registerStore()
    }

    // MARK: - Methods

    func saveToStore() {
        storeDispatchGroup.wait()

        DispatchQueue.safeMain {
            guard context.hasChanges else { return }

            do {
                try context.save()
                print("Context saved")
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }

    private func registerStore() {
        storeDispatchGroup.enter()

        DispatchQueue.global(qos: .background).async {
            do {
                let storeURL = self.documentsURL.appendingPathComponent(self.storeName)
                try self.persistanceCoordinator.addPersistentStore(
                    ofType: NSSQLiteStoreType,
                    configurationName: nil,
                    at: storeURL
                )
                self.storeDispatchGroup.leave()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}

extension CoreData: Sharable {
    static let shared: CoreDataProtocol = {
        let model = "Movies"
        let store = "Movies.sqlite"
        return CoreData(modelName: model, storeName: store)
    }()
}
