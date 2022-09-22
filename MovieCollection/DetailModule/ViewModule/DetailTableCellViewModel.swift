//
//  DetailTableCellViewModel.swift
//  MovieCollection
//
//  Created by anita on 09.09.2022.
//

import Foundation
 
class DetailTableCellViewModel: CellViewModelType {
    
    var movie: Result
    var id: Int
    var image: URL?
    var title: String
    var rating: String
    var genres: String = ""
    var originalLanguage: String
    var overview: String
    var releaseDate: String = ""
    
    init(movie: Result, genre: GenreData) {
        self.movie = movie
        self.title = movie.title
        self.rating = "\(movie.voteAverage)/10 IMDb"
        self.originalLanguage = movie.originalLanguage
        self.id = movie.id
        self.overview = movie.overview
        self.releaseDate = truncateToYear(movie.releaseDate)
        self.image = makeImageURL(movie.posterPath)
        self.genres = getGenre(genreIds: movie.genreIDS, genreData: genre)
    }
    
    func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "https://image.tmdb.org/t/p/w500/\(imageCode)")
        
    }
    
    private func getGenre(genreIds: [Int], genreData: GenreData?) -> String {
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
