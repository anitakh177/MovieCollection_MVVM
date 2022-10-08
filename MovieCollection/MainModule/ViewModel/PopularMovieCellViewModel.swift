//
//  PopularMovieCellViewModel.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import Foundation

final class PopularMovieCellViewModel: CellViewModelType {
    
    var movieID: Int
    var title: String
    var image: URL?
    var rating: String
    var releaseDate: String = ""
    var genres: String = ""
    
    init(movie: Movie) {
        self.movieID = movie.id
        self.title = movie.title
        self.rating = String(format: "%.1f", movie.voteAverage)
        self.releaseDate = String(movie.releaseDate.dropLast(6))
        self.genres = getGenreString(genreData: movie)
        self.image = makeImageURL(movie.posterPath)
        
    }
    
    func getGenreString(genreData: Movie?) -> String {
        var genreString = ""
        
        for genre in genreData!.genres {
            genreString += genre.name + ", "
            continue
        }
        return String(genreString.dropLast(2))
    }
    
    func makeImageURL(_ imageCode: String) -> URL? {
       URL(string: "https://image.tmdb.org/t/p/w500/\(imageCode)")
    }
   
}
