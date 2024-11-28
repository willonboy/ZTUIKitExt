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


@preconcurrency import WebKit

public class ZTWebView: WKWebView {
    public var onDecidePolicyForNavigationActionBlock: ((WKNavigationAction) -> WKNavigationActionPolicy)?
    public var onDecidePolicyForNavigationResponseBlock: ((WKNavigationResponse) -> WKNavigationResponsePolicy)?
    public var onDidStartNavigationBlock: ((WKNavigation) -> Void)?
    public var onDidFinishNavigationBlock: ((WKNavigation) -> Void)?
    public var onDidFailNavigationBlock: ((WKNavigation, Error) -> Void)?
    public var onDidFailProvisionalNavigationBlock: ((WKNavigation, Error) -> Void)?
    public var onDidReceiveServerRedirectForProvisionalNavigationBlock: ((WKNavigation) -> Void)?
    public var onDidCommitNavigationBlock: ((WKNavigation) -> Void)?
    
    public override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        super.init(frame: frame, configuration: configuration)
        navigationDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ZTWebView: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let policy = onDecidePolicyForNavigationActionBlock?(navigationAction) {
            decisionHandler(policy)
        } else {
            decisionHandler(.allow)
        }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let policy = onDecidePolicyForNavigationResponseBlock?(navigationResponse) {
            decisionHandler(policy)
        } else {
            decisionHandler(.allow)
        }
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        onDidStartNavigationBlock?(navigation)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        onDidFinishNavigationBlock?(navigation)
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        onDidFailNavigationBlock?(navigation, error)
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        onDidFailProvisionalNavigationBlock?(navigation, error)
    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        onDidReceiveServerRedirectForProvisionalNavigationBlock?(navigation)
    }
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        onDidCommitNavigationBlock?(navigation)
    }
}
