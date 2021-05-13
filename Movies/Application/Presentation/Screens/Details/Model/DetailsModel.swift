// DetailsModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Enumeration of states at Details screen
enum DetailsModel {
    case loading, data(Data), error(Error)

    /// Model for Details screen
    struct Data {
        let movie: Movie
        let genres: [Genre]
        let components: [DetailsComponent]
    }
}
