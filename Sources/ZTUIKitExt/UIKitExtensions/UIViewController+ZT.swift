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
import ZTGenericBuilder

public protocol ZTAlertItemProtocol {}

extension UIAlertAction : ZTAlertItemProtocol {}
public typealias ZTAlertItemBuilder = ZTGenericBuilder<any ZTAlertItemProtocol>


public extension UIViewController {
    func alert(title:String = "", msg:String = "", animated:Bool = true, completion: (() -> Void)? = nil, @ZTAlertItemBuilder actions:() -> [any ZTAlertItemProtocol]) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let items = actions()
        items.forEach {
            if let a = $0 as? UIAlertAction {
                alert.addAction(a)
            }
        }
        present(alert, animated: animated, completion: completion)
    }
    
    func showSheet(title:String = "", msg:String = "", animated:Bool = true, completion: (() -> Void)? = nil, @ZTAlertItemBuilder actions:() -> [any ZTAlertItemProtocol]) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        let items = actions()
        items.forEach {
            if let a = $0 as? UIAlertAction {
                alert.addAction(a)
            }
        }
        present(alert, animated: animated, completion: completion)
    }
    
    func showToast(_ msg:String) {
        
    }
}
