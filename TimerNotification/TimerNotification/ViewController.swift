//
//  ViewController.swift
//  TimerNotification
//
//  Created by Lubos Ilcik on 30/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var picker: UIPickerView!
    
    var interval = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        interval = row
    }
    
    @IBAction func start(sender: AnyObject) {
        if interval > 0 {
            print("starting notification with \(interval) sec")
            
            let notification:UILocalNotification = UILocalNotification()
            notification.fireDate = NSDate(timeIntervalSinceNow: NSTimeInterval(interval))
            notification.alertTitle = "Test notification"
            notification.alertBody = "a new notification"
            notification.applicationIconBadgeNumber = UIApplication.sharedApplication().applicationIconBadgeNumber + 1
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.userInfo = ["payload": "test payload"]
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
}

