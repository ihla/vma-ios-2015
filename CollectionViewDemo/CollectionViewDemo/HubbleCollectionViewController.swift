//
//  HubbleCollectionViewController.swift
//  CollectionViewDemo
//
//  Created by Lubos Ilcik on 01/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class HubbleCollectionViewController: UICollectionViewController {

    private let reuseIdentifier = "ImageCell"
    private let imageGallery = HubbleGallery()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageGallery.images.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! HubbleCollectionViewCell
    
        // Configure the cell
        cell.backgroundColor = UIColor.blackColor()
        cell.imageView.image = imageGallery.images[indexPath.row]
    
        return cell
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showImage" {
            let imageVC = segue.destinationViewController as? HubbleImageViewController
            let cell = sender as! UICollectionViewCell
            if let indexPath = collectionView?.indexPathForCell(cell) {
                imageVC?.image = imageGallery.images[indexPath.row]
            }
        }
    }
    
}

extension HubbleCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if let image = imageGallery.images[indexPath.row] {
            let aspectRatio = image.size.height / image.size.width
            return CGSize(width: 200, height: 200 * aspectRatio)
        }
        return CGSize(width: 200, height: 200)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
}













