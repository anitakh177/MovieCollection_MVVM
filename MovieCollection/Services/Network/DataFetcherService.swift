//
//  DataFetcherService.swift
//  MovieCollection
//
//  Created by anita on 06.09.2022.
//

import Foundation

class DataFetcherService {
     
    var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchMovie(completion: @escaping (PopularMovie?) -> Void) {
        let urlMovie = "https://api.themoviedb.org/3/movie/popular?api_key=62d229b93c02da4c5355f1bfe7de1181&language=en-US"
        dataFetcher.fetchGenericJSONData(urlString: urlMovie, response: completion)
    }
    
    func fetchnowMovie(completion: @escaping(NowPlaying?) -> Void) {
        let urlMovie = "https://api.themoviedb.org/3/movie/now_playing?api_key=62d229b93c02da4c5355f1bfe7de1181&language=en-US"
        dataFetcher.fetchGenericJSONData(urlString: urlMovie, response: completion)
    }
    
    
}
