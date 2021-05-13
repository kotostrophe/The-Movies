// ImageProxyService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol ImageProxyServiceProtocol: AnyObject {
    func getImage(by path: String, completion: @escaping (Data?) -> Void)
}

final class ImageProxyService: ImageProxyServiceProtocol {
    // MARK: - Properties

    let networkService: NetworkingProtocol
    let fileService: ImageFileServiceProtocol
    var cacheDictionary: [String: Data]

    // MARK: - Initializer

    private init(
        networkService: NetworkingProtocol,
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
                let request = NetworkingRequest.request(method: .get, route: "/" + path)
                networkService.perform(request: request, completion: { [weak self] response in
                    switch response {
                    case let .data(data):
                        self?.cacheDictionary[path] = data
                        try? self?.fileService.save(data: data, with: path)
                        completion(data)

                    case .error:
                        completion(nil)
                    }
                })
            }
        }
    }
}

extension ImageProxyService: Shareble {
    static let shared: ImageProxyServiceProtocol = {
        let environment = NetworkingEnvironment.images
        let network = Networking(environment: environment)
        let fileService = ImageFileService()
        let cache = [String: Data]()

        return ImageProxyService(networkService: network, fileService: fileService, cacheDictionary: cache)
    }()
}
