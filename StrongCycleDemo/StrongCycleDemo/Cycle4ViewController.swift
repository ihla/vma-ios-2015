//
//  Cycle4ViewController.swift
//  StrongCycleDemo
//
//  Created by Lubos Ilcik on 24/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class Cycle4ViewController: TestViewController {

    lazy var passwordAlertController: UIAlertController = {
        let ctrl = UIAlertController(title: "Enter Password", message: "You have selected to enter your passwod.", preferredStyle: UIAlertControllerStyle.Alert)
        ctrl.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        ctrl.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            
            if let uwTextFields = self.passwordAlertController.textFields {
                let textField:UITextField = uwTextFields[0] as UITextField
                log.debug(textField.text)
            }
        }))
        ctrl.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Password"
            textField.secureTextEntry = true
        })
        return ctrl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Cycle 4"
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        presentViewController(passwordAlertController, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillAppear(animated)
        passwordAlertController.dismissViewControllerAnimated(false, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        log.debug("\(instanceNumber)")
    }
    
    deinit {
        log.debug("\(instanceNumber)")
    }

}
