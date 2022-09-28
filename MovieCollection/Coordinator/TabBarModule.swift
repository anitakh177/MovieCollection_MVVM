//
//  TabBarModule.swift
//  MovieCollection
//
//  Created by anita on 26.09.2022.
//

import Foundation
import UIKit

enum TabBarModel {
    
    case home
    case favorite
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .favorite:
            return "Favorite"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home:
            return UIImage(systemName: "house")
        case .favorite:
            return UIImage(systemName: "heart")
        }
    }
    
    var selectedImage: UIImage? {
        return image
    }
}
