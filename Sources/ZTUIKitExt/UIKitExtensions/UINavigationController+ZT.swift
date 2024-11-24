//
//  UINavigationController.swift
//  ZTUIKitDemo
//
//  Created by zt on 2024/11/23.
//

import UIKit


public extension UINavigationController {
    
    convenience init(@ZTVCBuilder root: () -> UIViewController) {
        self.init(rootViewController: root())
    }
    
    convenience init(@ZTVCBuilder vcs: () -> [UIViewController]) {
        self.init()
        viewControllers = vcs()
    }
}
