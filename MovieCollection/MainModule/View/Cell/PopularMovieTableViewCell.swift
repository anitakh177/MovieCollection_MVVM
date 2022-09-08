//
//  PopularMovieTableViewCell.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import UIKit

class PopularMovieTableViewCell: UITableViewCell {
    
    // MARK: - Views

    @IBOutlet private weak var movieImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var durationLabel: UILabel!
    
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
      configureAppearance()
    }
    
    private func configureAppearance() {
        movieImageView.layer.cornerRadius = 5
    }
    
    func configureCellData(viewModel: PopularMovieCellViewModel) {
        titleLabel.text = viewModel.title
        durationLabel.text =  viewModel.releaseDate
        ratingLabel.text =  "\(viewModel.rating)/10"
       
        downloadTask = movieImageView.loadImage(url: viewModel.image!)
        
        
    }
    
    
}
