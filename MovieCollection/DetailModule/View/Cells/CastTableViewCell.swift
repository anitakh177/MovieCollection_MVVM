//
//  CastTableViewCell.swift
//  MovieCollection
//
//  Created by anita on 13.09.2022.
//

import UIKit

final class CastTableViewCell: UITableViewCell {
    
    // MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var castCellDataSource = [CastCollectionViewModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "\(CastCollectionViewCell.self)", bundle: .main), forCellWithReuseIdentifier: "\(CastCollectionViewCell.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(with model: [CastCollectionViewModel]) {
        self.castCellDataSource = model
        collectionView.reloadData()
    }
    
}
// MARK: - CollectionView

extension CastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castCellDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CastCollectionViewCell.self)", for: indexPath) as? CastCollectionViewCell
        let viewModel = castCellDataSource[indexPath.row]
        cell?.configureCellData(viewModel: viewModel)
        
        return cell ?? UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: CastInsetConstants.itemWidth, height: CastInsetConstants.itemHeight)
    }
    
}
