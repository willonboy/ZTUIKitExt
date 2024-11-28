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

public extension ZTWrapper where Subject : UIView {
    @discardableResult
    func animation(_ a: UIView.ZTAnimation<Subject>...) -> Self {
        a.forEach {
            $0.apply(to: subject)
        }
        return self
    }
    
    @discardableResult
    func lazyAnimation(_ a: UIView.ZTAnimation<Subject>...) -> Self {
        DispatchQueue.main.async {
            a.forEach {
                $0.apply(to: subject)
            }
        }
        return self
    }
}

public extension UIView {
    typealias ZTAnimationClosure<T:UIView> = (_ v:T) -> Void
    enum ZTAnimation<Subject: UIView> {
        case custom(ZTAnimationClosure<Subject>)

        func apply(to subject: Subject) {
            switch self {
            case .custom(let closure):
                closure(subject)
            }
        }
    }
    
    static let fadeIn = fadeIn(1)
    static func fadeIn(_ d:TimeInterval = 1, completion: ((Bool) -> Void)? = nil) -> ZTAnimation<UIView> {
        .custom { v in
            v.alpha = 0
            UIView.animate(withDuration: d, delay: 0, options: [.curveEaseIn]) {
                v.alpha = 1
            } completion: { r in
                completion?(r)
            }
        }
    }
    
    static let fadeOut = fadeOut(1)
    static func fadeOut(_ d:TimeInterval = 1, completion: ((Bool) -> Void)? = nil) -> ZTAnimation<UIView> {
        .custom { v in
            v.alpha = 1
            UIView.animate(withDuration: d, delay: 0, options: [.curveEaseOut]) {
                v.alpha = 0
            } completion: { r in
                completion?(r)
            }
        }
    }
}

public extension ZTWrapper {
    @discardableResult
    func delay(_ t:TimeInterval = 1, _ code:@escaping () -> Void) -> Self {
        DispatchQueue.main.asyncAfter(deadline: .now() + t) {
            code()
        }
        return self
    }
    
    @discardableResult
    func mainQueue(_ code:@escaping () -> Void) -> Self {
        if Thread.isMainThread {
            code()
        } else {
            DispatchQueue.main.async {
                code()
            }
        }
        return self
    }
    
    @discardableResult
    func tick(interval:TimeInterval = 1, queue:DispatchQueue = .main, _ code:@escaping (_ timer:any DispatchSourceTimer) -> Void) -> Self {
        let timer = DispatchSource.makeTimerSource(queue: queue)
        timer.schedule(deadline: .now(), repeating: interval)
        timer.setEventHandler {
            code(timer)
        }
        timer.resume()
        return self
    }
}
