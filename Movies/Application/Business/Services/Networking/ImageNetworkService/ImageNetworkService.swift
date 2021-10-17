// ImageNetworkService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol ImageNetworkServiceProtocol: AnyObject {
    func fetchImage(by name: String, completion: @escaping (Data?) -> Void)
}

final class ImageNetworkService: ImageNetworkServiceProtocol {
    // MARK: - Properties

    let networking: NetworkingProtocol

    // MARK: - Initializer

    init(networking: NetworkingProtocol) {
        self.networking = networking
    }

    // MARK: - Methods

    func fetchImage(by name: String, completion: @escaping (Data?) -> Void) {
        let request = NetworkingRequest.request(method: .get, route: "/" + name)
        networking.perform(request: request) { response in
            switch response {
            case let .data(data): completion(data)
            case .error: completion(nil)
            }
        }
    }
}
