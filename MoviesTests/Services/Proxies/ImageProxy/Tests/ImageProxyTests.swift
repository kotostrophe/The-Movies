// ImageProxyTests.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies
import XCTest

// swiftlint:disable implicitly_unwrapped_optional

final class ImageProxyTests: XCTestCase {
    // MARK: - Properties

    var imageFileService: MockImageFileService!
    var networkService: MockImageNetworkService!

    var imageProxyService: ImageProxyService!

    // MARK: - Setup methods

    override func setUp() {
        super.setUp()

        imageFileService = MockImageFileService()
        networkService = MockImageNetworkService()
        imageProxyService = ImageProxyService(networkService: networkService, fileService: imageFileService)
    }

    override func tearDown() {
        imageFileService = nil
        networkService = nil
        imageProxyService = nil

        super.tearDown()
    }

    // MARK: - Methods

    func testFetchingImageDataDirectlyFromFileService() {
        imageFileService.data = Data()

        imageProxyService.getImage(by: "some path") { [weak self] data in
            guard let self = self else {
                XCTFail("Expected alive self")
                return
            }
            guard let data = data else {
                XCTFail("Expected successfull response")
                return
            }

            XCTAssert(data == self.imageFileService.data, "Extected data from file service")
        }
    }

    func testFetchingImageDataDirectlyFromNetworkService() {
        imageFileService.data = nil
        networkService.image = Data()

        imageProxyService.getImage(by: "some path") { [weak self] data in
            guard let self = self else {
                XCTFail("Expected alive self")
                return
            }
            guard let data = data else {
                XCTFail("Expected successfull response")
                return
            }

            XCTAssert(data == self.imageFileService.data, "Caching data to file service doesn't work")
            XCTAssert(data == self.networkService.image, "Expected image data from network service")
        }
    }
}
