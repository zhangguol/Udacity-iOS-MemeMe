//
//  MockViewControllerPusher.swift
//  ViewControllerTestable
//
//  Created by Boxuan Zhang on 3/16/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import Foundation

public class MockViewControllerPusher: ViewControllerPushable {

    public init() {}

    public var push_wasCalled = false
    public var push_wasCalled_withArgs: (viewControlelr: UIViewController, in: UINavigationController, animated: Bool)?

    public func push(_ viewController: UIViewController, in navigationControler: UINavigationController, animated: Bool) {
        push_wasCalled = true
        push_wasCalled_withArgs = (viewController, navigationControler, animated)
    }
}
