// MockImageFileService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies

final class MockImageFileService: ImageFileServiceProtocol {
    var data: Data?

    func save(data: Data, with name: String) throws {
        self.data = data
    }

    func fetchData(with name: String) -> Data? {
        data
    }
}
