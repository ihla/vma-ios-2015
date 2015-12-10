//
//  ViewController.swift
//  DebuggerDemo
//
//  Created by Lubos Ilcik on 05/12/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labell: UILabel!
    
    @IBAction func actionn(sender: AnyObject) {
    }
    
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //bug #1
//        let match = findElement(["java", "swift", "cpp"], match: { $0 == "" })
        
        //bug #2
//        var num: Int?
//        dispatch_onto_queue(dispatch_get_global_queue(Int(QOS_CLASS_BACKGROUND.rawValue), 0), a: num)
        
        //bug #3
//        let match = findStringElement(["java", "swift", "cpp"], "")
        
        //bug #4
//        readPage()

//        count = 99
//        let objects = "red balloons"
//        print("\(count) \(objects)")

    }

}

