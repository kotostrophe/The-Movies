// DetailsInfoModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Describes model of info of a film
struct DetailsInfoModel {
    // MARK: - Properties

    let releaseDate: String?
    let genresId: [Int]
    var genres: [Genre]
}
