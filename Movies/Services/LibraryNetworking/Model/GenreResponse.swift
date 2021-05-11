// GenreResponse.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Describes model which is uses for decoding network response data
struct GenreResponse: Codable {
    let genres: [Genre]
}
