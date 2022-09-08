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
        
        layout.minimumLineSpacing = InsetConstants.minimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: InsetConstants.leftDistanceToView, bottom: 0, right: InsetConstants.rightDistanceToView)
        
        showsHorizontalScrollIndicator = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Data Source
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "\(MovieCollectionViewCell.self)", for: indexPath) as? MovieCollectionViewCell
        
        return cell ?? UICollectionViewCell()
    }
    
    // MARK: - Flow Layout Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: InsetConstants.itemWidth, height: InsetConstants.itemHeight)
    }
    
}
