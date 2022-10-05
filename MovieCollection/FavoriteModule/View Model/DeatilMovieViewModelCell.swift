//
//  DeatilMovieViewModelCell.swift
//  MovieCollection
//
//  Created by anita on 03.10.2022.
//

import Foundation

class DeatilMovieViewModelCell {
    
    var movieID: Int
    var title: String
    var image: URL?
    var rating: Double
    var releaseDate: String = ""
    var genres: String = ""
    
    init(movie: FavoriteMovie) {
        self.movieID = movie.id
        self.title = movie.title
        self.rating = movie.voteAverage
        self.genres = getNewGenres(genreData: movie)
        self.releaseDate = truncateToYear(movie.releaseDate)
        
        self.image = makeImageURL(movie.posterPath)
        
    }
    
    func makeImageURL(_ imageCode: String) -> URL? {
       URL(string: "https://image.tmdb.org/t/p/w500/\(imageCode)")
    }
    
    func getNewGenres(genreData: FavoriteMovie?) -> String {
        var genreString = ""
        
        for genre in genreData!.genres {
            genreString += genre.name + ", "
            continue
        }
        return String(genreString.dropLast(2))
    }
    
    func getGenre(genreIds: [Int], genreData: FavoriteMovie?) -> String {
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
    func truncateToYear(_ date: String) -> String {
        return date.truncate(length: 4)
    }
}
