//
//  ViewControllerTestable.swift
//  ViewControllerTestable
//
//  Created by Boxuan Zhang on 3/14/17.
//  Copyright © 2017 Boxuan Zhang. All rights reserved.
//

import Foundation

public protocol ViewControllerTestable {
    var viewControllerPresenter: ViewControllerPresentable { get set }
    var viewControllerDismisser: ViewControllerDismissable { get set }
    var viewControllerPusher: ViewControllerPushable { get set }
}

public extension ViewControllerTestable where Self: UIViewController {
    
    
    public var viewControllerPresenter: ViewControllerPresentable {
        get {
            let presenter = objc_getAssociatedObject(self,
                                                     RuntimeKey.presentKey) as? ViewControllerPresentable
            return presenter ?? ViewControllerPresenter.shared
        }
        
        set {
            objc_setAssociatedObject(self,
                                     RuntimeKey.presentKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var viewControllerDismisser: ViewControllerDismissable {
        get {
            let dismisser = objc_getAssociatedObject(self,
                                                     RuntimeKey.dismissKey) as? ViewControllerDismissable
            return dismisser ?? ViewControllerDismisser.shared
        }
        
        set {
            objc_setAssociatedObject(self,
                                     RuntimeKey.dismissKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var viewControllerPusher: ViewControllerPushable {
        get {
            let pusher = objc_getAssociatedObject(self,
                                                  RuntimeKey.pushKey) as? ViewControllerPushable
            return pusher ?? ViewControllerPusher.shared
        }
        
        set {
            objc_setAssociatedObject(self,
                                     RuntimeKey.pushKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

extension UIViewController {
    struct RuntimeKey {
        static let presentKey = UnsafeRawPointer(bitPattern: "present_key".hashValue)
        static let dismissKey = UnsafeRawPointer(bitPattern: "dismiss_key".hashValue)
        static let pushKey = UnsafeRawPointer(bitPattern: "push_key".hashValue)
    }
}
