//
//  FavoriteMovie.swift
//  MovieCollection
//
//  Created by anita on 03.10.2022.
//

import Foundation

// MARK: - FavoriteMovie
struct Movie: Codable {
    let backdropPath: String
    let genres: [Genre]
    let id: Int
    let overview: String
    let posterPath: String
    let originalLanguage: String
    let releaseDate: String
    let runtime: Int
    let title: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres, id
        case originalLanguage = "original_language"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case runtime
        case title
        case voteAverage = "vote_average"
    }
}
