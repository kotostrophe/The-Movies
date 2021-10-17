// Poster.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

struct Poster: Codable {
    let aspectRatio: Double
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let height: Int
    let width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case height
        case width
    }
}
