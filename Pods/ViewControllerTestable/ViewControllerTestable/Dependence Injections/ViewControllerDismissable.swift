//
//  ViewControllerDismissable.swift
//  ViewControllerTestable
//
//  Created by Boxuan Zhang on 3/14/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import Foundation

public protocol ViewControllerDismissable {
    func dismiss(_ viewController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?)
}

public class ViewControllerDismisser: ViewControllerDismissable {
    
    public init() {}
    
    public static let shared = ViewControllerDismisser()
    
    public func dismiss(_ viewController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?) {
        
        viewController.dismiss(animated: animated, completion: completion)
    }
}
