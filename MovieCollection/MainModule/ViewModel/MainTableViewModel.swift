//
//  MainTableViewModel.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import Foundation

class MainViewModel: TableViewModelType {
    
    let dataFetchService = DataFetcherService()
    
   private var playingMovieModel: NowPlaying?
   private var popularMovieModel: PopularMovie?
   var genreData: GenreData?
   var playingMovieDataSource: Observable<[NowPlayingMovieCellViewModel]> = Observable(nil)
   var popularMovieDataSource: Observable<[PopularMovieCellViewModel]> = Observable(nil)
    
   
    var sectionTitle: [String] {
        return ["Playing Now", "Popular"]
    }

    func numberOfSections() -> Int {
        return sectionTitle.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return popularMovieModel?.results.count ?? 0
    }
    
   
    
    func getData() {
        
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        dataFetchService.fetchGenres { [weak self] (result) in
            self?.genreData = result
            dispatchGroup.leave()
        }
       
        dispatchGroup.enter()
        dataFetchService.fetchNowMovie { [weak self] (result) in
            self?.playingMovieModel = result
            self?.mapNowPlayingMovieData()
        }
        
        
        dataFetchService.fetchMovie { [weak self] (result) in
            self?.popularMovieModel = result
            self?.mapPopularMovieData()
            dispatchGroup.leave()
        }
        
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
        }
      
    }
    
    private func mapNowPlayingMovieData() {
        playingMovieDataSource.value = self.playingMovieModel?.results.compactMap({NowPlayingMovieCellViewModel(movie: $0)
        })
    }
    
    private func mapPopularMovieData() {
        guard let genreData = genreData else { return  }
        
        popularMovieDataSource.value = self.popularMovieModel?.results.compactMap({ PopularMovieCellViewModel(movie: $0, genre: genreData)
        })
       
    }

    
    func retriveMovieDetails(with id: Int) -> Result? {
        guard let movie = popularMovieModel?.results.first(where: {$0.id == id}) else {
            return nil
        }
        print("got popular movie id \(movie.id)")
        return movie
    }
    
    func retrievePlayingMovieDetailt(with id: Int) -> Result? {
       guard let movie = playingMovieModel?.results.first(where: {$0.id == id}) else {
            return nil
        }
         
        return movie
    }
    
}
