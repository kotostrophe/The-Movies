// LibraryModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Model for Library screen
struct LibraryModel {
    // MARK: - Properties

    var movies: [Movie] = []
    var genres: [Genre] = []
    var selectedGenre: Genre?
}
