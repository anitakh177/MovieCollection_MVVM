//
//  Coordinator.swift
//  MovieCollection
//
//  Created by anita on 19.09.2022.
//

import Foundation
import UIKit

protocol Coordinator {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        print("App Coordinator Start")
        goToMainViewController()
    }
    
    func goToMainViewController() {
        let mainVC = MainViewController()
        let mainViewModel = MainViewModel.init()
        mainViewModel.appCoordinator = self
        mainVC.viewModel = mainViewModel
        navigationController.pushViewController(mainVC, animated: true)
    }
    
    func goToSearchViewController() {
        let searchVC = SearchViewController()
        navigationController.pushViewController(searchVC, animated: true)
    }
}
