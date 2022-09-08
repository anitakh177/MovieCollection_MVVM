//
//  PopularMovieCellViewModel.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import Foundation

class PopularMovieCellViewModel {
    var title: String
    var image: URL?
    var rating: Double
    var releaseDate: String
    
    init(movie: Result) {
        self.title = movie.title
        self.rating = movie.voteAverage
        self.releaseDate = movie.releaseDate
        self.image = makeImageURL(movie.posterPath)
    }
    
    private func makeImageURL(_ imageCode: String) -> URL? {
       URL(string: "https://image.tmdb.org/t/p/w500/\(imageCode)")
    }
}
