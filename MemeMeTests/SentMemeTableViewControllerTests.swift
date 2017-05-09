//
//  SentMemeTableViewControllerTests.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 4/28/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import XCTest
import ViewControllerTestable
@testable import MemeMe

class SentMemeTableViewControllerTests: XCTestCase {

    var sut: SentMemeTableViewController!
    var mockPresenter: MockViewControllerPresenter!
    var mockDismisser: MoockViewControllerDismisser!
    var mockPusher: MockViewControllerPusher!
    var fakeDataStore: FakeDataStore!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SentMemeTableViewController") as! SentMemeTableViewController

        mockPresenter = MockViewControllerPresenter()
        mockDismisser = MoockViewControllerDismisser()
        mockPusher = MockViewControllerPusher()
        fakeDataStore = FakeDataStore()

        sut.viewControllerPresenter = mockPresenter
        sut.viewControllerDismisser = mockDismisser
        sut.viewControllerPusher = mockPusher
        sut.dataStore = fakeDataStore

        _ = sut.view
    }

    func testNumberOfRows() {
        let actual = sut.tableView(sut.tableView, numberOfRowsInSection: 0)

        XCTAssert(actual == 1)
    }

    func testTableViewCell() {
        let f = sut.tableView(_:cellForRowAt:)
        let cell = f(sut.tableView, IndexPath(row: 0, section: 0)) as? MemeTableViewCell
        XCTAssert(cell?.memeLabel.text == "top...bottom")
    }
    
    func testSelectCell() {
        let _ = UINavigationController(rootViewController: sut)
        
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    
        let vc = mockPusher.push_wasCalled_withArgs?.viewControlelr as? ViewMemeViewController
        
        XCTAssert(vc?.meme == fakeDataStore.memes.first!)
    }
    
    func testDeleteCell() {
        let fakeTableView = FakeTableView(frame: .zero)
        sut.tableView(fakeTableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssert(fakeDataStore.remove_wasCalled_withMeme == fakeDataStore.memes.first)
        XCTAssert(fakeTableView.deleteRows_wasCalled_withIndexPaths?[0] == IndexPath(row: 0, section: 0))
    }
}

private extension SentMemeTableViewControllerTests {
    class FakeTableView: UITableView {
        var deleteRows_wasCalled_withIndexPaths: [IndexPath]? = nil
        override func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation) {
            deleteRows_wasCalled_withIndexPaths = indexPaths
        }
    }
}








