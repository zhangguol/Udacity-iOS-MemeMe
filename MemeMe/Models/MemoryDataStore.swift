//
//  MemoryDataStore.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 3/5/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import Foundation

class MemeoryMemeDataStore: MemeDataStoreProtocol {
    private init() {}
    
    static let shared = MemeoryMemeDataStore()
    
    private(set) var memes: [Meme] = []
    
    func store(meme: Meme) {
        memes.append(meme)
    }
    
    func remove(meme: Meme) -> Meme? {
        guard let index = memes.index(of: meme) else { return nil }
        return memes.remove(at: index)
    }
}
