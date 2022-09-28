//
//  FavoriteViewCoordinator.swift
//  MovieCollection
//
//  Created by anita on 28.09.2022.
//

import Foundation
import UIKit

class FavoriteViewCoordinator: Coordinator {
    
    var childCoordinator: [Coordinator] = []
    
    weak var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init() {
        
        self.navigationController = .init()
        
    }
    
    func start() {
        
    }
    // push navigation controller
    func startPush() -> UINavigationController {
        let favoriteViewController = FavoriteViewController()
        let favoriteViewModel = FavoriteViewModel()
        favoriteViewModel.coordinator = self
        favoriteViewController.viewModel = favoriteViewModel
        navigationController.setViewControllers([favoriteViewController], animated: false)
        return navigationController
    }
}
