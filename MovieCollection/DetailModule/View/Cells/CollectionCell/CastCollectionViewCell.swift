//
//  CastCollectionViewCell.swift
//  MovieCollection
//
//  Created by anita on 13.09.2022.
//

import UIKit
import SDWebImage

class CastCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Views

    @IBOutlet private weak var castImage: UIImageView!
    @IBOutlet private weak var castName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        castImage.layer.cornerRadius = 5
    }
    
    func configureCellData(viewModel: CastCollectionViewModel) {
        castName.text = viewModel.name
        castImage.sd_setImage(with: viewModel.image)
    }

}
