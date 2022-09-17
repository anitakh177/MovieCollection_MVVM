//
//  CastImage.swift
//  MovieCollection
//
//  Created by anita on 14.09.2022.
//

import Foundation

// MARK: - CastImage
struct CastImage: Codable {
    let id: Int
    let profiles: [Profile]
}

// MARK: - Profile
struct Profile: Codable {
    let file_path: String

}
