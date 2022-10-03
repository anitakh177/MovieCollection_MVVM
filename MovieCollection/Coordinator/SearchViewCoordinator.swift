//
//  SearchViewCoordinator.swift
//  MovieCollection
//
//  Created by anita on 28.09.2022.
//

import Foundation
import UIKit

class SearchViewCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController!
    
    init(naviagtionController: UINavigationController) {
        self.navigationController = naviagtionController
    }
    
    func start() {
        
        let searchViewController = SearchViewController()
        let searchViewModel = SearchViewModel()
        searchViewModel.coordinator = self
        searchViewController.viewModel = searchViewModel
        self.navigationController.pushViewController(searchViewController, animated: true)
        
    }
    
    func pushToDetail(with movieID: Int, with searchVM: SearchViewModel) {
        
        guard let movie = searchVM.retrivePopulerMovieDetails(with: movieID) else {
            return
        }
        
        guard let genre = searchVM.genreData else {
            return
        }
        
        let detailViewCoordinator = DetailViewCoordinator(naviagtionController: navigationController, movie: movie, genre: genre)
         detailViewCoordinator.parentCoordinator = self
         childCoordinator.append(detailViewCoordinator)
         
         print(movie.title)
        
         detailViewCoordinator.start()
        
    }
    
}