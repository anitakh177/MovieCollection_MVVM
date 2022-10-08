//
//  DataFetcherService.swift
//  MovieCollection
//
//  Created by anita on 06.09.2022.
//

import Foundation

final class DataFetcherService {
    
    private let apiKey = "62d229b93c02da4c5355f1bfe7de1181"
    var dataFetcher: DataFetcher
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.dataFetcher = dataFetcher
    }
    
    func fetchPopularMovie(completion: @escaping (MovieResult?) -> Void) {
        let urlMovie = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US"
        dataFetcher.fetchGenericJSONData(urlString: urlMovie, response: completion)
    }
    
    func fetchNowMovie(completion: @escaping(MovieResult?) -> Void) {
        let urlMovie = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US"
        dataFetcher.fetchGenericJSONData(urlString: urlMovie, response: completion)
    }
    
    func fetchCast(movieID: Int, completin: @escaping(Cast?) -> Void) {
        let urlCast = "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=\(apiKey)&language=en-US"
        dataFetcher.fetchGenericJSONData(urlString: urlCast, response: completin)
    }
    
    func searchMovie(text: String, completion: @escaping(MovieResult?) -> Void) {
        let encodedText = text.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlSearch =  String(format: "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&language=en-US&query=%@", encodedText)
        dataFetcher.fetchGenericJSONData(urlString: urlSearch, response: completion)
    }
    
    func getMovieDetails(id: Int, completion: @escaping(Movie?) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)"
        dataFetcher.fetchGenericJSONData(urlString: url, response: completion)
    }
    
}
