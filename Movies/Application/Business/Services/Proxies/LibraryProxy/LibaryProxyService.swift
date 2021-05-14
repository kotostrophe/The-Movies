// LibaryProxyService.swift
// Copyright © Taras Kotsur. All rights reserved.

import CoreData
import Foundation

protocol LibaryProxyServiceProtocol: AnyObject {}

final class LibraryProxyService: LibaryProxyServiceProtocol {
    // MARK: - Properties
    
    let networkMonitor: NetworkMonitorProtocol
    let networkService: LibraryNetworkServiceProtocol
    let databaseService: LibraryDatabaseServiceProtocol

    // MARK: - Initializer

    init(networkMonitor: NetworkMonitorProtocol, networkService: LibraryNetworkServiceProtocol, databaseService: LibraryDatabaseServiceProtocol) {
        self.networkMonitor = networkMonitor
        self.networkService = networkService
        self.databaseService = databaseService
    }
    
    // MARK: - Methods

}
