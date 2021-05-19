// LibraryModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Model for Library screen
struct LibraryModel {
    var movies: [Movie] = []
    var genres: [Genre] = []
    var selectedGenre: Genre?
}
