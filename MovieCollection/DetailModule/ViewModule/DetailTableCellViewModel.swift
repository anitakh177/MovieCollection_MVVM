//
//  DetailTableCellViewModel.swift
//  MovieCollection
//
//  Created by anita on 09.09.2022.
//

import Foundation
 
class DetailTableCellViewModel: CellViewModelType {

    var movie: Result
    var id: Int
    var image: URL?
    var title: String
    var rating: String
    var genres: String = ""
    var originalLanguage: String
    var overview: String
    var releaseDate: String
    
    init(movie: Result, genre: GenreData) {
        self.movie = movie
        self.title = movie.title
        self.rating = "\(movie.voteAverage)/10 IMDb"
        self.originalLanguage = movie.originalLanguage
        self.id = movie.id
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.image = makeImageURL(movie.posterPath)
        self.genres = getGenre(genreIds: movie.genreIDS, genreData: genre)
    }
    
    var castCellView: Observable<[CastCollectionViewModel]> = Observable(nil)
   
   private let dataFetchService = DataFetcherService()
   private var castData: Cast?
   private var castImageData: CastImage?
    weak var delegateCast: FetchCast?
  
    
    func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "https://image.tmdb.org/t/p/w500/\(imageCode)")
        
    }
    
   private func getGenre(genreIds : [Int], genreData: GenreData?) -> String {
                var genreString = ""
                for genreId in genreIds {
                    if let geners = (genreData?.genres) {
                        for genre in geners {
                            if genreId == genre.id {
                                genreString += genre.name + ", "
                                continue
                            }
                        }
                    }
                }
                return String(genreString.dropLast(2))
            }
    
    
    func numberOfRows() -> Int {
       return 5
    }
    
    func getData() {
        let dispatchGroup = DispatchGroup()
        
        guard let movieID = delegateCast?.getMovieID() else { return }
        
        dispatchGroup.enter()
        dataFetchService.fetchCast(movieID: movieID) { [weak self] (result) in
            self?.castData = result
            self?.mapCastCell()
        }
        dispatchGroup.leave()
        
        guard let personID = delegateCast?.getPersonID() else { return }
        
        let _ = DispatchQueue.global(qos: .userInitiated)
        
        DispatchQueue.concurrentPerform(iterations: personID.count) { index in
            let id = personID[index]
            dispatchGroup.enter()
            dataFetchService.fetchCastImage(castID: id) { [weak self] (result) in
                self?.castImageData = result
                dispatchGroup.leave()
            }
         
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
        }
        
    }
    
   private func mapCastCell() {
        castCellView.value = self.castData?.cast.compactMap({CastCollectionViewModel(cast: $0)})
        
    }
     
}
