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
    @IBOutlet private weak var releaseLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    
   
    
    // MARK: - Properties
    
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
        releaseLabel.text = viewModel.releaseDate
        ratingLabel.text =  "\(viewModel.rating)/10 IMDb"
        genreLabel.text = viewModel.genres
       
        if let imageURL = viewModel.image {
            downloadTask = movieImageView.loadImage(url: imageURL)
        }
     
        
    }
    
    
}
