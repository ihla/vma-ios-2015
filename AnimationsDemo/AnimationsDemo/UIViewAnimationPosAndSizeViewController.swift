//
//  UIViewAnimationPosAndSizeViewController.swift
//  AnimationsDemo
//
//  Created by Lubos Ilcik on 29/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class UIViewAnimationPosAndSizeViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var messageBackground: UIImageView!
    let messageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Position & Size Anim"

        signUpButton.layer.cornerRadius = 4
        signUpButton.layer.masksToBounds = true
        signUpButton.hidden = false
        
        messageLabel.frame = CGRect(x: 0, y: 0, width: messageBackground.frame.size.width, height: messageBackground.frame.size.height)
        messageLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        messageLabel.textColor = UIColor(red: 228.0/255.0, green: 98.0/255.0, blue: 0.0, alpha: 1.0)
        messageLabel.textAlignment = .Center
        messageBackground.addSubview(messageLabel)

    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        welcomeLabel.center.x = view.bounds.width / 2
        welcomeLabel.center.x -= view.bounds.width
        
        signUpButton.center.x = view.bounds.width / 2
        signUpButton.center.x -= view.bounds.width
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        UIView.animateWithDuration(1.2) {
//            self.welcomeLabel.center.x += self.view.bounds.width
//        }
        
        // options: .CurveEaseInOut, .CurveEaseIn, .CurveEaseOut, .CurveEaseLinear
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: {
            self.welcomeLabel.center.x += self.view.bounds.width
            }, completion: nil)
        
//        UIView.animateWithDuration(0.5, delay: 0.2, options: .CurveEaseOut, animations: {
//            self.signUpButton.center.x += self.view.bounds.width
//            }, completion: nil)

        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: [], animations: {
            self.signUpButton.center.x += self.view.bounds.width
            }, completion: nil)

    }
    
    
    @IBAction func signUp(sender: AnyObject) {
        
        signUpButton.transform = CGAffineTransformMakeScale(0.7, 0.7)
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            self.signUpButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .CurveEaseOut, animations: {
            
            self.signUpButton.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            }) { _ in

                self.messageLabel.text = "Signing up..."
                UIView.transitionWithView(self.messageBackground, duration: 0.33, options: [.CurveEaseOut, .TransitionCurlDown], animations: {
                    
                    self.messageBackground.hidden = false
                    
                    }) { _ in
                        
                        UIView.animateWithDuration(0.33, delay: 1, options: .CurveEaseOut, animations: {
                            self.messageBackground.center.x += self.view.bounds.width
                            }) { _ in
                                self.messageBackground.center.x -= self.view.bounds.width
                                self.messageBackground.hidden = true
                                self.messageLabel.text = "Signed OK!"
                                UIView.transitionWithView(self.messageBackground, duration: 0.33, options: [.CurveEaseOut, .TransitionCurlDown], animations: {
                                    self.messageBackground.hidden = false
                                    }) { _ in
                                        UIView.animateWithDuration(0.33, delay: 1, options: .CurveEaseOut, animations: {
                                            self.messageBackground.center.x += self.view.bounds.width
                                            }) { _ in
                                                self.messageBackground.center.x -= self.view.bounds.width
                                                self.messageBackground.hidden = true
                                                self.messageLabel.text = nil
                                        }
                                }
                        }
                        
                }
                
        }
        
    }
    
}
