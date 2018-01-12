//
//  ViewController.swift
//  CollectionViewWithinTableView
//
//  Created by Kimberly Seltzer on 1/11/18.
//  Copyright © 2018 Kim Seltzer. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Variables
    var colors: [[UIColor]] = [[.red, .blue, .yellow, .orange, .blue, .orange, .purple], [.red, .blue, .yellow, .orange, .blue, .orange, .purple], [.red, .blue, .yellow, .orange, .blue, .orange, .purple], [.red, .blue, .yellow, .orange, .blue, .orange, .purple], [.red, .blue, .yellow, .orange, .blue, .orange, .purple], [.red, .blue, .yellow, .orange, .blue, .orange, .purple], [.red, .blue, .yellow, .orange, .blue, .orange, .purple]]
    var storedOffsets: [Int: CGFloat] = [:]
    
    
    // MARK: - Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 216
        
        // register cells
        tableView.register(UINib(nibName: kTableViewCell, bundle: nil), forCellReuseIdentifier: kTableViewCell)
    }
    
    
    // MARK: Table View
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCell, for: indexPath) as! TableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }
        cell.setCollectionViewDataSourceAndDelegate(self, forRow: indexPath.row)
        cell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableViewCell else { return }
        storedOffsets[indexPath.row] = cell.collectionViewOffset
    }
    
}

// MARK: - Collection View
extension ViewController: CollectionViewDelegateAndDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionViewCell, for: indexPath) as! CollectionViewCell
        cell.backgroundColor = colors[collectionView.tag][indexPath.item]
        
        if (indexPath.row == colors[collectionView.tag].count - 1) {
            print("load more cells")
        }
        
        return cell
    }
}
