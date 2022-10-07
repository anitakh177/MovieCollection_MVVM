//
//  MainTableViewModel.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import Foundation

class MainViewModel: TableViewModelType {
    
    // MARK: - Properties

    private let dataFetchService = DataFetcherService()
    private var movieModel: MovieResult?
    private var movieArray: [Movie] = []
    var playingMovieDataSource: Observable<[NowPlayingMovieCellViewModel]> = Observable(nil)
    var popularMovieDataSource: Observable<[PopularMovieCellViewModel]> = Observable(nil)
    
    var sectionTitle: [String] {
        return ["Playing Now", "Popular"]
    }
    
    // MARK: - Delegate
    
    weak var appCoordinator: AppCoordinator!
    weak var coordinator: MainViewCoordinator!
    
    // MARK: - Methods
    
    func numberOfSections() -> Int {
        return sectionTitle.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return movieModel?.results.count ?? 0
    }
    
    func retrieveFavoriteMovies() -> [Int] {
        dataFetchService.fetchNowMovie { [weak self] (result) in
            self?.movieModel = result
        }
        return movieModel!.results.map({$0.id})
    }
    
    func getData() {
        
        dataFetchService.fetchPopularMovie { [weak self] (result) in
            self?.movieModel = result
            if let movieID = self?.movieModel?.results.map({$0.id}) {
                
                movieID.forEach { [weak self] (id) in
                    self?.dataFetchService.getMovieDetails(id: id) { [weak self] (result) in
                        
                        self?.movieArray.append(result!)
                        self?.mapPopularMovieData()
                    }
                    
                }
            }
        }
            
            dataFetchService.fetchNowMovie { [weak self] (result) in
                self?.movieModel = result
                if let movieID = self?.movieModel?.results.map({$0.id}) {
                    
                    movieID.forEach { [weak self] (id) in
                        self?.dataFetchService.getMovieDetails(id: id) { [weak self] (result) in
                            
                            self?.movieArray.append(result!)
                            self?.mapNowPlayingMovieData()
                        }
                    }
                }
                
            }
            
    }
    
    func retrieveMovieDetails(with id: Int) -> Movie? {
        guard let movie = movieArray.first(where: {$0.id == id}) else {
            return nil
        }
        return movie
    }
    
}

// MARK: - Private Methods

private extension MainViewModel {
    
    func mapNowPlayingMovieData() {
        playingMovieDataSource.value = self.movieArray.compactMap({NowPlayingMovieCellViewModel(movie: $0)
       })
   }
   
    func mapPopularMovieData() {
       popularMovieDataSource.value = self.movieArray.compactMap({ PopularMovieCellViewModel(movie: $0)
       })
       
   }
}
