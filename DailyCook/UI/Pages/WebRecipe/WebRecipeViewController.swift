//
//  WebRecipeViewController.swift
//  DailyCook
//
//  Created by admin on 2020/08/27.
//  Copyright © 2020 admin. All rights reserved.
//

import WebKit
import UIKit

class WebRecipeViewController: UIViewController, ViewConstructor {
    let webView = WKWebView()
    let url = URL(string: "https://mariegohan.com/2669")
    
    private var progressView = UIProgressView(progressViewStyle: .bar)
    private var activityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        setupViews()
        setupViewConstraints()
    }
    
    func setupViews() {
        view.addSubview(webView)
        if let url = url {
            let myRequest = URLRequest(url: url)
            webView.load(myRequest)
        }
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
    }
    
    func setupViewConstraints() {
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func startIndicator() {
        activityIndicatorView.startAnimating()
    }

    private func stopIndicator() {
        activityIndicatorView.stopAnimating()
    }
}

extension WebRecipeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        startIndicator()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopIndicator()
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stopIndicator()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        stopIndicator()
    }
}
