//
//  ParametersTableViewCell.swift
//  MovieCollection
//
//  Created by anita on 13.09.2022.
//

import UIKit

final class ParametersTableViewCell: UITableViewCell {
    
    // MARK: - Views

    @IBOutlet private weak var releaseLabel: UILabel!
    @IBOutlet private weak var languageLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCellData(viewModel: DetailTableCellViewModel) {
        releaseLabel.text = viewModel.releaseDate
        languageLabel.text = viewModel.originalLanguage.capitalized
        durationLabel.text = "\(viewModel.duration)"
    }
    
}
