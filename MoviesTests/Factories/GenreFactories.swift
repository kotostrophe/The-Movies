// GenreFactories.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation
@testable import Movies

final class GenreFactory {
    func makeGenres() -> [Genre] {
        [
            Genre(id: 0, name: "Adventure"),
            Genre(id: 1, name: "Cartoon"),
            Genre(id: 2, name: "Documentary")
        ]
    }
}
