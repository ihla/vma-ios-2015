//
//  DispatchTest.swift
//  DebuggerDemo
//
//  Created by Lubos Ilcik on 06/12/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import Foundation

func dispatch_onto_queue(queue: dispatch_queue_t, a: Int?) {
    dispatch_async(queue) {
        print("Hello \(a!)")
    }
}
