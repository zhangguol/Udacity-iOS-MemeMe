//
//  ViewControllerPresentable.swift
//  ViewControllerTestable
//
//  Created by Boxuan Zhang on 3/14/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import Foundation

public protocol ViewControllerPresentable {
    func present(_ viewController: UIViewController,
                 from aViewController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?)
}

public class ViewControllerPresenter: ViewControllerPresentable {

    public init() {}
    
    public static let shared = ViewControllerPresenter()
    
    public func present(_ viewController: UIViewController,
                 from aViewController: UIViewController,
                 animated: Bool,
                 completion: (() -> Void)?) {
        
        aViewController.present(viewController, animated: animated, completion: completion)
    }
}
