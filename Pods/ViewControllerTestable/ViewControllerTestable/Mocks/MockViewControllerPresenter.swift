//
//  MockViewControllerPresenter.swift
//  ViewControllerTestable
//
//  Created by Boxuan Zhang on 3/16/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import Foundation

public class MockViewControllerPresenter: ViewControllerPresentable {

    public init() {}

    public var present_wasCalled = false
    public var present_wasCalled_withArgs: (viewController: UIViewController, from: UIViewController, animated: Bool)?
    public var present_completion: (() -> Void)?

    public func present(_ viewController: UIViewController,
                        from aViewController: UIViewController,
                        animated: Bool,
                        completion: (() -> Void)?) {

        present_wasCalled = true
        present_wasCalled_withArgs = (viewController, aViewController, animated)
        present_completion = completion
    }
}
