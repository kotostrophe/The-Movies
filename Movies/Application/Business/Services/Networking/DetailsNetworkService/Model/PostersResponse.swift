// PostersResponse.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

///
struct PostersResponse: Codable {
    let id: Int
    let posters: [Poster]
}
