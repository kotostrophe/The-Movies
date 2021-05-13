// ProxiesFactory.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol ProxiesFactoryProtocol: AnyObject {
    func makeImageProxyService() -> ImageProxyServiceProtocol
    func makeGenreProxyService() -> GenreProxyServiceProtocol
}

final class ProxiesFactory: ProxiesFactoryProtocol {
    func makeImageProxyService() -> ImageProxyServiceProtocol {
        ImageProxyService.shared
    }

    func makeGenreProxyService() -> GenreProxyServiceProtocol {
        GenreProxyService.shared
    }
}
