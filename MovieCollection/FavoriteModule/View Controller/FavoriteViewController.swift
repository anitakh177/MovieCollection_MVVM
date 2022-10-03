//
//  FavoriteViewController.swift
//  MovieCollection
//
//  Created by anita on 26.09.2022.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Views
    
    @IBOutlet private weak var tableView: UITableView!
    
    var viewModel = FavoriteViewModel()
    private var favoriteMovieDataSource: [DeatilMovieViewModelCell] = []

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
        bindViewModel()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureApperance()
    }
   
}

// MARK: - Private Methods

private extension FavoriteViewController {
    func bindViewModel() {
        viewModel.favoriteMovieDataSource.bind { [weak self] (result) in
            guard let self = self, let result = result else { return }
            self.favoriteMovieDataSource = result
            print(result)
            self.tableView.reloadData()
        }
    }
    
    func configureApperance() {
        view.backgroundColor = .black
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        tableView.rowHeight = 130
        
        tableView.register(UINib(nibName: "\(PopularMovieTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(PopularMovieTableViewCell.self)")
        
    }
    
}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PopularMovieTableViewCell.self)", for: indexPath) as? PopularMovieTableViewCell
        cell?.configureCell(viewModel: favoriteMovieDataSource[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
}
