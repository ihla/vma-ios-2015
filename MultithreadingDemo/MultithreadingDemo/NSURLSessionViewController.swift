//
//  NSURLSessionViewController.swift
//  MultithreadingDemo
//
//  Created by Lubos Ilcik on 25/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class NSURLSessionViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")

        if let url = NSURL(string: imageURLString) {
            print("loading image...")
            NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: { (data, response, error) in
                guard let data = data where error == nil else {
                    print("error loading data")
                    return
                }
                print("image loaded")
                dispatch_async(dispatch_get_main_queue()) {
                    self.image.image = UIImage(data: data)
                }
            }).resume()
        }
    }

    deinit {
        print("deinit")
    }
}
