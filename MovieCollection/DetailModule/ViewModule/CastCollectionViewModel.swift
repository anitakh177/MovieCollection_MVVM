//
//  CastCollectionViewModel.swift
//  MovieCollection
//
//  Created by anita on 13.09.2022.
//

import Foundation

class CastCollectionViewModel {
    
    var name: String
    
    init(cast: CastElement) {
        self.name = cast.originalName
    }
}
