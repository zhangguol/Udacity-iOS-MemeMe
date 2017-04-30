//
//  FakeDateStore.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 4/28/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit
@testable import MemeMe

class FakeDataStore: MemeDataStoreProtocol {
    var memes: [Meme] = [
        Meme(topText: "top", bottomText: "bottom", originalImage: UIImage(), memedImage: UIImage())
    ]

    var store_wasCalled_withMeme: Meme? = nil
    func store(meme: Meme) {
        store_wasCalled_withMeme = meme
    }

    var remove_wasCalled_withMeme: Meme? = nil
    @discardableResult
    func remove(meme: Meme) -> Meme? {
        remove_wasCalled_withMeme = meme
        return meme
    }
    
    var numberOfMemes: Int {
        return 1
    }

    func meme(at index: Int) -> Meme {
        return memes[index]
    }
}
