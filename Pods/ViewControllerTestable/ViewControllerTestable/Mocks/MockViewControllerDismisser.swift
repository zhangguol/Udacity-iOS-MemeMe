//
//  MockViewControllerDismisser.swift
//  ViewControllerTestable
//
//  Created by Boxuan Zhang on 3/16/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import Foundation

public class MoockViewControllerDismisser: ViewControllerDismissable {

    public init() {}

    public var dismiss_wasCalled = false
    public var dismiss_wasCalled_withArgs: (viewController: UIViewController, animated: Bool)?
    public var dismiss_completion: (() -> Void)?

    public func dismiss(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        dismiss_wasCalled = true
        dismiss_wasCalled_withArgs = (viewController, animated)
        dismiss_completion = completion
    }
}
