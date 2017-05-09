//
//  SentMemeCollectionViewControllerTests.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 5/2/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import XCTest
import ViewControllerTestable
@testable import MemeMe

class SentMemeCollectionViewControllerTests: XCTestCase {
    
    var sut: SentMemeCollectionViewController!
    var mockPusher: MockViewControllerPusher!
    var fakeDataStore: FakeDataStore!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SentMemeCollectionViewController") as! SentMemeCollectionViewController

        mockPusher = MockViewControllerPusher()
        fakeDataStore = FakeDataStore()

        sut.viewControllerPusher = mockPusher
        sut.dataStore = fakeDataStore

        _ = sut.view
    }
    
    func testViewDidLoad() {
        XCTAssert(sut.flowLayout.minimumLineSpacing == 3.0)
        XCTAssert(sut.flowLayout.minimumInteritemSpacing == 3.0)
    }
    
    func testNumberOfCells() {
        let actual = sut.collectionView(sut.collectionView!, numberOfItemsInSection: 0)
        
        XCTAssert(actual == 1)
    }
    
    func testCollectionViewCell() {
        let cell = sut.collectionView(
            sut.collectionView!,
            cellForItemAt: IndexPath(item: 0, section: 0)
        ) as? MemeCollectionViewCell
        
        XCTAssert(cell?.imageView.image != nil)
    }
    
    func testSelectCell() {
        let _ = UINavigationController(rootViewController: sut)
        
        sut.collectionView(sut.collectionView!, didSelectItemAt: IndexPath(item: 0, section: 0))
        
        let vc = mockPusher.push_wasCalled_withArgs?.viewControlelr as? ViewMemeViewController
        XCTAssert(vc?.meme == fakeDataStore.memes.first!)
    }
}
