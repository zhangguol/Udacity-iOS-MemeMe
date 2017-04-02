//
//  MemeMeTests.swift
//  MemeMeTests
//
//  Created by Boxuan Zhang on 3/5/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import XCTest
@testable import MemeMe

class MemeTests: XCTestCase {

    let image1 = UIImage()
    let image2 = UIImage()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testInitializer() {
        let sut = Meme(topText: "testTop",
                       bottomText: "testBottom",
                       originalImage: image1,
                       memedImage: image2)

        XCTAssert(sut.topText == "testTop")
        XCTAssert(sut.bottomText == "testBottom")
        XCTAssert(sut.originalImage == image1)
        XCTAssert(sut.memedImage == image2)
    }

    func testEquatable() {
        let sut1 = Meme(topText: "testTop",
                       bottomText: "testBottom",
                       originalImage: image1,
                       memedImage: image2)
        let sut2 = Meme(topText: "testTop",
                       bottomText: "testBottom",
                       originalImage: image1,
                       memedImage: image2)

        XCTAssert(sut1 == sut1)
        XCTAssert(sut1 != sut2)
    }

}
