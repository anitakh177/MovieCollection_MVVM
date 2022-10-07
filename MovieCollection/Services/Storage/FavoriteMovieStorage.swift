//
//  FavoriteMovieStorage.swift
//  MovieCollection
//
//  Created by anita on 28.09.2022.
//

import Foundation

class FavoriteMovieStorage {
    
    private let itemKey = "movieID"
    private var savedMovies: [Int] = []
   
    private let userDefaults = UserDefaults.standard
    
    init() {
        getDataFromUserDefaults()
    }
    
    func changeStatus(id: Int, isFavorite: Bool) {
           if isFavorite {
               removeFavoriteItem(id)
               print("removed id \(id)")
           } else {
               saveFavoriteItem(id)
               print("saved id \(id)")
           }
       }
    
    func isFavoriteItem(id: Int) -> Bool {
        guard let items = getFavoriteItems() else {
            return false
        }
        return items.contains(id) ? true : false
    }
    
    func getFavoriteItems() -> [Int]? {
        guard let dataFromUserDefaults = userDefaults.value(forKey: itemKey) as? Data,
              let items = try? JSONDecoder().decode([Int].self, from: dataFromUserDefaults) else {
            return nil
        }
        return items
    }
    
    func removeFavoriteItems() {
        userDefaults.removeObject(forKey: itemKey)
    }
   
}

// MARK: - Private methods

private extension FavoriteMovieStorage {
    
    func saveFavoriteItem(_ id: Int) {
       
        savedMovies.insert(id, at: 0)
        saveToUserDefaults()
    }
    
    func removeFavoriteItem(_ id: Int) {
        savedMovies = savedMovies.filter({ !($0 == id)})
        saveToUserDefaults()
    }

    func saveToUserDefaults() {
        let dataForUserDefaults = try? JSONEncoder().encode(savedMovies)
        userDefaults.set(dataForUserDefaults, forKey: itemKey)
    }
    
    func getDataFromUserDefaults() {
        guard let dataFromUserDefaults = userDefaults.value(forKey: itemKey) as? Data,
              let items = try? JSONDecoder().decode([Int].self, from: dataFromUserDefaults) else {
            return
        }
        savedMovies = items
    }
    
}
