// Movie.swift
// Copyright © Taras Kotsur. All rights reserved.

import Foundation

/// Describes movie
struct Movie: Codable {
    // MARK: - Properties

    let id: Int
    let adult: Bool
    let backdropPath: String?
    let genres: [Int]
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backdropPath = "backdrop_path"
        case genres = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie {
    init(coreData: CDMovie) {
        id = coreData.id.toInt
        adult = coreData.adult
        backdropPath = coreData.backdropPath
        genres = coreData.genreIds ?? []
        originalLanguage = coreData.originalLanguage ?? ""
        originalTitle = coreData.originalTitle ?? ""
        overview = coreData.overview ?? ""
        popularity = coreData.popularity
        posterPath = coreData.posterPath
        releaseDate = coreData.releaseDate
        title = coreData.title ?? ""
        video = coreData.video
        voteAverage = coreData.voteAverage
        voteCount = coreData.voteCount.toInt
    }
}
