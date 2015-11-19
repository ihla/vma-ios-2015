//
//  VmaKeyNoteViewController.swift
//  T4IT
//
//  Created by Lubos Ilcik on 14/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class VmaKeyNoteViewController: WKWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // displaying iWork document
        let documentPath = NSBundle.mainBundle().URLForResource("vma-ios-2015-c1", withExtension: "key")
//        let urlRequest = NSURLRequest(URL: documentPath!)
//        webView.loadRequest(urlRequest)
        webView.loadFileURL(documentPath!, allowingReadAccessToURL: documentPath!)
    }

}
