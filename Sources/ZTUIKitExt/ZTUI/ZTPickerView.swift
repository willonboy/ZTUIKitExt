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

public class ZTPickerView: UIPickerView {

    // DataSource blocks
    public var numberOfComponentsBlock: (() -> Int)?
    public var numberOfRowsInComponentBlock: ((Int) -> Int)?
    
    // Delegate blocks
    public var titleForRowBlock: ((Int, Int) -> String?)?
    public var attributedTitleForRowBlock: ((Int, Int) -> NSAttributedString?)?
    public var viewForRowBlock: ((Int, Int, UIView?) -> UIView?)?
    public var widthForComponentBlock: ((Int) -> CGFloat)?
    public var rowHeightForComponentBlock: ((Int) -> CGFloat)?
    public var didSelectRowBlock: ((Int, Int) -> Void)?
    
    override public init(frame: CGRect = .zero) {
        super.init(frame: frame)
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZTPickerView: UIPickerViewDataSource {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        numberOfComponentsBlock?() ?? 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        numberOfRowsInComponentBlock?(component) ?? 0
    }
}

extension ZTPickerView: UIPickerViewDelegate {
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        titleForRowBlock?(row, component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        attributedTitleForRowBlock?(row, component)
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let customView = viewForRowBlock?(row, component, view) {
            return customView
        }
        if let reusedView = view as? UILabel {
            reusedView.text = titleForRowBlock?(row, component) ?? "Default"
            reusedView.textAlignment = .center
            reusedView.backgroundColor = .clear
            return reusedView
        }
        let label = UILabel()
        label.text = titleForRowBlock?(row, component) ?? ""
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.font = .systemFont(ofSize: 16)
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        widthForComponentBlock?(component) ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        rowHeightForComponentBlock?(component) ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        didSelectRowBlock?(row, component)
    }
}
