//
//  DataStoreProtocol.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 3/5/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import Foundation

protocol MemeDataStoreProtocol {
    func store(meme: Meme)
    func remove(meme: Meme) -> Meme?
}
