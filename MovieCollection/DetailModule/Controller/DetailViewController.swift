//
//  DetailViewController.swift
//  MovieCollection
//
//  Created by anita on 09.09.2022.
//

import UIKit

protocol FetchCast: AnyObject {
    func getMovieID() -> Int
}

final class DetailViewController: UIViewController {

    // MARK: - Views
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel = DetailTableViewModel()
    var cellViewModel: DetailTableCellViewModel?
    var castCellDataSource: [CastCollectionViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegateCast = self
        viewModel.getData()
        bindViewModel()
        configureAppearance()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       // viewModel.detailWillCloseDelegate?.detailVCWillClose()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
    }

}

private extension DetailViewController {

    func bindViewModel() {
        viewModel.castCellView.bind { [weak self] (result) in
            guard let self = self, let result = result else { return }
            self.castCellDataSource = result
            self.tableView.reloadData()

        }
    }
    func configureAppearance() {
        view.backgroundColor = .black
        configureTableView()
        
    }
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        
        tableView.register(UINib(nibName: "\(ImageTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(ImageTableViewCell.self)")
        tableView.register(UINib(nibName: "\(TitleTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(TitleTableViewCell.self)")
        tableView.register(UINib(nibName: "\(ParametersTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(ParametersTableViewCell.self)")
        tableView.register(UINib(nibName: "\(OverviewTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(OverviewTableViewCell.self)")
        tableView.register(UINib(nibName: "\(CastTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(CastTableViewCell.self)")

    }
    
    func configureNavigationBar() {
        navigationItem.title = "Movie Collection"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let searchButton = UIBarButtonItem(image: ImageConstants.searchImage, style: .plain, target: self, action: #selector(didTapSearch))
        searchButton.tintColor = .white
        navigationItem.rightBarButtonItem = searchButton
        let leftNavBar = UIBarButtonItem(image: ImageConstants.backImage, style: .plain, target: self, action: #selector(closeSearchVC))
        leftNavBar.tintColor = .white
        
        navigationItem.leftBarButtonItem = leftNavBar
    }
    
    @objc func closeSearchVC() {
        viewModel.coordinator.backToRootView()
    
    }
    @objc func didTapSearch() {
        viewModel.coordinator.pushSearchVC()
    }
  
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ImageTableViewCell.self)", for: indexPath) as? ImageTableViewCell
            cell?.configureCellData(viewModel: cellViewModel!)
            
                return cell ?? UITableViewCell()
        
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(TitleTableViewCell.self)", for: indexPath) as? TitleTableViewCell
           
            cell?.configureCellData(with: cellViewModel!) {  [weak self] isFavorite in
                guard let self = self else {
                    return
                }
                self.cellViewModel!.isFavorite = isFavorite
                self.viewModel.changeFavoriteStatus(cellViewModel: self.cellViewModel!, for: self.cellViewModel!.id, isFavorite: isFavorite)
                
            }
            
                return cell ?? UITableViewCell()
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(ParametersTableViewCell.self)", for: indexPath) as? ParametersTableViewCell
            cell?.configureCellData(viewModel: cellViewModel!)
            
            return cell ?? UITableViewCell()
            
        case 3:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(OverviewTableViewCell.self)", for: indexPath) as? OverviewTableViewCell
            cell?.configureCellData(viewModel: cellViewModel!)
            
            return cell ?? UITableViewCell()
            
        case 4:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(CastTableViewCell.self)", for: indexPath) as? CastTableViewCell
            cell?.updateCell(with: castCellDataSource)
            
            return cell ?? UITableViewCell()
            
        default:
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 350
        case 2:
            return 70
        default:
            return UITableView.automaticDimension
            
        }
     
    }
    
}

// MARK: - Get Movie ID Delegate

extension DetailViewController: FetchCast {
    func getMovieID() -> Int {
        
        return cellViewModel?.id ?? 0
    }
   
}
