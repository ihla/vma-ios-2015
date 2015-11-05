//
//  SecondViewController.swift
//  SegueDemo
//
//  Created by Lubos Ilcik on 02/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logout(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(false, forKey: signedInKey)
        defaults.synchronize()
        if let presentingViewController = presentingViewController {
            presentingViewController.dismissViewControllerAnimated(true, completion: nil)
        } else {
            let loginVC = storyboard?.instantiateViewControllerWithIdentifier("LoginVC")
            presentViewController(loginVC!, animated: true, completion: nil)
        }
    }
}

















