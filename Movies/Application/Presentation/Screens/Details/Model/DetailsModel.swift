// DetailsModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Model for Details screen
struct DetailsModel {
    let movie: Movie
    var posters: [Poster]
    var genres: [Genre]
    let components: [DetailsComponent]
}
