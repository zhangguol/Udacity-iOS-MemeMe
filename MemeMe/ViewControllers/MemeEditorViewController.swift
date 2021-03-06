//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 3/5/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit
import ViewControllerTestable

protocol MemeEditorViewControllerDelegate: class {
    func memeEditorViewControllerDidSendMeme(_ editorViewController: MemeEditorViewController)
}

class MemeEditorViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var toolBar: UIToolbar!
   
    weak var delegate: MemeEditorViewControllerDelegate?

    var memeToEdit: Meme?
    
    // MARK: - Dependence Injections
    var dataStore: MemeDataStoreProtocol = MemeoryMemeDataStore.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        [topTextField, bottomTextField].forEach {
            $0!.defaultTextAttributes = defaultMemeTextAttributes
            $0!.delegate = self
            $0!.autocapitalizationType = .allCharacters
            $0!.textAlignment = .center
        }
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
       
        if let memeToEdit = memeToEdit {
            configreUI(for: .editing(memeToEdit))
        } else {
            configreUI(for: .initial)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        subscribeNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        unsubscribeNotifications()
    }

    // MARK: - Button Actions
    @IBAction func actionButtonTapped(_ sender: UIBarButtonItem) {
        let memedImage = generateMemedImage()
       
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityVC.completionWithItemsHandler = { _, completed, _, error in
            guard completed else { return }
            
            if let error = error {
                let msg = "Failed to share the memed image, please try again.\n\(error.localizedDescription)"
                self.showErrorAlert(with: msg)
                return
            }
            
            self.save(memedImage: memedImage)
            self.viewControllerDismisser.dismiss(self, animated: true, completion: nil)
            self.delegate?.memeEditorViewControllerDidSendMeme(self)
        }

        viewControllerPresenter.present(activityVC, from: self, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        viewControllerDismisser.dismiss(self, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        pickAnImamge(from: .camera)
    }
    
    @IBAction func albumButtonTapped(_ sender: UIBarButtonItem) {
        pickAnImamge(from: .photoLibrary)
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    private func save(memedImage: UIImage) {
        guard let originalImage = imageView.image else { return }
        
        let meme = Meme(topText: topTextField.text ?? "",
                        bottomText: bottomTextField.text ?? "",
                        originalImage: originalImage,
                        memedImage: memedImage)
       
        dataStore.store(meme: meme)
    }
    
    private func generateMemedImage() -> UIImage {
        
        toolBar.isHidden = true

        // Render view to an image
        UIGraphicsBeginImageContext(imageView.frame.size)
        view.drawHierarchy(in: imageView.convert(view.bounds, from: view), afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolBar.isHidden = false
        
        return memedImage
    }
}

// MRAK: - UI States
extension MemeEditorViewController {
    enum UIState {
        case initial
        case editing(Meme?)
    }
    
    fileprivate func configreUI(for state: UIState) {
        func setButtons(isEnable: Bool) {
            actionButton.isEnabled = isEnable
        }
        
        switch state {
        case .initial:
            // Reset content
            imageView.image = nil
            topTextField.text = Constant.defaultTopText
            bottomTextField.text = Constant.defaultBottomText
            
            setButtons(isEnable: false)
        case let .editing(meme):
            setButtons(isEnable: true)
            
            if let meme = meme {
                imageView.image = meme.originalImage
                topTextField.text = meme.topText
                bottomTextField.text = meme.bottomText
            }
        }

        view.layoutIfNeeded()
    }
}

// MARK: - Textfield Attributes
extension MemeEditorViewController {
    fileprivate var defaultMemeTextAttributes: [String: Any] {
        return [
            NSStrokeColorAttributeName: UIColor.black,
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName: -2.5,
        ]
    }
}

// MARK: - Image Picker
extension MemeEditorViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    fileprivate func pickAnImamge(from sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        
        viewControllerPresenter.present(imagePicker, from: self, animated: true, completion: nil)
    }
    
    // Delegates
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewControllerDismisser.dismiss(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        imageView.image = image
        configreUI(for: .editing(nil))
        viewControllerDismisser.dismiss(picker, animated: true, completion: nil)
    }
}

// MARK: - Notifications
extension MemeEditorViewController {
    fileprivate func subscribeNotifications() {
        let notifications:[(Notification.Name, Selector)] = [
            (.UIKeyboardWillShow, #selector(keyboardWillShow(_:))),
            (.UIKeyboardWillHide, #selector(keyboardWillHide(_:)))
        ]
        
        notifications.forEach {
            NotificationCenter.default.addObserver(self, selector: $1, name: $0, object: nil)
        }
    }
    
    fileprivate func unsubscribeNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    private func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}

// MARK: - UITextFieldDelegates
extension MemeEditorViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if (textField == topTextField && textField.text == Constant.defaultTopText)
            || (textField == bottomTextField && textField.text == Constant.defaultBottomText) {
            textField.text = ""
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}

// MARK: - Alert
extension MemeEditorViewController: AlertPresentable {}

// MARK: - Misc
fileprivate extension MemeEditorViewController {
    struct Constant {
        private init() {}
        static let defaultTopText = "TOP"
        static let defaultBottomText = "BOTTOM"
    }
}

extension MemeEditorViewController: ViewControllerTestable {}
