//
//  CellViewModelType.swift
//  MovieCollection
//
//  Created by anita on 08.09.2022.
//

import Foundation

protocol CellViewModelType {
    func makeImageURL(_ imageCode: String) -> URL?
}
