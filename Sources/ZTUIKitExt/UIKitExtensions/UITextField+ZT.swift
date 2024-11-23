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

@MainActor
public extension UITextField {
    convenience init(_ placeholder:String) {
        self.init()
        self.placeholder = placeholder
        font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        textColor = UIColor.label
    }
}
