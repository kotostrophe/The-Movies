// ItemsServiceFactory.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol ItemsServiceFactoryProtocol: AnyObject {
    func makeLibraryItemsService() -> LibraryItemsServiceProtocol
}

final class ItemsServiceFactory: ItemsServiceFactoryProtocol {
    // MARK: - Methods

    func makeLibraryItemsService() -> LibraryItemsServiceProtocol {
        LibraryItemsService()
    }
}
