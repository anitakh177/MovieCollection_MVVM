//
//  AppCoordinator.swift
//  MovieCollection
//
//  Created by anita on 27.09.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinator: [Coordinator] { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    
    private let allTab: [TabBarModel] = [.home, .favorite]
    
    var childCoordinator: [Coordinator] = []
    let window: UIWindow?
    
    init(_ window: UIWindow?) {
        
        self.window = window
        window?.makeKeyAndVisible()
        
    }
    
    func start() {
        let tabBarController = self.setTabBarController()
        self.window?.rootViewController = tabBarController
    }
    
    func setTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        var item: [UITabBarItem] = []
        
        allTab.forEach { tab in
            let tabBarItem = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            item.append(tabBarItem)
        }
        
        let mainViewCoordinator = MainViewCoordinator()
        mainViewCoordinator.parentCoordinator = self
        childCoordinator.append(mainViewCoordinator)
        let mainViewController = mainViewCoordinator.startPush()
        mainViewController.tabBarItem = item.first
        
        let favorieViewCoordinator = FavoriteViewCoordinator()
        favorieViewCoordinator.parentCoordinator = self
        childCoordinator.append(favorieViewCoordinator)
        let favoriteViewControlelr = favorieViewCoordinator.startPush()
        favoriteViewControlelr.tabBarItem = item.last
        tabBarController.viewControllers = [mainViewController, favoriteViewControlelr]
        
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.unselectedItemTintColor = .lightGray
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .black
        tabBarController.tabBar.standardAppearance = appearance
        
        return tabBarController
        
    }
}
