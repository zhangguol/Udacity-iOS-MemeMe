//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 4/1/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var memeLabel: UILabel!
    
    func configure(with meme: Meme) {
        memeImageView.image = meme.memedImage
        memeLabel.text = "\(meme.topText)...\(meme.bottomText)"
    }
}

extension MemeTableViewCell {
    static let cellIdentifier = "MemeTableViewCell"
}
