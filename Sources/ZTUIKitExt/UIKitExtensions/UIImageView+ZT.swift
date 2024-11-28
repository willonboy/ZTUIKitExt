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
public extension UIImageView {
    convenience init(name:String, bundle:Bundle? = nil, conf:UIImage.Configuration? = nil) {
        self.init()
        if bundle != nil {
            image = UIImage(named: name, in: bundle, with: conf)
        } else {
            image = UIImage(named: name)
        }
    }
    
    convenience init(file:String) {
        self.init()
        image = UIImage(contentsOfFile: file)
    }
    
    convenience init(systemName:String) {
        self.init()
        image = UIImage(systemName: systemName)
    }
    
    convenience init(data:Data) {
        self.init()
        image = UIImage(data: data)
    }
}
