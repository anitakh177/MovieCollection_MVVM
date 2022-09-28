//
//  DetailTableViewModel.swift
//  MovieCollection
//
//  Created by anita on 22.09.2022.
//

import Foundation

class DetailTableViewModel: TableViewModelType {

    // MARK: - Properties
    var castCellView: Observable<[CastCollectionViewModel]> = Observable(nil)

    private let dataFetchService = DataFetcherService()
    private var castData: Cast?
    private var castImageData: CastImage?
    
    // MARK: - Delegate
    
    weak var coordinator: DetailViewCoordinator!
    weak var delegateCast: FetchCast?
    
    // MARK: - Methods
    
    func numberOfRows(in section: Int) -> Int {
        return 5
    }
    
    func numberOfSections() -> Int {
        return 1
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
    
    _ = DispatchQueue.global(qos: .userInitiated)
        
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
    
}

private extension DetailTableViewModel {
    func mapCastCell() {
        castCellView.value = self.castData?.cast.compactMap({CastCollectionViewModel(cast: $0)})
    }
}
