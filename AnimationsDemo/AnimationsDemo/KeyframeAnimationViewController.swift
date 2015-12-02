//
//  KeyframeAnimationViewController.swift
//  AnimationsDemo
//
//  Created by Lubos Ilcik on 30/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class KeyframeAnimationViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func dismiss(sender: AnyObject) {
        
        let bounds = containerView.bounds
        let smallFrame = CGRectInset(containerView.frame, containerView.frame.size.width / 4, containerView.frame.size.height / 4)
        let finalFrame = CGRectOffset(smallFrame, 0, bounds.size.height)

        let snapshot = containerView.snapshotViewAfterScreenUpdates(false)
        snapshot.frame = containerView.frame
        view.addSubview(snapshot)
        containerView.removeFromSuperview()
        
        UIView.animateKeyframesWithDuration(0.8, delay: 0, options: .CalculationModeCubic, animations: {
        
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.2) {
                snapshot.frame = smallFrame
            }
            
            UIView.addKeyframeWithRelativeStartTime(0.2, relativeDuration: 0.8) {
                snapshot.frame = finalFrame
            }
            
        }, completion: nil)

    }
    
}
