// ImageProxyService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol ImageProxyServiceProtocol: AnyObject {
    func getImage(by path: String, completion: @escaping (Data?) -> Void)
}

final class ImageProxyService: ImageProxyServiceProtocol {
    // MARK: - Properties

    let networkService: NetworkingProtocol
    var cacheDictionary: [String: Data]

    // MARK: - Initializer

    private init(networkService: NetworkingProtocol, cacheDictionary: [String: Data]) {
        self.networkService = networkService
        self.cacheDictionary = cacheDictionary
    }

    // MARK: - Methods

    func getImage(by path: String, completion: @escaping (Data?) -> Void) {
        if let data = cacheDictionary[path] {
            completion(data as Data)
        } else {
            let request = NetworkingRequest.request(method: .get, route: path)
            networkService.perform(request: request, completion: { [weak self] response in
                switch response {
                case let .data(data):
                    self?.cacheDictionary[path] = data
                    completion(data)

                case .error:
                    completion(nil)
                }
            })
        }
    }
}

extension ImageProxyService: Shareble {
    static let shared: ImageProxyServiceProtocol = {
        let environment = NetworkingEnvironment.images
        let network = Networking(environment: environment)
        let cache = [String: Data]()

        return ImageProxyService(networkService: network, cacheDictionary: cache)
    }()
}
