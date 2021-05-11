// NetworkingEnvironment.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Describe enviroments which will be used for requesting to network
enum NetworkingEnvironment: Int {
    case base, images

    var url: URL? {
        switch self {
        case .base: return URL(string: "https://api.themoviedb.org/3")
        case .images: return URL(string: "http://image.tmdb.org/t/p/w500")
        }
    }
}
