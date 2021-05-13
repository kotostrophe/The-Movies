// ImageFileService.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

protocol ImageFileServiceProtocol: AnyObject {
    func save(data: Data, with name: String) throws
    func fetchData(with name: String) -> Data?
}

///
enum ImageFileServiceError: Error {
    case failedToPreparePath
}

final class ImageFileService: ImageFileServiceProtocol {
    // MARK: - Properties

    private lazy var cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first

    // MARK: - Methods

    func save(data: Data, with name: String) throws {
        let path = try preparePath(with: name)
        FileManager.default.createFile(atPath: path, contents: data, attributes: nil)
    }

    func fetchData(with name: String) -> Data? {
        guard let path = try? preparePath(with: name) else { return nil }
        let url = URL(fileURLWithPath: path, isDirectory: false)
        return try? Data(contentsOf: url)
    }

    // MARK: - Private methods

    private func preparePath(with name: String) throws -> String {
        guard let path = cacheURL?.appendingPathComponent(name, isDirectory: false).path
        else { throw ImageFileServiceError.failedToPreparePath }
        return path
    }
}
