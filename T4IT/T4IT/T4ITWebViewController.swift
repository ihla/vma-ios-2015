//
//  T4ITWebViewController.swift
//  T4IT
//
//  Created by Lubos Ilcik on 14/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class T4ITWebViewController: WKWebViewController {

    let url = NSURL(string: "http://www.touch4it.com/")

    override func viewDidLoad() {
        super.viewDidLoad()

        let urlRequest = NSURLRequest(URL: url!)
        webView.loadRequest(urlRequest)

    }

}
