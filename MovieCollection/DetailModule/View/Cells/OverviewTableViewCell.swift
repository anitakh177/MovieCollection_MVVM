//
//  OverviewTableViewCell.swift
//  MovieCollection
//
//  Created by anita on 12.09.2022.
//

import UIKit

final class OverviewTableViewCell: UITableViewCell {
    
    // MARK: - Views

    @IBOutlet private weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCellData(viewModel: DetailTableCellViewModel) {
        overviewLabel.text = viewModel.overview
    }
    
}
