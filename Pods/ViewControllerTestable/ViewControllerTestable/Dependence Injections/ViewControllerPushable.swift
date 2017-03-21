//
//  ViewControllerPushable.swift
//  ViewControllerTestable
//
//  Created by Boxuan Zhang on 3/14/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import Foundation

public protocol ViewControllerPushable {
    func push(_ viewController: UIViewController,
              in navigationControler: UINavigationController,
              animated: Bool)
}

public class ViewControllerPusher: ViewControllerPushable {
    
    public init() {}
    
    public static let shared = ViewControllerPusher()
    
    public func push(_ viewController: UIViewController,
              in navigationControler: UINavigationController,
              animated: Bool) {
        
        navigationControler.pushViewController(viewController, animated: animated)
    }
}
