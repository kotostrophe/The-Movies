// MockImageNetworkService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies

final class MockImageNetworkService: ImageNetworkServiceProtocol {
    var image: Data?

    func fetchImage(by name: String, completion: @escaping (Data?) -> Void) {
        completion(image)
    }
}
