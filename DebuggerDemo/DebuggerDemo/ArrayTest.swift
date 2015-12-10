//
//  ArrayTest.swift
//  DebuggerDemo
//
//  Created by Lubos Ilcik on 06/12/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import Foundation

func findElement<T>(array: [T], match: (T) -> Bool) -> T? {
    for index in 0...array.count {
        if match(array[index]) {
            return array[index]
        }
    }
    return nil
}