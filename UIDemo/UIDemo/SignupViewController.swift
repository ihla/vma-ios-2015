//
//  SignupViewController.swift
//  UIDemo
//
//  Created by Lubos Ilcik on 15/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTExtField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signup(sender: UIButton) {
        print("signup")
        let email = emailTExtField.text
        let password = passwordField.text
        print("\(email) : \(password)")
    }

    @IBAction func dismissKeyboard(sender: UITapGestureRecognizer) {
        print("dismissKeyboard")
        view.endEditing(true)
    }
    
    @IBAction func unwind(sender: UIStoryboardSegue) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("return")
        return true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
