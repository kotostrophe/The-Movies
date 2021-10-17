// Genre.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

struct Genre: Codable {
    let id: Int
    let name: String
}

extension Genre: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

extension Genre {
    init(coreData: CDGenre) {
        id = coreData.id.toInt
        name = coreData.name ?? ""
    }
}
