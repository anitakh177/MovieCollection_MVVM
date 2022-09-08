//
//  MainTableViewModel.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import Foundation

class MainViewModel: TableViewModelType {
    
    let dataFetchService = DataFetcherService()
    
    var nowPlayingModel: NowPlaying?
    var nowPlaying: Observable<[NowPlayingMovieCellViewModel]> = Observable(nil)
    var popularModel: PopularMovie?
    var popularMovie: Observable<[PopularMovieCellViewModel]> = Observable(nil)

    var sectionTitle: [String] {
        return ["Playing Now", "Popular"]
    }

    func numberOfSections() -> Int {
        return sectionTitle.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return popularModel?.results.count ?? 0
    }
    
   
    
    func getData() {
       /* dataFetchService.fetchnowMovie { [weak self] (result) in
            self?.nowPlayingModel = result
            self?.mapNowPlayingMovieData()
        }
        */
        
        dataFetchService.fetchMovie { [weak self] (result) in
            self?.popularModel = result
            self?.mapPopularMovieData()
        }
    }
    
    private func mapNowPlayingMovieData() {
        nowPlaying.value = self.nowPlayingModel?.results.compactMap({NowPlayingMovieCellViewModel(image: $0.posterPath, title: $0.title)})
    }
    
    private func mapPopularMovieData() {
        
        popularMovie.value = self.popularModel?.results.compactMap({ PopularMovieCellViewModel(movie: $0)
        })
        
    }
    
}
