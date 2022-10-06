//
//  DetailTableCellViewModel.swift
//  MovieCollection
//
//  Created by anita on 09.09.2022.
//

import Foundation
 
final class DetailTableCellViewModel {
    
    var movie: Movie
    var id: Int
    var image: URL?
    var title: String
    var rating: String
    var genres: String = ""
    var originalLanguage: String
    var overview: String
    var releaseDate: String = ""
    var isFavorite: Bool
    var duration: String = ""
    
    init(movie: Movie) {
        self.movie = movie
        self.title = movie.title
        self.rating = String(format: "%.1f", movie.voteAverage)
        self.originalLanguage = movie.originalLanguage
        self.id = movie.id
        self.overview = movie.overview
        self.releaseDate = String(movie.releaseDate.dropLast(6))
        self.isFavorite = storage.isFavoriteItem(id: id)
        self.image = makeImageURL(movie.posterPath)
        self.genres = getGenreString(genreData: movie)
        self.duration = "\(movie.runtime)"
    }
    
// MARK: - Properties
    
    let storage = FavoriteMovieStorage()
}

// MARK: - Privite Methods

private extension DetailTableCellViewModel {
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
    
    func convertToHours(minutes: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [.hour, .minute]
        
        let formattedString = formatter.string(from: TimeInterval(minutes))!
        print(formattedString)
        return formattedString
        
    }
    func stringFromTimeInterval(time: Int) -> String {
        
        let minutes = (time / 60) % 60
        let hours = (time / 3600)
        
        return String(format: "%0.2d:%0.2d", hours, minutes)
        
    }
    
}
