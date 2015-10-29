//
//  Cycle1ViewController.swift
//  StrongCycleDemo
//
//  Created by Lubos Ilcik on 24/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class Cycle1ViewController: TestViewController {

    var closure: ()->() = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()

        closure = {
            self.sayHello()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        log.debug("\(instanceNumber)")
    }
    deinit {
        log.debug("\(instanceNumber)")
    }

    func sayHello() {
        log.debug("")
    }
}
