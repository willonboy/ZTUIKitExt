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

typealias ZTViewBuilder = ZTGenericBuilder<UIView>

public class ZTVC : UIViewController {
    public var onDidLoad: ((ZTVC) -> Void)?
    public var onWillAppear: ((ZTVC) -> Void)?
    public var onFirstWillAppear: ((ZTVC) -> Void)?
    public var onIsAppearing:((ZTVC) -> Void)?
    public var onDidAppear: ((ZTVC) -> Void)?
    public var onFirstDidAppear: ((ZTVC) -> Void)?
    public var onWillDisappear: ((ZTVC) -> Void)?
    public var onFirstWillDisappear: ((ZTVC) -> Void)?
    public var onDidDisappear: ((ZTVC) -> Void)?
    public var onFirstDidDisappear: ((ZTVC) -> Void)?
    public var onTraitCollectionChanged: ((ZTVC, UITraitCollection?) -> Void)?
    public var onDeinit: ((ZTVC) -> Void)?
    
    private var contentView:UIView?
    private var markWillAppear = false
    private var markDidAppear = false
    private var markWillDisappear = false
    private var markDidDisappear = false
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(@ZTViewBuilder view:()-> UIView) {
        super.init(nibName: nil, bundle: nil)
        contentView = view()
    }
    
    deinit {
        onDeinit?(self)
    }
    
    public override func loadView() {
        super.loadView()
        if let v = contentView {
            view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                v.topAnchor.constraint(equalTo: view.topAnchor),
                v.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                v.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                v.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        onDidLoad?(self)
    }
    
    public override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        onIsAppearing?(self)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !markWillAppear {
            markWillAppear = true
            onFirstWillAppear?(self)
        }
        onWillAppear?(self)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !markDidAppear {
            markDidAppear = true
            onFirstDidAppear?(self)
        }
        onDidAppear?(self)
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !markWillDisappear {
            markWillDisappear = true
            onFirstDidDisappear?(self)
        }
        onWillDisappear?(self)
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if !markDidDisappear {
            markDidDisappear = true
            onFirstDidDisappear?(self)
        }
        onDidDisappear?(self)
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        onTraitCollectionChanged?(self, previousTraitCollection)
    }
}
