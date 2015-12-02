//
//  StackViewAnimationViewController.swift
//  AnimationsDemo
//
//  Created by Lubos Ilcik on 30/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class StackViewAnimationViewController: UIViewController {
    @IBOutlet weak var detailsButton: UIButton!
    @IBOutlet weak var detail: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func hideDetail(sender: AnyObject) {
        if detail.hidden {
            animateView(detail, toHidden: false)
            detailsButton.setTitle("Hide Details", forState: .Normal)
        } else {
            animateView(detail, toHidden: true)
            detailsButton.setTitle("Show Details", forState: .Normal)
        }
    }
    
    private func animateView(view: UIView, toHidden hidden: Bool) {
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            view.hidden = hidden
            }, completion: nil)
    }
}
