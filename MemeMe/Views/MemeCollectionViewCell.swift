//
//  MemeCollectionViewCell.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 4/3/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configure(with meme: Meme) {
        imageView.image = meme.memedImage
    }
}

extension MemeCollectionViewCell {
    static let cellIdentifier = "MemeCollectionViewCell"
}
