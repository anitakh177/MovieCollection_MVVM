//
//  CollectionTableViewCell.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
     let movieCollectionView = CollectionView()
    
    // MARK: - Views

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        contentView.backgroundColor = .black
        contentView.addSubview(movieCollectionView)
        
        NSLayoutConstraint.activate([
            movieCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieCollectionView.topAnchor.constraint(equalTo: topAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        

        ])
    }
    
    
    
}
