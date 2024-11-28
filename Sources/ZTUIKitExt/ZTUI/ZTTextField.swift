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

public class ZTTextField: UITextField {
    public var onShouldBeginEditingBlock: (() -> Bool)?
    public var onDidBeginEditingBlock: (() -> Void)?
    public var onShouldEndEditingBlock: (() -> Bool)?
    public var onDidEndEditingBlock: (() -> Void)?
    public var onShouldChangeCharactersBlock: ((NSRange, String) -> Bool)?
    public var onShouldClearBlock: (() -> Bool)?
    public var onShouldReturnBlock: (() -> Bool)?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZTTextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        onShouldBeginEditingBlock?() ?? true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        onDidBeginEditingBlock?()
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        onShouldEndEditingBlock?() ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        onDidEndEditingBlock?()
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        onShouldChangeCharactersBlock?(range, string) ?? true
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        onShouldClearBlock?() ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onShouldReturnBlock?() ?? true
    }
}
