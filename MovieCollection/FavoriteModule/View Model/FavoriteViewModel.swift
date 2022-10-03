//
//  FavoriteViewModel.swift
//  MovieCollection
//
//  Created by anita on 28.09.2022.
//

import Foundation

class FavoriteViewModel {
    
    weak var coordinator: FavoriteViewCoordinator!
    
    var favoriteMovies: [Int] = []
    var movieModel: FavoriteMovie?
    var movieArray: [FavoriteMovie] = []
    var favoriteMovieDataSource: Observable<[DeatilMovieViewModelCell]> = Observable(nil)
    
    let favoriteService = FavoriteMovieStorage()
    let dataFetchService = DataFetcherService()
   
    // MARK: - Methods
    
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
    
}

// MARK: - Private Methods

private extension FavoriteViewModel {
    
    func mapFavoriteMovie() {
        favoriteMovieDataSource.value = self.movieArray.compactMap({DeatilMovieViewModelCell(movie: $0)})    }
}
