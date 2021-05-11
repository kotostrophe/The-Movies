// DetailsModel.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Describes ui components
enum DetailsComponent {
    case title, info, description
}

/// Model for Details screen
struct DetailsModel {
    // MARK: - Properties

    let movie: Movie
    let components: [DetailsComponent]
}
