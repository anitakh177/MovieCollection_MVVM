//
//  DetailViewCoordinator.swift
//  MovieCollection
//
//  Created by anita on 27.09.2022.
//

import Foundation
import UIKit

final class DetailViewCoordinator: Coordinator {
       
    weak var parentCoordinator: Coordinator?
    
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController!
    var movie: Movie
    
    init(naviagtionController: UINavigationController, movie: Movie) {
        self.navigationController = naviagtionController
        self.movie = movie
    }
    
    func start() {
      
        let detailTableViewModel = DetailTableViewModel()
        let detailViewController = DetailViewController()
        detailTableViewModel.coordinator = self
       
        let detailCellViewModel = DetailTableCellViewModel(movie: movie)
        detailViewController.viewModel = detailTableViewModel
        detailViewController.cellViewModel = detailCellViewModel
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
}

extension DetailViewCoordinator {
    
    func pushSearchVC() {
        
        let searchViewCoordinator = SearchViewCoordinator(naviagtionController: navigationController)
        searchViewCoordinator.parentCoordinator = self
        childCoordinator.append(searchViewCoordinator)
        searchViewCoordinator.start()
        
    }
    
    func backToRootView() {
        navigationController.popToRootViewController(animated: true)
    }
}
