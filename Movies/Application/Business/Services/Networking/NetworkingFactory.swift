// NetworkingFactory.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol NetworkingFactoryProtocol: AnyObject {
    func makeGenreNetworkingService() -> GenreNetworkServiceProtocol
    func makeLibraryNetworkingService() -> LibraryNetworkServiceProtocol
    func makeImageNetworkService() -> ImageNetworkServiceProtocol
    func makeDetailsNetworkServer() -> DetailsNetworkServiceProtocol
}

final class NetworkingFactory: NetworkingFactoryProtocol {
    func makeGenreNetworkingService() -> GenreNetworkServiceProtocol {
        GenreNetworkService()
    }

    func makeLibraryNetworkingService() -> LibraryNetworkServiceProtocol {
        LibraryNetworkService()
    }

    func makeImageNetworkService() -> ImageNetworkServiceProtocol {
        let networking = Networking(environment: .images)
        return ImageNetworkService(networking: networking)
    }

    func makeDetailsNetworkServer() -> DetailsNetworkServiceProtocol {
        DetailsNetworkService()
    }
}
