// ServiceFactory.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol ServiceFactoryProtocol: AnyObject {
    func makeNetworkingFactory() -> NetworkingFactoryProtocol
    func makeProxiesFactory() -> ProxiesFactoryProtocol
    func makeImageFileService() -> ImageFileServiceProtocol
}

final class ServiceFactory: ServiceFactoryProtocol {
    func makeNetworkingFactory() -> NetworkingFactoryProtocol {
        NetworkingFactory()
    }

    func makeProxiesFactory() -> ProxiesFactoryProtocol {
        ProxiesFactory()
    }
    
    func makeImageFileService() -> ImageFileServiceProtocol {
        return ImageFileService()
    }
}
