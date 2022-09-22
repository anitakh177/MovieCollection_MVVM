//
//  PlayingTableViewCell.swift
//  MovieCollection
//
//  Created by anita on 17.09.2022.
//

import UIKit

class PlayingTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    // MARK: - Properties
    
    var playingMovieCellDataSource = [NowPlayingMovieCellViewModel]()
    
    // MARK: - Events
    
    var didSelectMovie: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "\(MovieCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MovieCollectionViewCell.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func updateCell(with model: [NowPlayingMovieCellViewModel]) {
        self.playingMovieCellDataSource = model
        collectionView.reloadData()
    }
    
}

extension PlayingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playingMovieCellDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MovieCollectionViewCell.self)", for: indexPath) as? MovieCollectionViewCell
        let viewModel = playingMovieCellDataSource[indexPath.row]
        cell?.configureCellData(viewModel: viewModel)
        
        return cell ?? UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: MovieInsetConstants.itemWidth, height: MovieInsetConstants.itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return MovieInsetConstants.minimumLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectMovie?(indexPath.item)
        
    }
    
}
