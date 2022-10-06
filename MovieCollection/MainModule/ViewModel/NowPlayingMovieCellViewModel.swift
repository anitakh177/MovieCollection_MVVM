//
//  PopularMovieCellViewModel.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import Foundation

class NowPlayingMovieCellViewModel: CellViewModelType {
    
    var image: URL?
    var title: String
    var movieID: Int
    
    init(movie: Movie) {
        
        self.title = movie.title
        self.movieID = movie.id

        self.image = makeImageURL(movie.posterPath)
    }
    
    func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "https://image.tmdb.org/t/p/w500/\(imageCode)")
    }
}
