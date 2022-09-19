//
//  SearchViewController.swift
//  MovieCollection
//
//  Created by anita on 19.09.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Views

    @IBOutlet private weak var backgroundLabel: UIStackView!
    @IBOutlet private weak var tableView: UITableView!
    private lazy var searchBar = UISearchBar()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        searchBar.becomeFirstResponder()
      
    }


   
}

// MARK: - Private Methods

private extension SearchViewController {
    
    
    func setupSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 56, y: 0, width: 300, height: 32))
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.attributedPlaceholder =  NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        searchBar.searchTextField.textColor = .white
        searchBar.layer.cornerRadius = 32/2
        searchBar.clipsToBounds = true
        searchBar.delegate = self
    }
    
    func configureNavigationBar() {
        let rightNavBar = UIBarButtonItem(customView: searchBar)
        navigationItem.rightBarButtonItem = rightNavBar
        
        let leftNavBar = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(closeSearchVC))
        leftNavBar.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftNavBar
    }
    @objc func closeSearchVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func configureAppearance() {
        configureTableView()
        setupSearchBar()
    }
    
    func configureTableView(){
        tableView.backgroundColor = .black
    }
}

extension SearchViewController: UISearchBarDelegate {
    
}
