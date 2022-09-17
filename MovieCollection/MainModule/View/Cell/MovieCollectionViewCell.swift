//
//  MovieCollectionViewCell.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.layer.cornerRadius = 5
    }
    
    func configureCellData(viewModel: NowPlayingMovieCellViewModel) {
        titleLabel.text = viewModel.title
        posterImageView.sd_setImage(with: viewModel.image)
        
    }
    
}
