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

public extension UIFont {
    convenience init(_ size:Int) {
        self.init()
        
    }
    
    @discardableResult
    static func callAsFunction(_ size: CGFloat) -> UIFont {
        systemFont(ofSize: size)
    }
}
