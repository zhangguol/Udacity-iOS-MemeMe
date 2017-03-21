//
//  MemeoryDataStoreTests.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 3/21/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import XCTest
@testable import MemeMe

class MemoryDataStoreTests: XCTestCase {

    let meme1 = Meme(topText: "top1",
                     bottomText: "bottom1",
                     originalImage: UIImage(),
                     memedImage: UIImage())
    let meme2 = Meme(topText: "top2",
                     bottomText: "bottom2",
                     originalImage: UIImage(),
                     memedImage: UIImage())

    var sut: MemeoryMemeDataStore!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        sut = MemeoryMemeDataStore()
        sut.store(meme: meme1)
    }

    func testStoreMeme() {
        sut.store(meme: meme2)
        XCTAssert(sut.memes == [meme1, meme2])
    }

    func testRemove() {
        sut.remove(meme: meme2)
        XCTAssert(sut.memes == [meme1])

        sut.remove(meme: meme1)
        XCTAssert(sut.memes.isEmpty)
    }
}
