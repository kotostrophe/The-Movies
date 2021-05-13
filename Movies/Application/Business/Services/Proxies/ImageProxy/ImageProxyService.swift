// ImageProxyService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol ImageProxyServiceProtocol: AnyObject {
    func getImage(by path: String, completion: @escaping (Data?) -> Void)
}

final class ImageProxyService: ImageProxyServiceProtocol {
    // MARK: - Properties

    let networkService: ImageNetworkServiceProtocol
    let fileService: ImageFileServiceProtocol
    var cacheDictionary: [String: Data]

    // MARK: - Initializer

    private init(
        networkService: ImageNetworkServiceProtocol,
        fileService: ImageFileServiceProtocol,
        cacheDictionary: [String: Data]
    ) {
        self.networkService = networkService
        self.fileService = fileService
        self.cacheDictionary = cacheDictionary
    }

    // MARK: - Methods

    func getImage(by path: String, completion: @escaping (Data?) -> Void) {
        switch cacheDictionary[path] {
        case let .some(data):
            completion(data)

        case .none:
            switch fileService.fetchData(with: path) {
            case let .some(data):
                cacheDictionary[path] = data
                completion(data)

            case .none:
                networkService.fetchImage(by: path, completion: { [weak self] data in
                    guard let self = self else { return }
                    guard let data = data else {
                        completion(nil)
                        return
                    }

                    self.cacheDictionary[path] = data
                    try? self.fileService.save(data: data, with: path)
                    completion(data)
                })
            }
        }
    }
}

extension ImageProxyService: Shareble {
    static let shared: ImageProxyServiceProtocol = {
        let networkService = ImageNetworkService.shared
        let fileService = ImageFileService()
        let cache = [String: Data]()

        return ImageProxyService(networkService: networkService, fileService: fileService, cacheDictionary: cache)
    }()
}
