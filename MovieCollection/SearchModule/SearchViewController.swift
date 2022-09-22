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
    
    // MARK: - Properties
    
    private var viewModel = SearchViewModel()
    private var popularMovieDataSource: [PopularMovieCellViewModel] = [] {
        didSet {
            if popularMovieDataSource.isEmpty {
                backgroundLabel.isHidden = false
            }
        }
    }
    
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
    
    func bindViewModel() {
        
        viewModel.popularMovieDataSource.bind { [weak self] (result) in
            guard let self = self, let result = result else { return }
            self.popularMovieDataSource = result
             self.tableView.reloadData()
            
        }
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar(frame: CGRect(x: 56, y: 0, width: 300, height: 32))
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.attributedPlaceholder =  NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
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
    
    func configureTableView() {
        tableView.register(UINib(nibName: "\(PopularMovieTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(PopularMovieTableViewCell.self)")
        
        tableView.backgroundColor = .black
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       popularMovieDataSource = []
       if searchText.isEmpty {
           backgroundLabel.isHidden = false
           tableView.isHidden = true
       } else {
           tableView.isHidden = false
           backgroundLabel.isHidden = true
           viewModel.getData(for: searchText)
           bindViewModel()
          
       }
       tableView.reloadData()
    }
   
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "\(PopularMovieTableViewCell.self)", for: indexPath)
        
        if let cell = cell as? PopularMovieTableViewCell {
            if popularMovieDataSource.isEmpty == false {
                let viewModel = popularMovieDataSource[indexPath.row]
                cell.configureCellData(viewModel: viewModel)
            }
        }
            return cell
    }
    
}
