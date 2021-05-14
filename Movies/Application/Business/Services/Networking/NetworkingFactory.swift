// NetworkingFactory.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol NetworkingFactoryProtocol: AnyObject {
    func makeGenreNetworkingService() -> GenreNetworkServiceProtocol
    func makeLibraryNetworkingService() -> LibraryNetworkServiceProtocol
}

final class NetworkingFactory: NetworkingFactoryProtocol {
    func makeGenreNetworkingService() -> GenreNetworkServiceProtocol {
        GenreNetworkService()
    }

    func makeLibraryNetworkingService() -> LibraryNetworkServiceProtocol {
        LibraryNetworkService()
    }

    func makeImageNetworkService() -> ImageNetworkServiceProtocol {
        ImageNetworkService.shared
    }
}
