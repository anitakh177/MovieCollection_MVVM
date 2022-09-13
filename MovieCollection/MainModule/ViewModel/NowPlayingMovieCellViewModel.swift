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
    
    init(movie: Result) {
        
        self.title = movie.title
        self.image = makeImageURL(movie.posterPath)
    }
    
    func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "https://image.tmdb.org/t/p/w500/\(imageCode)")
    }
}
