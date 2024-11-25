//
// ZTUIKitExt
//
// GitHub Repo and Documentation: https://github.com/willonboy/ZTUIKitExt
//
// Copyright © 2024 Trojan Zhang. All rights reserved.
//
// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/.
//

import UIKit
import ZTChain

@MainActor
public extension ZTWrapper where Subject : UIView {
    func corner(_ r:CGFloat) -> Self {
        subject.layer.cornerRadius = r
        return self
    }
    
    func maskedCorners(_ m:CACornerMask) -> Self {
        subject.layer.maskedCorners = m
        return self
    }
    
    func cornerCurve(_ c:CALayerCornerCurve) -> Self {
        subject.layer.cornerCurve = c
        return self
    }
    
    func borderColor(_ c:CGColor?) -> Self {
        subject.layer.borderColor = c
        return self
    }
    
    func borderWidth(_ w:CGFloat) -> Self {
        subject.layer.borderWidth = w
        return self
    }
    
    func opacity(_ o:Float) -> Self {
        subject.layer.opacity = o
        return self
    }
    
    func masksToBounds(_ m:Bool) -> Self {
        subject.layer.masksToBounds = m
        return self
    }
    
    func mask(_ m:CALayer?) -> Self {
        subject.layer.mask = m
        return self
    }
    
    func shadowColor(_ c:CGColor?) -> Self {
        subject.layer.shadowColor = c
        return self
    }
    
    func shadowOpacity(_ o:Float) -> Self {
        subject.layer.shadowOpacity = o
        return self
    }
    
    func shadowOffset(_ s:CGSize) -> Self {
        subject.layer.shadowOffset = s
        return self
    }
    
    func shadowRadius(_ r:CGFloat) -> Self {
        subject.layer.shadowRadius = r
        return self
    }
    
    func shadowPath(_ p:CGPath?) -> Self {
        subject.layer.shadowPath = p
        return self
    }
}


@MainActor
public extension UIView {
    @MainActor
    class ZTGestureHandler {
        public private(set) var isValid:Bool = true
        public var gesture: UIGestureRecognizer
        private var onAction: (UIGestureRecognizer, ZTGestureHandler) -> Void
        public init(gesture: UIGestureRecognizer, onAction: @escaping (UIGestureRecognizer, ZTGestureHandler) -> Void) {
            self.gesture = gesture
            self.onAction = onAction
            gesture.addTarget(self, action: #selector(onGesture(sender:)))
        }
        
        @objc func onGesture(sender:UIGestureRecognizer) {
            onAction(sender, self)
        }
        
        public func cancel() {
            guard isValid else { return }
            gesture.removeTarget(self, action: #selector(onGesture(sender:)))
            isValid = false
        }
    }
    
    @discardableResult
    func onTap(_ tapCount:Int = 1, tapFinger:Int = 1, _ action:@escaping (UIGestureRecognizer, ZTGestureHandler) -> Void) -> ZTGestureHandler {
        let t = UITapGestureRecognizer().zt
            .numberOfTapsRequired(tapCount)
            .numberOfTouchesRequired(tapFinger).build()
        addGestureRecognizer(t)
        isUserInteractionEnabled = true
        
        let h = ZTGestureHandler(gesture: t, onAction: action)
        recordGestureHandler(h)
        return h
    }
    
    @discardableResult
    func onLongPress(_ tapFinger:Int = 1, _ action:@escaping (UIGestureRecognizer, ZTGestureHandler) -> Void) -> ZTGestureHandler {
        let t = UILongPressGestureRecognizer().zt
            .numberOfTouchesRequired(tapFinger).build()
        addGestureRecognizer(t)
        isUserInteractionEnabled = true
        
        let h = ZTGestureHandler(gesture: t, onAction: action)
        recordGestureHandler(h)
        return h
    }
    
    @discardableResult
    func onPan(_ action:@escaping (UIGestureRecognizer, ZTGestureHandler) -> Void) -> ZTGestureHandler {
        let t = UIPanGestureRecognizer()
        addGestureRecognizer(t)
        isUserInteractionEnabled = true
        
        let h = ZTGestureHandler(gesture: t, onAction: action)
        recordGestureHandler(h)
        return h
    }
    
    @discardableResult
    func onSwipe(_ direction:UISwipeGestureRecognizer.Direction = .right, tapFinger:Int = 1, _ action:@escaping (UIGestureRecognizer, ZTGestureHandler) -> Void) -> ZTGestureHandler {
        let t = UISwipeGestureRecognizer().zt
            .direction(direction)
            .numberOfTouchesRequired(tapFinger).build()
        addGestureRecognizer(t)
        isUserInteractionEnabled = true
        
        let h = ZTGestureHandler(gesture: t, onAction: action)
        recordGestureHandler(h)
        return h
    }
    
    private func recordGestureHandler(_ handler: ZTGestureHandler) {
        if gestureHandlers == nil {
            gestureHandlers = []
        } else {
            gestureHandlers?.removeAll(where: { !$0.isValid })
        }
        gestureHandlers?.append(handler)
    }
    
    private static var zt_gestureHandlersKey: UInt8 = 0
    var gestureHandlers: [ZTGestureHandler]? {
        get {
            return objc_getAssociatedObject(self, &Self.zt_gestureHandlersKey) as? [ZTGestureHandler]
        }
        set {
            objc_setAssociatedObject(self, &Self.zt_gestureHandlersKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

@MainActor
public extension ZTWrapper where Subject : UIView {
    @discardableResult
    func onTap(_ tapCount:Int = 1, tapFinger:Int = 1, _ action:@escaping (UIGestureRecognizer, UIView.ZTGestureHandler) -> Void) -> Self {
        subject.onTap(tapCount, tapFinger: tapFinger, action)
        return self
    }
    
    @discardableResult
    func onLongPress(_ tapFinger:Int = 1, _ action:@escaping (UIGestureRecognizer, UIView.ZTGestureHandler) -> Void) -> Self {
        subject.onLongPress(tapFinger, action)
        return self
    }
    
    @discardableResult
    func onPan(_ action:@escaping (UIGestureRecognizer, UIView.ZTGestureHandler) -> Void) -> Self {
        subject.onPan(action)
        return self
    }
    
    @discardableResult
    func onSwipe(_ direction:UISwipeGestureRecognizer.Direction = .right, tapFinger:Int = 1, _ action:@escaping (UIGestureRecognizer, UIView.ZTGestureHandler) -> Void) -> Self {
        subject.onSwipe(direction, action)
        return self
    }
}
