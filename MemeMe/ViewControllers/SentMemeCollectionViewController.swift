//
//  SentMemeCollectionViewController.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 4/3/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit

class SentMemeCollectionViewController: UICollectionViewController {

    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var dataStore: MemeDataStoreProtocol = MemeoryMemeDataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set(flowLayout)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView?.reloadData()
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataStore.numberOfMemes
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemeCollectionViewCell.cellIdentifier, for: indexPath)
        
        let meme = dataStore.meme(at: indexPath.item)
        (cell as? MemeCollectionViewCell)?.configure(with: meme)
        
        return cell
    }
}

// MARK: - private methods
private extension SentMemeCollectionViewController {
    func set(_ aFlowLayout: UICollectionViewFlowLayout) {
        let space: CGFloat = 3.0
        let dimension = (min(view.frame.size.width, view.frame.size.height) - (2 * space)) / 3.0
        
        aFlowLayout.minimumInteritemSpacing = space
        aFlowLayout.minimumLineSpacing = space
        aFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
}
