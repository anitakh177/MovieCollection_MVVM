//
//  MainViewController.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import UIKit

protocol GetMovieIDToFetchCast: AnyObject {
    func getMovieID() -> Int
}

class MainViewController: UIViewController {

    // MARK: - Views
    
    @IBOutlet private weak var tableView: UITableView!
    private let collectionView = CollectionView()
    
    // MARK: - Properties
    
    private let dataFetcher = DataFetcherService()
    private var viewModel = MainViewModel()
    private var popularMovieDataSource: [PopularMovieCellViewModel] = []
    private var nowPlayingDataSource: [NowPlayingMovieCellViewModel] = []
    
   
    
    
        
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        bindViewModel()
        configureAppearance()
     
        
    }

}

private extension MainViewController {
    
    func bindViewModel() {
        viewModel.popularMovie.bind { [weak self] (result) in
            guard let self = self, let result = result else { return }
            self.popularMovieDataSource = result
            self.reloadTableView()
            
        }
        
        viewModel.nowPlaying.bind { [weak self] (result) in
            guard let self = self, let result = result else { return }
            self.collectionView.configure(with: result)
            
        }
      
    }
    
    func configureAppearance() {
        view.backgroundColor = .black
        navigationItem.title = "Movie Collection"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black
        
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: "\(CollectionTableViewCell.self)")
        tableView.register(UINib(nibName: "\(PopularMovieTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(PopularMovieTableViewCell.self)")
        
        
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
    }
    
    func openDetail(movieID: Int) {
        guard let movie = viewModel.retriveMovieDetails(with: movieID) else {
            return
        }
        guard let genre = viewModel.genreData else {
            return
        }
       
        let detailViewModel = DetailTableCellViewModel(movie: movie, genre: genre)
        let detailVC = DetailViewController(viewModel: detailViewModel)
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if section == 0 {
            return 1
         } else {
            return viewModel.numberOfRows(in: section)
         }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(CollectionTableViewCell.self)", for: indexPath) as? CollectionTableViewCell
            

            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PopularMovieTableViewCell.self)", for: indexPath) as? PopularMovieTableViewCell
            let viewModel = popularMovieDataSource[indexPath.row]
            cell?.configureCellData(viewModel: viewModel)
            
            return cell ?? UITableViewCell()
        }
        
       
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        } else {
            return 130
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sectionTitle[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        header.textLabel?.textColor = .white
        header.textLabel?.frame = CGRect(x: MovieInsetConstants.leftDistanceToView, y: header.bounds.origin.y, width: 200, height: header.bounds.height)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieID = popularMovieDataSource[indexPath.row].movieID
        
        self.openDetail(movieID: movieID)
    }
    
}

