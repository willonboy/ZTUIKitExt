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

@MainActor
public extension UIButton {
    private static var zt_onClickClosureKey: UInt8 = 0
    convenience init(_ title:String, _ onClick:((UIButton)->Void)? = nil) {
        self.init(title, onClick:onClick)
    }
    
    convenience init(named:String, _ onClick:((UIButton)->Void)? = nil) {
        self.init(img:UIImage(named: named), onClick:onClick)
    }
    
    convenience init(systemName:String, _ onClick:((UIButton)->Void)? = nil) {
        self.init(img:UIImage(systemName: systemName), onClick:onClick)
    }
    
    convenience init(imgFile:String, _ onClick:((UIButton)->Void)? = nil) {
        self.init(img:UIImage(contentsOfFile: imgFile), onClick:onClick)
    }
    
    convenience init(img:UIImage, _ onClick:((UIButton)->Void)? = nil) {
        self.init(img:img, onClick:onClick)
    }
    
    convenience init(_ title:String? = nil, img:UIImage? = nil, bgImg:UIImage? = nil, onClick:((UIButton)->Void)? = nil) {
        self.init(type:.custom)
        self.onClick = onClick
        addTarget(self, action: #selector(onClickHandle), for: .touchUpInside)
        
        setTitle(title, for: .normal)
        setImage(img, for: .normal)
        setBackgroundImage(bgImg, for: .normal)
        
        backgroundColor = .clear
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.systemFont(ofSize: UIFont.labelFontSize)
        setTitleColor(UIColor.label, for: .normal)
    }
    
    var onClick: ((UIButton)->Void)? {
        get {
            return objc_getAssociatedObject(self, &Self.zt_onClickClosureKey) as? ((UIButton)->Void)
        }
        set {
            objc_setAssociatedObject(self, &Self.zt_onClickClosureKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc private func onClickHandle() {
        onClick?(self)
    }
}

@MainActor
public extension ZTWrapper where Subject : UIButton {
    func title(_ title:String?, state: UIControl.State = .normal) -> Self {
        subject.setTitle(title, for: state)
        return self
    }
    
    func attributedTitle(_ title:NSAttributedString?, state: UIControl.State = .normal) -> Self {
        subject.setAttributedTitle(title, for: state)
        return self
    }
    
    func titleColor(_ color:UIColor?, state: UIControl.State = .normal) -> Self {
        subject.setTitleColor(color, for: state)
        return self
    }
    
    func img(_ img:UIImage?, state: UIControl.State = .normal) -> Self {
        subject.setImage(img, for: state)
        return self
    }
    
    func bgImg(_ img:UIImage?, state: UIControl.State = .normal) -> Self {
        subject.setBackgroundImage(img, for: state)
        return self
    }
    
    func img(_ named:String, state: UIControl.State = .normal) -> Self {
        subject.setImage(UIImage(named: named), for: state)
        return self
    }
    
    func bgImg(_ named:String, state: UIControl.State = .normal) -> Self {
        subject.setBackgroundImage(UIImage(named: named), for: state)
        return self
    }
    
    func font(_ f:UIFont) -> Self {
        subject.titleLabel?.font = f
        return self
    }
}

public extension ZTWrapper where Subject : UIButton {
    @MainActor
    func onClick(_ action:@escaping (UIButton)->Void) -> Self {
        subject.onClick = action
        return self
    }
}
