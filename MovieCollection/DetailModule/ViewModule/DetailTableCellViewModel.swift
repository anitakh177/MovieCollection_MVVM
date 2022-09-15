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
   
    let dataFetchService = DataFetcherService()
    var castData: Cast?
    var castImageData: CastImage?
    weak var delegate: GetMovieIDToFetchCast?
    
    func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "https://image.tmdb.org/t/p/w500/\(imageCode)")
        
    }
    
   
    
    func getGenre(genreIds : [Int], genreData: GenreData?) -> String {
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
        DispatchQueue.main.async {
            guard let movieID = self.delegate?.getMovieID() else { return }
                self.dataFetchService.fetchCast(movieID: movieID) { [weak self] (result) in
                self?.castData = result
                self?.mapCastCell()
            }
        }
       /*
        guard let personID = delegate?.getPersonID() else { return }
        for id in personID {
            dataFetchService.fetchCastImage(castID: id) { [weak self] (result) in
                self?.castImageData = result
                print(self?.castImageData)
            }
        }
        */
       /* dataFetchService.fetchCastImage(castID: personID) { [weak self] (result) in
            self?.castImageData = result
            print(self?.castImageData)
        }
        */
    }
    
    func mapCastCell() {
       // guard let castImageData = castImageData else { return }
        castCellView.value = self.castData?.cast.compactMap({CastCollectionViewModel(cast: $0)})
        
    }
     
}
