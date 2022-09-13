//
//  ImageTableViewCell.swift
//  MovieCollection
//
//  Created by anita on 09.09.2022.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    // MARK: - Views
    
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var roundedCornerView: UIView!
    
    // MARK: - Properties
    
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAppearance()
    }

    private func configureAppearance() {
        roundedCornerView.layer.cornerRadius = 15
        roundedCornerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    func configureCellData(viewModel: DetailTableCellViewModel) {
        
        downloadTask = movieImage.loadImage(url: viewModel.image!)
    
    }
}
