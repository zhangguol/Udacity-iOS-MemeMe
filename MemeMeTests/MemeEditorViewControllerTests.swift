//
//  MemeEditorViewControllerTests.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 3/21/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import XCTest
@testable import MemeMe
import ViewControllerTestable

class MemeEditorViewControllerTests: XCTestCase {

    var sut: MemeEditorViewController!
    var mockPresenter: MockViewControllerPresenter!
    var mockDismisser: MoockViewControllerDismisser!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController

        mockPresenter = MockViewControllerPresenter()
        mockDismisser = MoockViewControllerDismisser()

        sut.viewControllerPresenter = mockPresenter
        sut.viewControllerDismisser = mockDismisser

        _ = sut.view
    }

    // MARK: Life Cycle
    func testOutlets() {
        XCTAssertNotNil(sut.topTextField)
        XCTAssertNotNil(sut.bottomTextField)
        XCTAssertNotNil(sut.imageView)
        XCTAssertNotNil(sut.actionButton)
        XCTAssertNotNil(sut.cancelButton)
        XCTAssertNotNil(sut.cameraButton)
        XCTAssertNotNil(sut.toolBar)
    }

    func testViewDidLoad() {
        [sut.topTextField, sut.bottomTextField].forEach {
            XCTAssertFalse($0!.defaultTextAttributes.isEmpty)
            XCTAssert($0!.delegate === sut)
            XCTAssert($0!.autocapitalizationType == .allCharacters)
            XCTAssert($0!.textAlignment == .center)
        }

        XCTAssert(sut.cameraButton.isEnabled == UIImagePickerController.isSourceTypeAvailable(.camera))

        XCTAssert(sut.actionButton.isEnabled == false)
    }

    // MARK: - Actions
    func testActionButton() {
        sut.actionButtonTapped(sut.actionButton)

        let presentedVC = mockPresenter.present_wasCalled_withArgs!.viewController
        XCTAssert(presentedVC is UIActivityViewController)
    }

    func testCancelButton() {
        sut.cancelButtonTapped(UIBarButtonItem())

        XCTAssert(mockDismisser.dismiss_wasCalled == true)
    }

    func testAlbumButton() {
        sut.albumButtonTapped(UIBarButtonItem())

        let presentedVC = mockPresenter.present_wasCalled_withArgs?.viewController as! UIImagePickerController
        XCTAssert(presentedVC.sourceType == .photoLibrary)
        XCTAssert(presentedVC.delegate === sut)
        
    }

    // MARK: - Image Picker
    func testImagePickerControllerDidFinishPickingMediaWithInfo() {
        let image = UIImage()
        let picker = UIImagePickerController()
        sut.imagePickerController(picker,
                                  didFinishPickingMediaWithInfo: [UIImagePickerControllerOriginalImage: image])

        XCTAssert(sut.imageView.image == image)
        [sut.actionButton, sut.cancelButton].forEach {
            XCTAssert($0!.isEnabled == true)
        }

        let dismissedVC = mockDismisser.dismiss_wasCalled_withArgs!.viewController
        XCTAssert(dismissedVC === picker)
    }

    func testImagePickerControllerDidCancel() {
        let picker = UIImagePickerController()
        sut.imagePickerControllerDidCancel(picker)

        let dismissedVC = mockDismisser.dismiss_wasCalled_withArgs!.viewController
        XCTAssert(dismissedVC === picker)
    }

    // MARK: - Keyboard
    private let notification = Notification(name: Notification.Name("Test"),
                                    object: nil,
                                    userInfo: [UIKeyboardFrameEndUserInfoKey: CGRect(origin: .zero, size: CGSize(width: 50, height: 100))])
    func testKeyboardWillShow() {
        sut.bottomTextField = FakeTextField(frame: .zero)

        sut.keyboardWillShow(notification)

        XCTAssert(sut.view.frame.origin.y == -100.0)
    }

    func testKeyboardWillHide() {
        sut.bottomTextField = FakeTextField(frame: .zero)
        sut.keyboardWillShow(notification)
        sut.keyboardWillHide(Notification(name: Notification.Name("Test")))

        XCTAssert(sut.view.frame.origin.y == 0)
    }

    // MARK: - TextField Delegates
    func testTextFieldDidBeginEditing() {
        sut.topTextField.text = "TOP"
        sut.textFieldDidBeginEditing(sut.topTextField)

        XCTAssert(sut.topTextField.text == "")
    }

    func testTextFieldShouldReturn() {
        let fakeTextField = FakeTextField(frame: .zero)
        sut.topTextField = fakeTextField

        let actual = sut.textFieldShouldReturn(sut.topTextField)

        XCTAssert(actual)
        XCTAssert(fakeTextField.endEditing_wasCalled)
    }

}

private extension MemeEditorViewControllerTests {
    class FakeTextField: UITextField {
        fileprivate override var isFirstResponder: Bool {
            return true
        }

        var endEditing_wasCalled = false
        fileprivate override func endEditing(_ force: Bool) -> Bool {
            endEditing_wasCalled = true
            return true
        }
    }
}
