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

    // MARK: - Initializer

    private init(
        networkService: ImageNetworkServiceProtocol,
        fileService: ImageFileServiceProtocol
    ) {
        self.networkService = networkService
        self.fileService = fileService
    }

    // MARK: - Methods

    func getImage(by path: String, completion: @escaping (Data?) -> Void) {
        switch fileService.fetchData(with: path) {
        case let .some(data):
            completion(data)

        case .none:
            networkService.fetchImage(by: path, completion: { [weak self] data in
                guard let self = self else { return }
                guard let data = data else {
                    completion(nil)
                    return
                }

                try? self.fileService.save(data: data, with: path)
                completion(data)
            })
        }
    }
}

extension ImageProxyService: Shareble {
    static let shared: ImageProxyServiceProtocol = {
        let networkService = ImageNetworkService.shared
        let fileService = ImageFileService()

        return ImageProxyService(networkService: networkService, fileService: fileService)
    }()
}
