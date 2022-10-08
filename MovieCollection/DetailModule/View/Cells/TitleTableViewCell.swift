//
//  TitleTableViewCell.swift
//  MovieCollection
//
//  Created by anita on 10.09.2022.
//

import UIKit

final class TitleTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    
    private enum Constants {
        static let fillBookMarkImage = UIImage(systemName: "bookmark.fill")
        static let bookMarkImage = UIImage(systemName: "bookmark")
    }
    
    var buttonImage: UIImage? {
        return isFavorite ? Constants.fillBookMarkImage : Constants.bookMarkImage
        
    }
    
    var isFavorite: Bool = false {
        didSet {
            saveButton.setImage(buttonImage, for: .normal)
        }
    }
    // MARK: - Events
    
    var completionHandler: ((Bool) -> Void)?
    
    // MARK: - Views

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func saveToFavorite(_ sender: UIButton) {
        completionHandler?(isFavorite)
        isFavorite.toggle()
    }
    
    func configureCellData(with viewModel: DetailTableCellViewModel, completionHandler: ((Bool) -> Void)?) {
        titleLabel.text = viewModel.title
        ratingLabel.text = viewModel.rating + " IMDb"
        genreLabel.text = viewModel.genres
        isFavorite = viewModel.isFavorite
        
        self.completionHandler = completionHandler
        
    }
    
}
