//
//  Genre.swift
//  MovieCollection
//
//  Created by anita on 10.09.2022.
//

import Foundation

// MARK: - GenreID
struct GenreData: Codable {
    let genres: [Genre]
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}
