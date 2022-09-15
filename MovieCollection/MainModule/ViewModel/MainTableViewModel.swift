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
    var genreData: GenreData?
   
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
        
            let dispatchGroup = DispatchGroup()
            
            dispatchGroup.enter()
            self.dataFetchService.fetchGenres { [weak self] (result) in
                self?.genreData = result
                
            }
            dispatchGroup.leave()
            
            dispatchGroup.enter()
            self.dataFetchService.fetchNowMovie { [weak self] (result) in
                self?.nowPlayingModel = result
                self?.mapNowPlayingMovieData()
            }
            
            
            self.dataFetchService.fetchMovie { [weak self] (result) in
                self?.popularModel = result
                self?.mapPopularMovieData()
            }
            dispatchGroup.leave()
            dispatchGroup.notify(queue: .main) {
                print("work done: \(Thread.current)")
            }
        }
        
    

    
    private func mapNowPlayingMovieData() {
        nowPlaying.value = self.nowPlayingModel?.results.compactMap({NowPlayingMovieCellViewModel(movie: $0)
        })
    }
    
    private func mapPopularMovieData() {
        
        guard let genreData = genreData else { return  }
        
        popularMovie.value = self.popularModel?.results.compactMap({ PopularMovieCellViewModel(movie: $0, genre: genreData)
           
        })
       
    }
   
    
    func retriveMovieDetails(with id: Int) -> Result? {
        guard let movie = popularModel?.results.first(where: {$0.id == id}) else {
            return nil
        }
        return movie
    }
    
   
      
    func retriveGenre(_ movie: Result,_ genre: Genre) -> [String] {
        var array3: [String] = []
        for id in movie.genreIDS {
            if id == genre.id {
                array3.append(genre.name)
            }
        }
        
        return array3
    }
    
}
/*
extension MainViewModel: MovieIDDelegate {
    func getMovieID(_ id: Int) -> Int {
        var result = 0
         _ = popularModel?.results.forEach({ result = $0.id })
        return result
    }
    
    
}
*/
