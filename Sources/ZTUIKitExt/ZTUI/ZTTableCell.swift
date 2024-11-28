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

public class ZTTableCell: UITableViewCell {
    public var onReuse:((ZTTableCell) -> Void)?
    private var v:UIView?
    
    init(_ identifier:String? = nil, _ v:(_ contentView: UIView) -> Void) {
        super.init(style: .default, reuseIdentifier: identifier)
        selectionStyle = .none
        v(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        onReuse?(self)
    }
}
