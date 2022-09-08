//
//  TableViewModelType.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import Foundation

protocol TableViewModelType {
    func numberOfRows(in section: Int) -> Int
    func numberOfSections() -> Int
    func getData()
    
    var sectionTitle: [String] { get }
}
