//
//  AlertPresentable.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 3/6/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit
import ViewControllerTestable

protocol AlertPresentable {
    var alertPresenter: ViewControllerPresentable { get }
}

extension AlertPresentable where Self: UIViewController, Self: ViewControllerTestable {
    var alertPresenter: ViewControllerPresentable { return viewControllerPresenter }
    
    func showErrorAlert(with message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        alertPresenter.present(alert, from: self, animated: true, completion: nil)
    }
}
