//
//  ViewControllerDismissable.swift
//  MemeMe
//
//  Created by Boxuan Zhang on 3/5/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import UIKit

protocol ViewControllerDismissable {
    func dismiss(_ viewController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?)
}

class ViewControllerDismisser: ViewControllerDismissable {
    static let shared = ViewControllerDismisser()
    
    func dismiss(_ viewController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?) {
        
        viewController.dismiss(animated: animated, completion: completion)
    }
}
