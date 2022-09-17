//
//  PopularMovieCellViewModel.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import Foundation

class PopularMovieCellViewModel: CellViewModelType {
    
    var movieID: Int
    var title: String
    var image: URL?
    var rating: Double
    var releaseDate: String
    var genres: String = ""
    
    init(movie: Result, genre: GenreData) {
        self.movieID = movie.id
        self.title = movie.title
        self.rating = movie.voteAverage
        self.releaseDate = movie.releaseDate
        self.genres = getGenre(genreIds: movie.genreIDS, genreData: genre)
        self.image = makeImageURL(movie.posterPath)
      
        
    }
    
    func makeImageURL(_ imageCode: String) -> URL? {
       URL(string: "https://image.tmdb.org/t/p/w500/\(imageCode)")
    }
    func getGenre(genreIds : [Int], genreData: GenreData?) -> String {
                var genreString = ""
                for genreId in genreIds {
                    if let geners = (genreData?.genres) {
                        for genre in geners {
                            if genreId == genre.id {
                                genreString += genre.name + ", "
                                continue
                            }
                        }
                    }
                }
                return String(genreString.dropLast(2))
            }

}
