// Genre.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Describes genre
struct Genre: Codable {
    let id: Int
    let name: String
}

extension Genre {
    init(coreData: CDGenre) {
        id = coreData.id.toInt
        name = coreData.name ?? ""
    }
}
