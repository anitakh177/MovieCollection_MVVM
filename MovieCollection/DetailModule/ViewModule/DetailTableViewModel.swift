//
//  DetailTableViewModel.swift
//  MovieCollection
//
//  Created by anita on 22.09.2022.
//

import Foundation

final class DetailTableViewModel: TableViewModelType {

    // MARK: - Properties
    var castCellView: Observable<[CastCollectionViewModel]> = Observable(nil)

    private let dataFetchService = DataFetcherService()
    private let favoriteStoreService = FavoriteMovieStorage()
    private var castData: Cast?
    
    // MARK: - Delegate
    
    weak var coordinator: DetailViewCoordinator!
    weak var delegateCast: FetchCast?
    
    // MARK: - Methods
    
    func notificationToFavViewController() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
    
   func changeFavoriteStatus(cellViewModel: DetailTableCellViewModel, for id: Int, isFavorite: Bool ) {
        cellViewModel.isFavorite = isFavorite
        favoriteStoreService.changeStatus(id: cellViewModel.id, isFavorite: isFavorite)
        print(" \(cellViewModel.title) is \(isFavorite)")
      }
    
    func numberOfRows(in section: Int) -> Int {
        return 5
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func getData() {
   
    guard let movieID = delegateCast?.getMovieID() else { return }
    
    dataFetchService.fetchCast(movieID: movieID) { [weak self] (result) in
        self?.castData = result
        self?.mapCastCell()
      
    }
    
    }
    
}

private extension DetailTableViewModel {
    func mapCastCell() {
        castCellView.value = self.castData?.cast.compactMap({CastCollectionViewModel(cast: $0)})
    }
}
