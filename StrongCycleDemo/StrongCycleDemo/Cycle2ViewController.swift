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
        log.debug("\(instanceNumber)")
    }
    
    deinit {
        log.debug("\(instanceNumber)")
        NSNotificationCenter.defaultCenter().removeObserver(observer)
    }

    func handleWillResignActiveNotification() {
        log.debug("\(instanceNumber)")
    }
    
    func handleNotification(notification: NSNotification) {
        log.debug(notification.description)
    }
}
