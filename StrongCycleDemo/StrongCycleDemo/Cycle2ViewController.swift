//
//  Cycle2ViewController.swift
//  StrongCycleDemo
//
//  Created by Lubos Ilcik on 24/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class Cycle2ViewController: TestViewController {

    var observer: NSObjectProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cycle 2"

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        observer = NSNotificationCenter.defaultCenter().addObserverForName(UIApplicationWillResignActiveNotification, object: nil, queue: NSOperationQueue.mainQueue()) { notification in
            self.handleNotification(notification)
        }
        print("Cycle2ViewController init \(instanceNumber)")
    }
    
    deinit {
        print("Cycle2ViewController deinit \(instanceNumber)")
        NSNotificationCenter.defaultCenter().removeObserver(observer)
    }

    func handleWillResignActiveNotification() {
        print("Cycle2ViewController handleWillResignActiveNotification \(instanceNumber)")
    }
    
    func handleNotification(notification: NSNotification) {
        print(notification.description)
    }
}
