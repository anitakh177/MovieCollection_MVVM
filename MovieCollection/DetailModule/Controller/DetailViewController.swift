//
//  DetailViewController.swift
//  MovieCollection
//
//  Created by anita on 09.09.2022.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Views
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    var viewModel: DetailTableCellViewModel
    
    init(viewModel: DetailTableCellViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
      
    }

}

private extension DetailViewController {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
        
        tableView.register(UINib(nibName: "\(ImageTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(ImageTableViewCell.self)")
        tableView.register(UINib(nibName: "\(TitleTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(TitleTableViewCell.self)")
        tableView.register(UINib(nibName: "\(ParametersTableViewCell.self)" , bundle: .main), forCellReuseIdentifier: "\(ParametersTableViewCell.self)")
        tableView.register(UINib(nibName: "\(OverviewTableViewCell.self)", bundle: .main), forCellReuseIdentifier: "\(OverviewTableViewCell.self)")

        
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier:  "\(ImageTableViewCell.self)", for: indexPath) as? ImageTableViewCell
                    cell?.configureCellData(viewModel: viewModel)
            
                return cell ?? UITableViewCell()
        
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(TitleTableViewCell.self)", for: indexPath) as? TitleTableViewCell
                    cell?.configureCellData(with: viewModel)
            
                return cell ?? UITableViewCell()
            
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(ParametersTableViewCell.self)", for: indexPath) as? ParametersTableViewCell
                   cell?.configureCellData(viewModel: viewModel)
            
                return cell ?? UITableViewCell()
            case 3:
            
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(OverviewTableViewCell.self)", for: indexPath) as? OverviewTableViewCell
                    cell?.configureCellData(viewModel: viewModel)
            
                return cell ?? UITableViewCell()
           
            
            default:
                return UITableViewCell()
        
            }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
        return 350
        } else {
            return UITableView.automaticDimension
        }
    }
    
    
}