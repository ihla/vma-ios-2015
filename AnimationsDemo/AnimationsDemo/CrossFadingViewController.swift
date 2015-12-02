//
//  CrossFadingViewController.swift
//  AnimationsDemo
//
//  Created by Lubos Ilcik on 29/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class CrossFadingViewController: UIViewController {
    
    let imageNames = [
        "hubble1.png",
        "hubble2.jpg",
        "hubble3.jpg",
        "hubble4.jpg",
        "hubble5.jpg",
        "hubble6.jpg",
        "hubble7.jpg",
        "hubble8.jpg",
        "hubble9.jpg",
        "hubble10.jpg",
    ]
    var imageIdx = 0

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: imageNames[imageIdx])
    }


    @IBAction func nextImage(sender: AnyObject) {
        imageIdx = imageIdx < imageNames.count-1 ? ++imageIdx : 0
        let nextImageView = UIImageView()
        nextImageView.frame = view.frame
        nextImageView.image = UIImage(named: imageNames[imageIdx])
        nextImageView.contentMode = .ScaleAspectFill
        nextImageView.alpha = 0
        view.insertSubview(nextImageView, aboveSubview: imageView)

        UIView.animateWithDuration(1, animations: {
            nextImageView.alpha = 1
            self.imageView.alpha = 0
            }, completion: { _ in
                self.imageView.image = nextImageView.image
                self.imageView.alpha = 1
                nextImageView.removeFromSuperview()
        })
    }
    
}
