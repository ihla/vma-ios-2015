//
//  OperationQueueViewController.swift
//  MultithreadingDemo
//
//  Created by Lubos Ilcik on 25/10/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class OperationQueueViewController: UIViewController {

    lazy var loadImageQueue: NSOperationQueue = {
        let queue = NSOperationQueue()
        queue.name = "Image Loading queue"
        // config queue
        queue.maxConcurrentOperationCount = 1 // serial queue
        return queue
    }()
    
    class ImageLoaderOperation: NSOperation {
        let imageURL: NSURL
        var image: UIImage?

        init(imageURL: NSURL) {
            self.imageURL = imageURL
            log.debug("operation")
        }
        
        override func main() {
            
            if self.cancelled {
                log.debug("operation cancelled")
                return
            }
            
            let imageData = NSData(contentsOfURL: imageURL)
            
            
            if self.cancelled {
                log.debug("operation cancelled")
                return
            }
            
            
            if imageData?.length > 0 {
                image = UIImage(data:imageData!)
            }
        }

        deinit {
            log.debug("operation")
        }
    }
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        log.debug("")

        // mem leaks 👻!!!
//        if let url = NSURL(string: self.imageURLString) {
//            let downloadImageOperation = ImageLoaderOperation(imageURL: url)
//            downloadImageOperation.completionBlock = {
//                log.debug("loading completed \(downloadImageOperation.image)")
//                dispatch_async(dispatch_get_main_queue()) {
//                    self.image.image = downloadImageOperation.image
//                    log.debug("image set: \(downloadImageOperation.image)")
//                }
//            }
//            log.debug("loading image...")
//            loadImageQueue.addOperation(downloadImageOperation)
//        }
        
        
        // mem leaks fixed 😎
        if let url = NSURL(string: imageURLString) {
            let downloadImageOperation = ImageLoaderOperation(imageURL: url)
            downloadImageOperation.completionBlock = { [weak self, weak downloadImageOperation] in
                log.debug("loading completed \(downloadImageOperation?.image)")
                dispatch_sync(dispatch_get_main_queue()) {
                    self?.image.image = downloadImageOperation?.image
                    log.debug("image set: \(downloadImageOperation?.image)")
                }
            }
            log.debug("loading image...")
            loadImageQueue.addOperation(downloadImageOperation)
        }
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        loadImageQueue.cancelAllOperations()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        log.debug("")
    }
    
    deinit {
        log.debug("")
    }
}
