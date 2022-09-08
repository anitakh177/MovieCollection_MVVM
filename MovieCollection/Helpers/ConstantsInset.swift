//
//  ConstantsInset.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import UIKit

struct InsetConstants {
    static let leftDistanceToView: CGFloat = 24
    static let rightDistanceToView: CGFloat = 24
    static let minimumLineSpacing: CGFloat = 16
    static let itemWidth = (UIScreen.main.bounds.width - InsetConstants.leftDistanceToView - InsetConstants.rightDistanceToView - (InsetConstants.minimumLineSpacing / 2)) / 2
    static let itemHeight: CGFloat = 280
}
