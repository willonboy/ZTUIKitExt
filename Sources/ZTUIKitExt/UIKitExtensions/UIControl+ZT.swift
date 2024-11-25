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
public extension UIControl {
    private static var zt_eventHandlersKey: UInt8 = 0

    @MainActor
    class ZTEventHandler {
        public private(set) var isValid: Bool = true
        private var action: (UIControl, UIControl.Event, ZTEventHandler) -> Void
        private weak var control: UIControl?
        private var event: UIControl.Event
        
        public init(control: UIControl, event: UIControl.Event, action: @escaping (UIControl, UIControl.Event, ZTEventHandler) -> Void) {
            self.control = control
            self.event = event
            self.action = action
            control.addTarget(self, action: #selector(onEvent), for: event)
        }
        
        @objc private func onEvent() {
            guard let control = control else { return }
            action(control, event, self)
        }
        
        public func cancel() {
            guard isValid, let control = control else { return }
            control.removeTarget(self, action: #selector(onEvent), for: event)
            isValid = false
        }
    }
    
    @discardableResult
    func onEvent(_ event: UIControl.Event, _ action: @escaping (UIControl, UIControl.Event, ZTEventHandler) -> Void) -> ZTEventHandler {
        let handler = ZTEventHandler(control: self, event: event, action: action)
        recordEventHandler(handler)
        return handler
    }
    
    @discardableResult
    func onClick(_ action: @escaping (UIControl, UIControl.Event, ZTEventHandler) -> Void) -> ZTEventHandler {
        onEvent(.touchUpInside, action)
    }
    
    @discardableResult
    func onValueChanged(_ action: @escaping (UIControl, UIControl.Event, ZTEventHandler) -> Void) -> ZTEventHandler {
        onEvent(.valueChanged, action)
    }
    
    @discardableResult
    func onEditingChanged(_ action: @escaping (UIControl, UIControl.Event, ZTEventHandler) -> Void) -> ZTEventHandler {
        onEvent(.editingChanged, action)
    }
    
    private func recordEventHandler(_ handler: ZTEventHandler) {
        if eventHandlers == nil {
            eventHandlers = []
        } else {
            eventHandlers?.removeAll(where: { !$0.isValid })
        }
        eventHandlers?.append(handler)
    }
    
    var eventHandlers: [ZTEventHandler]? {
        get {
            objc_getAssociatedObject(self, &Self.zt_eventHandlersKey) as? [ZTEventHandler]
        }
        set {
            objc_setAssociatedObject(self, &Self.zt_eventHandlersKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

@MainActor
public extension ZTWrapper where Subject : UIControl {
    @discardableResult
    func onEvent(_ event: UIControl.Event, _ action: @escaping (UIControl, UIControl.Event, UIControl.ZTEventHandler) -> Void) -> Self {
        subject.onEvent(event, action)
        return self
    }
    
    @discardableResult
    func onClick(_ action: @escaping (UIControl, UIControl.ZTEventHandler) -> Void) -> Self {
        subject.onClick{ sender, event, handler in
            action(sender, handler)
        }
        return self
    }
    
    @discardableResult
    func onValueChanged(_ action: @escaping (UIControl, UIControl.ZTEventHandler) -> Void) -> Self {
        subject.onValueChanged { sender, event, handler in
            action(sender, handler)
        }
        return self
    }
    
    @discardableResult
    func onEditingChanged(_ action: @escaping (UIControl, UIControl.ZTEventHandler) -> Void) -> Self {
        subject.onEditingChanged { sender, event, handler in
            action(sender, handler)
        }
        return self
    }
}
