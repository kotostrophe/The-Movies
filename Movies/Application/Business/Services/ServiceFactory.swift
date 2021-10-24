// ServiceFactory.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol ServiceFactoryProtocol: AnyObject {
    func makeNetworkingFactory() -> NetworkingFactoryProtocol
    func makeProxiesFactory() -> ProxiesFactoryProtocol
    func makeImageFileService() -> ImageFileServiceProtocol
    func makeItemsServiceFactory() -> ItemsServiceFactoryProtocol
}

final class ServiceFactory: ServiceFactoryProtocol {
    // MARK: - Initializer

    private init() {}

    // MARK: - Methods

    func makeNetworkingFactory() -> NetworkingFactoryProtocol {
        NetworkingFactory()
    }

    func makeProxiesFactory() -> ProxiesFactoryProtocol {
        ProxiesFactory()
    }

    func makeImageFileService() -> ImageFileServiceProtocol {
        ImageFileService()
    }

    func makeItemsServiceFactory() -> ItemsServiceFactoryProtocol {
        ItemsServiceFactory()
    }
}

extension ServiceFactory: Sharable {
    static let shared: ServiceFactoryProtocol = ServiceFactory()
}
