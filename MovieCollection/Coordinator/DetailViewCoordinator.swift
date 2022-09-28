//
//  DetailViewCoordinator.swift
//  MovieCollection
//
//  Created by anita on 27.09.2022.
//

import Foundation
import UIKit

class DetailViewCoordinator: Coordinator {
       
    weak var parentCoordinator: Coordinator?
    
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController!
    var movie: Result
    var genre: GenreData
    
    init(naviagtionController: UINavigationController, movie: Result, genre: GenreData) {
        self.navigationController = naviagtionController
        self.movie = movie
        self.genre = genre
    }
    
    func start() {
      
        let detailTableViewModel = DetailTableViewModel()
        let detailViewController = DetailViewController()
        detailTableViewModel.coordinator = self
       
        let detailCellViewModel = DetailTableCellViewModel(movie: movie, genre: genre)
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
}
