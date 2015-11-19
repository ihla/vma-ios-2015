//
//  WKWebViewController.swift
//  T4IT
//
//  Created by Lubos Ilcik on 14/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit
import WebKit

class WKWebViewController: UIViewController {

    var webView: WKWebView!

    override func loadView() {
        super.loadView()
        
        webView = WKWebView(frame: CGRectZero)
        view.addSubview(webView)
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: webView, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: webView, attribute: .Bottom, relatedBy: .Equal, toItem: bottomLayoutGuide, attribute: .Top, multiplier: 1, constant: 0)
        let leading = NSLayoutConstraint(item: webView, attribute: .Leading, relatedBy: .Equal, toItem: view, attribute: .Leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: webView, attribute: .Trailing, relatedBy: .Equal, toItem: view, attribute: .Trailing, multiplier: 1, constant: 0)
        view.addConstraints([top, bottom, leading, trailing])
        
        // poznámka: riešenie vyššie demonštruje pridanie subview a nastavanie auto-layout constraints programovo
        // jednoduchšie a postačujúce riešenie pre WKWebView je
        //webView = WKWebView()
        //view = webView
    }

}
