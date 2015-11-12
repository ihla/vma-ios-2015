//
//  Course.swift
//  JsonDemo
//
//  Created by Lubos Ilcik on 07/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import Foundation

struct Course {
    let title: String
    let imageURLString: String
    init(title: String, url: String) {
        self.title = title
        self.imageURLString = url
    }
}