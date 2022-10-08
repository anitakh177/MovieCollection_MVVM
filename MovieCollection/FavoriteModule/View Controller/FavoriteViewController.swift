//
//  FavoriteViewController.swift
//  MovieCollection
//
//  Created by anita on 26.09.2022.
//

import UIKit

final class FavoriteViewController: UIViewController {
    
    // MARK: - Views
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel = FavoriteViewModel()
    private var favoriteMovieDataSource: [PopularMovieCellViewModel] = []

    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
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
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
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
    
    func configureNavigationBar() {
        navigationItem.title = "Favorite Movies"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let searchButton = UIBarButtonItem(image: ImageConstants.searchImage, style: .plain, target: self, action: #selector(didTapSearch))
        searchButton.tintColor = .white
        navigationItem.rightBarButtonItem = searchButton
    }
    @objc func didTapSearch() {
        viewModel.coordinator.pushSearchVC()
    }
    
}
    
// MARK: - Table Data Source & Delegate

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PopularMovieTableViewCell.self)", for: indexPath) as? PopularMovieTableViewCell
        cell?.configureCellData(viewModel: favoriteMovieDataSource[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeFavoriteMovie(cellViewModel: favoriteMovieDataSource[indexPath.row])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let movieID = favoriteMovieDataSource[indexPath.row].movieID
        viewModel.coordinator.pushDetailVC(with: movieID, with: viewModel)
    }
    
}
