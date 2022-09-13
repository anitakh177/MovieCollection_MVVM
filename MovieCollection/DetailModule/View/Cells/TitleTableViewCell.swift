//
//  TitleTableViewCell.swift
//  MovieCollection
//
//  Created by anita on 10.09.2022.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
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
    }
    
    func configureCellData(with viewModel: DetailTableCellViewModel) {
        titleLabel.text = viewModel.title
        ratingLabel.text = viewModel.rating
        genreLabel.text = viewModel.genres
    }
    
    
    
    
}
