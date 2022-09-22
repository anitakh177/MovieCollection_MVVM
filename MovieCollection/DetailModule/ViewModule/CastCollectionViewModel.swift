//
//  CastCollectionViewModel.swift
//  MovieCollection
//
//  Created by anita on 13.09.2022.
//

import Foundation

class CastCollectionViewModel: CellViewModelType {
    
    var name: String
    var personID: Int
   // var image: URL?
    
    init(cast: CastElement) {
        self.name = cast.originalName
        self.personID = cast.id
       // self.image = makeImageURL(castImage.filePath)
    }
    func makeImageURL(_ imageCode: String) -> URL? {
           URL(string: "https://image.tmdb.org/t/p/w500/\(imageCode)")
    }
    
}
