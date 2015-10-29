//
//  LoadingOnMainThreadViewController.swift
//  MultithreadingDemo
//
//  Created by Lubos Ilcik on 25/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class LoadingOnMainThreadViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        log.debug("loading image...")
        if let imageURL = NSURL(string: imageURLString) {
            if let imageData = NSData(contentsOfURL: imageURL) {
                image.image = UIImage(data: imageData)
                log.debug("image loaded")
            } else {
                log.debug("failed to load image - data nil")
            }
        } else {
            log.debug("failed to load image - url nil")
        }
    }

}
