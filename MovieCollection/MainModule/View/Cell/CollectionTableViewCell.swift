//
//  CollectionTableViewCell.swift
//  MovieCollection
//
//  Created by anita on 07.09.2022.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let collectionView2 = CollectionView()
    
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
        contentView.addSubview(collectionView2)
        
        NSLayoutConstraint.activate([
            collectionView2.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView2.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView2.topAnchor.constraint(equalTo: topAnchor),
            collectionView2.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        
        ])
    }
    
}
