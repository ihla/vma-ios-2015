//
//  ConstraintsAnimationViewController.swift
//  AnimationsDemo
//
//  Created by Lubos Ilcik on 29/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class ConstraintsAnimationViewController: UIViewController {

    @IBOutlet weak var messageBackground: UIImageView!
    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var welcomeCenterX: NSLayoutConstraint!
    @IBOutlet weak var signUpCenterX: NSLayoutConstraint!
    @IBOutlet weak var messageBackgroundCenterX: NSLayoutConstraint!
    
    let messageLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 4
        signUpButton.layer.masksToBounds = true
        
        messageLabel.frame = CGRect(x: 0, y: 0, width: messageBackground.frame.size.width, height: messageBackground.frame.size.height)
        messageLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        messageLabel.textColor = UIColor(red: 228.0/255.0, green: 98.0/255.0, blue: 0.0, alpha: 1.0)
        messageLabel.textAlignment = .Center
        messageBackground.addSubview(messageLabel)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        welcomeCenterX.constant -= view.bounds.width
        signUpCenterX.constant -= view.bounds.width
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: {
            self.welcomeCenterX.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
            }, completion: nil)
        
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: [], animations: {
            self.signUpCenterX.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
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
                            self.messageBackgroundCenterX.constant += self.view.bounds.width
                            self.view.layoutIfNeeded()
                            }) { _ in
                                self.messageBackgroundCenterX.constant -= self.view.bounds.width
                                self.messageBackground.hidden = true
                                self.messageLabel.text = "Signed OK!"
                                
                                UIView.transitionWithView(self.messageBackground, duration: 0.33, options: [.CurveEaseOut, .TransitionCurlDown], animations: {
                                    self.messageBackground.hidden = false
                                    }) { _ in
                                        UIView.animateWithDuration(0.33, delay: 0.5, options: .CurveEaseOut, animations: {
                                            self.messageBackgroundCenterX.constant += self.view.bounds.width
                                            self.view.layoutIfNeeded()
                                            }) { _ in
                                                self.messageBackgroundCenterX.constant -= self.view.bounds.width
                                                self.messageBackground.hidden = true
                                                self.messageLabel.text = nil
                                        }
                                        
                                }
                        }
                }
        }
    }
}
