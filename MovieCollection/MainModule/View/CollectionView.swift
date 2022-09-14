//
//  CollectionView.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import UIKit

class CollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        backgroundColor = .black
        
        register(UINib(nibName: "\(MovieCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(MovieCollectionViewCell.self)")
        
        translatesAutoresizingMaskIntoConstraints = false
        
        layout.minimumLineSpacing = MovieInsetConstants.minimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: MovieInsetConstants.leftDistanceToView, bottom: 0, right: MovieInsetConstants.rightDistanceToView)
        
        showsHorizontalScrollIndicator = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Properties
    var viewModel = MainViewModel()
    var movieDataSource: [NowPlayingMovieCellViewModel] = []
    
    func configure(with model: [NowPlayingMovieCellViewModel]) {
        self.movieDataSource = model
        reloadData()
       
    }
    
    // MARK: - Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // print(viewModel.nowPlayingModel?.results)
        return  viewModel.numberOfRows(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "\(MovieCollectionViewCell.self)", for: indexPath) as? MovieCollectionViewCell
      
       // cell?.configureCellData(viewModel: movieDataSource[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
    
    // MARK: - Flow Layout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: MovieInsetConstants.itemWidth, height: MovieInsetConstants.itemHeight)
    }
    
}
