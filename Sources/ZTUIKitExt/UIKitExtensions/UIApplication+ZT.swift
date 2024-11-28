//
//  UIApplication+ZT.swift
//  ZTUIKitDemo
//
//  Created by zt on 2024/11/28.
//

import UIKit
import ZTChain

public extension ZTWrapper where Subject : UIApplication {
    // just for iPhone iTouch
    var keyWindow: UIWindow? {
        for scene in subject.connectedScenes {
            if let windowScene = scene as? UIWindowScene,
               windowScene.activationState == .foregroundActive ||
               windowScene.activationState == .background {
                for window in windowScene.windows {
                    if window.windowLevel != .normal || window.isHidden {
                        continue
                    }
                    if window.bounds == UIScreen.main.bounds && window.isKeyWindow {
                        return window
                    }
                }
            }
        }
        
        var keyWindow: UIWindow? = nil
        for window in subject.windows {
            if window.windowLevel == .normal && !window.isHidden && window.bounds == UIScreen.main.bounds && window.isKeyWindow {
                keyWindow = window
                break
            }
        }
        
        if keyWindow == nil {
            keyWindow = subject.delegate?.window ?? nil
        }
        return keyWindow
    }
}
