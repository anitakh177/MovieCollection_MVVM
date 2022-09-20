//
//  MainTableViewModel.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import Foundation

class MainViewModel: TableViewModelType {
    weak var appCoordinator: AppCoordinator!
    
    let dataFetchService = DataFetcherService()
    
 //  private var playingMovieModel: NowPlaying?
   private var movieModel: Movie?
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
        return movieModel?.results.count ?? 0
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
            self?.movieModel = result
            self?.mapNowPlayingMovieData()
        }
        
        
        dataFetchService.fetchPopularMovie { [weak self] (result) in
            self?.movieModel = result
            self?.mapPopularMovieData()
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
        }
      
    }
    
    private func mapNowPlayingMovieData() {
        playingMovieDataSource.value = self.movieModel?.results.compactMap({NowPlayingMovieCellViewModel(movie: $0)
        })
    }
    
    private func mapPopularMovieData() {
        guard let genreData = genreData else { return  }
        
        popularMovieDataSource.value = self.movieModel?.results.compactMap({ PopularMovieCellViewModel(movie: $0, genre: genreData)
        })
       
    }

    
    func retrivePopulerMovieDetails(with id: Int) -> Result? {
        guard let movie = movieModel?.results.first(where: {$0.id == id}) else {
            return nil
        }
        return movie
    }
    
     func goToSearchViewController() {
        appCoordinator.goToSearchViewController()
    }
}
