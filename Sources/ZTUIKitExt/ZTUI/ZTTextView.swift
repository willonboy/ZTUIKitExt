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

public class ZTTextView: UITextView {
    public var onShouldBeginEditingBlock: (() -> Bool)?
    public var onDidBeginEditingBlock: (() -> Void)?
    public var onShouldEndEditingBlock: (() -> Bool)?
    public var onDidEndEditingBlock: (() -> Void)?
    public var onShouldChangeTextBlock: ((NSRange, String) -> Bool)?
    public var onDidChangeBlock: (() -> Void)?
    public var onDidChangeSelectionBlock: (() -> Void)?
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZTTextView: UITextViewDelegate {
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        onShouldBeginEditingBlock?() ?? true
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        onDidBeginEditingBlock?()
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        onShouldEndEditingBlock?() ?? true
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        onDidEndEditingBlock?()
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        onShouldChangeTextBlock?(range, text) ?? true
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        onDidChangeBlock?()
    }
    
    public func textViewDidChangeSelection(_ textView: UITextView) {
        onDidChangeSelectionBlock?()
    }
}
