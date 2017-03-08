//
//  Meme.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 3/5/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit

struct Meme {
    let uuid: String
    
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memedImage: UIImage
    
    init(topText: String,
         bottomText: String,
         originalImage: UIImage,
         memedImage: UIImage) {
        
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
        
        self.uuid = UUID().uuidString
    }
}

extension Meme: Equatable {
    static func == (lhs: Meme, rhs: Meme) -> Bool {
        return lhs.uuid == rhs.uuid
    }
}
