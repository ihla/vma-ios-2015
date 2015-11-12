//
//  ITLCoursesTableViewController.swift
//  JsonDemo
//
//  Created by Lubos Ilcik on 08/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit
import KFSwiftImageLoader

class ITLCoursesTableViewController: UITableViewController {
    
    let cellIdentifiaer = "TableCell"
    
    let itlCourses = ITLCourses()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "ITLCoursesTableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
        
        itlCourses.load() { [weak self] in
            if self?.itlCourses.courses != nil {
                print("courses laoded")
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itlCourses.courses != nil ? itlCourses.courses!.count : 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifiaer, forIndexPath: indexPath) as! ITLCoursesTableViewCell

        cell.courseTextLabel?.text = itlCourses.courses?[indexPath.item].title
        cell.courseImageView?.loadImageFromURLString(itlCourses.courses?[indexPath.item].imageURLString ?? "", placeholderImage: UIImage(named:"placeholder"))
        
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
