//
//  HubbleImageViewController.swift
//  CollectionViewDemo
//
//  Created by Lubos Ilcik on 01/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class HubbleImageViewController: UIViewController {

    var image: UIImage?
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = image
        }
    }

}
