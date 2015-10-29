//
//  Cycle3ViewController.swift
//  StrongCycleDemo
//
//  Created by Lubos Ilcik on 24/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class Cycle3ViewController: TestViewController {

    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Cycle 3"
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: "update", userInfo: nil, repeats: true)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Cycle3ViewController init \(instanceNumber)")
    }
    
    deinit {
        print("Cycle3ViewController deinit \(instanceNumber)")
    }
    
    func handleWillResignActiveNotification() {
        print("Cycle3ViewController handleWillResignActiveNotification \(instanceNumber)")
    }

    func update() {
        print("Cycle3ViewController update \(instanceNumber)")
    }
  }
