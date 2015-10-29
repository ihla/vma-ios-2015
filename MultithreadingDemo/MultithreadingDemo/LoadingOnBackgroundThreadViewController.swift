//
//  LoadingOnBackgroundThreadViewController.swift
//  MultithreadingDemo
//
//  Created by Lubos Ilcik on 25/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class LoadingOnBackgroundThreadViewController: UIViewController {

    static var instanceCount = 0
    var instanceNum = 0
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let qos = Int(QOS_CLASS_USER_INTERACTIVE.rawValue)
        // alternative QoS defines
        // DISPATCH_QUEUE_PRIORITY_HIGH
        // DISPATCH_QUEUE_PRIORITY_DEFAULT
        // DISPATCH_QUEUE_PRIORITY_LOW
        // DISPATCH_QUEUE_PRIORITY_BACKGROUND
        dispatch_async(dispatch_get_global_queue(qos, 0)) {
            print("loading image...")
            if let imageURL = NSURL(string: imageURLString) {
                if let imageData = NSData(contentsOfURL: imageURL) {
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        self.image.image = UIImage(data: imageData)
                        print("image loaded")
                    }
                    
                } else {
                    print("failed to load image - data nil")
                }
            } else {
                print("failed to load image - url nil")
            }
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear \(instanceNum)")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewDidDisappear \(instanceNum)")
    }
    
    required init?(coder aDecoder: NSCoder) {
        instanceNum = ++LoadingOnBackgroundThreadViewController.instanceCount
        super.init(coder: aDecoder)
        print("init \(instanceNum)")
    }
    
    deinit {
        print("deinit \(instanceNum)")
    }

}
