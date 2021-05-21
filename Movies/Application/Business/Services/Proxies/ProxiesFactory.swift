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
        let networking = Networking(environment: .images)
        let networkService = ImageNetworkService(networking: networking)
        let fileService = ImageFileService()

        return ImageProxyService(networkService: networkService, fileService: fileService)
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
