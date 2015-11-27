//
//  ViewController.swift
//  ImagePickerDemo
//
//  Created by Lubos Ilcik on 25/03/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePreview: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    @IBAction func choosePhotoFromLibrary(sender: UIBarButtonItem) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
//        presentViewController(imagePicker, animated: true, completion: nil)
        
        // lepší spôsob je prezentovať picker v popover:
        imagePicker.modalPresentationStyle = .Popover
        imagePicker.popoverPresentationController?.barButtonItem = sender
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }

    @IBAction func shootPhotoByCamera(sender: UIBarButtonItem) {
        
        // lepšie je overiť či hw má kameru
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .Camera
            imagePicker.cameraCaptureMode = .Photo
            
            presentViewController(imagePicker, animated: true, completion: nil)
            
        } else {
            
            showAlert()
            
        }
        
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Chyba", message: "Vaše zariadenie nemá kameru.", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        // urobí biely status bar
        // treba však do Info.plist pridať View controller-based status bar appearance -> YES
        return .LightContent
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imagePreview.image = chosenImage
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

