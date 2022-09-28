//
//  SearchViewModule.swift
//  MovieCollection
//
//  Created by anita on 20.09.2022.
//

import Foundation

class SearchViewModel {
   
    // MARK: - Properties
    
    private var movieModel: Movie?
    var genreData: GenreData?
    let dataFetchService = DataFetcherService()
    var popularMovieDataSource: Observable<[PopularMovieCellViewModel]> = Observable(nil)
    
    // MARK: - Delegate

    weak var coordinator: SearchViewCoordinator!
    
    // MARK: - Methods
    
    func numberOfRows() -> Int {
        return movieModel?.results.count ?? 0
    }
    
    func getData(for text: String) {
        DispatchQueue.global(qos: .utility).async {
            
            self.dataFetchService.fetchGenres { [weak self] (result) in
                self?.genreData = result
                
            }
            self.dataFetchService.searchMovie(text: text) { [weak self] (result) in
                guard let movie = result?.results else { return }
                for name in movie {
                    if name.title.lowercased().contains(text.lowercased()) {
                        
                        self?.movieModel = result
                        self?.mapPopularMovieData()
                        print(Thread.current)
                    }
                }
                
            }
        }
    }
    
    func retrivePopulerMovieDetails(with id: Int) -> Result? {
        guard let movie = movieModel?.results.first(where: {$0.id == id}) else {
            return nil
        }
        return movie
    }
}
// MARK: - Private Methods

private extension SearchViewModel {
     func mapPopularMovieData() {
        guard let genreData = genreData else { return  }
        
        popularMovieDataSource.value = self.movieModel?.results.compactMap({ PopularMovieCellViewModel(movie: $0, genre: genreData)
        })
       
    }
    
}
