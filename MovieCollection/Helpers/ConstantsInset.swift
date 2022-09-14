//
//  ConstantsInset.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import UIKit

struct MovieInsetConstants {
    static let leftDistanceToView: CGFloat = 24
    static let rightDistanceToView: CGFloat = 24
    static let minimumLineSpacing: CGFloat = 16
    static let itemWidth = (UIScreen.main.bounds.width - MovieInsetConstants.leftDistanceToView - MovieInsetConstants.rightDistanceToView - (MovieInsetConstants.minimumLineSpacing / 2)) / 2
    static let itemHeight: CGFloat = 280
}

struct CastInsetConstants {
    static let leftDistanceToView: CGFloat = 24
    static let rightDistanceToView: CGFloat = 24
    static let minimumLineSpacing: CGFloat = 13
    static let itemWidth = (UIScreen.main.bounds.width - MovieInsetConstants.leftDistanceToView - MovieInsetConstants.rightDistanceToView - (MovieInsetConstants.minimumLineSpacing / 2)) / 4
    static let itemHeight: CGFloat = 150
}
