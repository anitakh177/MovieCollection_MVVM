//
//  MainViewCoordinator.swift
//  MovieCollection
//
//  Created by anita on 27.09.2022.
//

import Foundation
import UIKit

class MainViewCoordinator: Coordinator {
    
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
        let mainVC = MainViewController()
        let mainViewModel = MainViewModel()
        mainViewModel.coordinator = self
        mainVC.viewModel = mainViewModel
        navigationController.setViewControllers([mainVC], animated: false)
        return navigationController
    }
}

extension MainViewCoordinator {
    
    func pushDetailVC(with movieID: Int, with mainVM: MainViewModel) {
        
        guard let movie = mainVM.retrivePopulerMovieDetails(with: movieID) else {
            
            return
        }
        
        guard let genre = mainVM.genreData else {
            
            return
        }
        
       let detailViewCoordinator = DetailViewCoordinator(naviagtionController: navigationController, movie: movie, genre: genre)
        detailViewCoordinator.parentCoordinator = self
        childCoordinator.append(detailViewCoordinator)
        
        print(movie.title)
        
        detailViewCoordinator.start()
    }
    
    func pushSearchVC() {
        
        let searchViewCoordinator = SearchViewCoordinator(naviagtionController: navigationController)
        searchViewCoordinator.parentCoordinator = self
        childCoordinator.append(searchViewCoordinator)
        searchViewCoordinator.start()
        
    }
}
