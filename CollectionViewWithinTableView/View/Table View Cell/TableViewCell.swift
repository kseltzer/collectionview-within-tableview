//
//  TableViewCell.swift
//  CollectionViewWithinTableView
//
//  Created by Kimberly Seltzer on 1/11/18.
//  Copyright © 2018 Kim Seltzer. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
    // MARK: - Variables
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    
    // MARK: - Setup
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // register cells
        collectionView.register(UINib(nibName: kCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: kCollectionViewCell)
    }
    
    func setCollectionViewDataSourceAndDelegate(_ dataSourceAndDelegate: CollectionViewDelegateAndDataSource, forRow row: Int) {
        collectionView.delegate = dataSourceAndDelegate
        collectionView.dataSource = dataSourceAndDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    
}
