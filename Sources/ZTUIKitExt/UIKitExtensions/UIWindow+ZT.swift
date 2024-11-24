//
//  UIWindow+ZT.swift
//  ZTUIKitDemo
//
//  Created by zt on 2024/11/23.
//

import UIKit

public extension UIWindow {
    convenience init(_ key:Bool = true, _ visable:Bool = true, @ZTVCBuilder rootVC: () -> UIViewController) {
        self.init(frame: UIScreen.main.bounds)
        rootViewController = rootVC()
        backgroundColor = .white
        if visable {
            makeKeyAndVisible()
        } else if key {
            makeKey()
        }
    }
}
