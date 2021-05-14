// ProxiesFactory.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol ProxiesFactoryProtocol: AnyObject {
    func makeImageProxyService() -> ImageProxyServiceProtocol
    func makeGenreProxyService() -> GenreProxyServiceProtocol
    func makeLibraryProxyService() -> LibraryProxyServiceProtocol
}

final class ProxiesFactory: ProxiesFactoryProtocol {
    func makeImageProxyService() -> ImageProxyServiceProtocol {
        ImageProxyService.shared
    }

    func makeLibraryProxyService() -> LibraryProxyServiceProtocol {
        let networkMonitor = NetworkMonitor()
        let network = LibraryNetworkService()
        let coreDataDatabase = LibraryCoreDataService.shared

        return LibraryProxyService(
            networkMonitor: networkMonitor,
            networkService: network,
            databaseService: coreDataDatabase
        )
    }

    func makeGenreProxyService() -> GenreProxyServiceProtocol {
        let networkMonitor = NetworkMonitor()
        let network = GenreNetworkService()
        let coreDataDatabase = GenreCoreDataService.shared

        return GenreProxyService(
            networkMonitor: networkMonitor,
            networkService: network,
            databaseService: coreDataDatabase
        )
    }
}
