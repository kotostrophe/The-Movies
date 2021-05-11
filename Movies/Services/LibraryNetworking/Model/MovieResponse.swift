// MovieResponse.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Describes model which is uses for decoding network response data
struct MovieResponse: Codable {
    // MARK: - Properties

    let page: Int
    let movies: [Movie]
    let totalPages: Int
    let totalMovies: Int

    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages = "total_pages"
        case totalMovies = "total_results"
    }
}
