//
//  SearchViewModule.swift
//  MovieCollection
//
//  Created by anita on 20.09.2022.
//

import Foundation

class SearchViewModel {
   
    // MARK: - Properties
    
    private var movieModel: MovieResult?
    private var movieArray: [Movie] = []
    private let dataFetchService = DataFetcherService()
    var popularMovieDataSource: Observable<[PopularMovieCellViewModel]> = Observable(nil)
    
    // MARK: - Delegate

    weak var coordinator: SearchViewCoordinator!
    
    // MARK: - Methods
    
    func numberOfRows() -> Int {
        return movieArray.count
    }
    
    func getData(for text: String) {
      
      //  let dispatchGroup = DispatchGroup()
        
        self.dataFetchService.searchMovie(text: text) { [weak self] (result) in
            guard let movie = result?.results else { return }
            for name in movie {
                if name.title.lowercased().contains(text.lowercased()) {
                    self?.movieModel = result
                    
                    if let movieID = self?.movieModel?.results.map({$0.id}) {
                       
                        movieID.forEach { [weak self] (id) in
                          //  dispatchGroup.enter()
                            self?.dataFetchService.getMovieDetails(id: id) { [weak self] (result) in
                                self?.movieArray.append(result!)
                                self?.mapPopularMovieData()
                             //   dispatchGroup.leave()
                            }
                        }
                    }
                   
                }
                
            }
        }
     
    }
    
    func retriveMovieDetails(with id: Int) -> Movie? {
        guard let movie = movieArray.first(where: {$0.id == id}) else {
            return nil
        }
        return movie
    }
}
// MARK: - Private Methods

private extension SearchViewModel {
     func mapPopularMovieData() {
        popularMovieDataSource.value = self.movieArray.compactMap({ PopularMovieCellViewModel(movie: $0)
    })
       
    }
    
}
