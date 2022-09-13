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
    
    // MARK: - Properties
    
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellData(viewModel: NowPlayingMovieCellViewModel) {
        titleLabel.text = viewModel.title
        downloadTask = posterImageView.loadImage(url: viewModel.image!)
        
        
    }
    

    
}
