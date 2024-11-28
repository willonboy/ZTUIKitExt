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
public extension UILabel {
    convenience init(_ title:String, sysFont:CGFloat? = nil, font:UIFont? = nil, color:UIColor? = nil) {
        self.init()
        text = title
        numberOfLines = 0
        sizeToFit()
        textAlignment = .natural
        if font != nil {
            self.font = font
        } else if sysFont != nil {
            self.font = UIFont.systemFont(ofSize: sysFont!)
        } else {
            self.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        }
        if color != nil {
            textColor = color!
        } else {
            textColor = UIColor.label
        }
    }
}


