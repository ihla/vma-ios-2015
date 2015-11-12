//
//  ViewController.swift
//  JsonDemo
//
//  Created by Lubos Ilcik on 07/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let itlCourses = ITLCourses()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itlCourses.load() { [weak self] in
            guard let courses = self?.itlCourses.courses else {
                print("courses nil")
                return
            }
            for course in courses {
                print("\(course.title)")
                print("\(course.imageURLString)")
                print("----")
            }
        }
    }

}

