//
//  FavoriteViewModel.swift
//  MovieCollection
//
//  Created by anita on 28.09.2022.
//

import Foundation

final class FavoriteViewModel {
    
    // MARK: - Properties
    
    var movieModel: Movie?
    var movieArray: [Movie] = []
    var favoriteMovieDataSource: Observable<[PopularMovieCellViewModel]> = Observable(nil)
    
    private let favoriteService = FavoriteMovieStorage()
    private let dataFetchService = DataFetcherService()
    
    // MARK: - Delegates
    
    weak var coordinator: FavoriteViewCoordinator!
    
    // MARK: - Methods
    
    func removeFavoriteMovie(cellViewModel: PopularMovieCellViewModel) {
        movieArray = movieArray.filter { !($0.id == cellViewModel.movieID) }
        favoriteService.changeStatus(id: cellViewModel.movieID, isFavorite: true)
        }
    
    func retrieveFavoriteMovies() -> [Int] {
        guard let id = favoriteService.getFavoriteItems()  else { return  [] }
        return id
    }
    
    func getData() {
        let movieID = retrieveFavoriteMovies()
        movieID.forEach { [weak self] (id) in
            self?.dataFetchService.getMovieDetails(id: id) { [weak self] (result) in
        
                self?.movieArray.append(result!)
                self?.mapFavoriteMovie()
            }
        }
      
    }
    
    func numberOfRows() -> Int {
        return movieArray.count
    }
    
    func retriveFavoriteMovieDetails(with id: Int) -> Movie? {
        guard let movie = movieArray.first(where: {$0.id == id}) else {
            return nil
        }
        return movie
    }
    
}

// MARK: - Private Methods

private extension FavoriteViewModel {
    
    func mapFavoriteMovie() {
        favoriteMovieDataSource.value = self.movieArray.compactMap({PopularMovieCellViewModel(movie: $0)})    }
}
