//
//  NSArrayTest.m
//  DebuggerDemo
//
//  Created by Lubos Ilcik on 06/12/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

#import "NSArrayTest.h"

NSString* findStringElement(NSArray* array, NSString* matches) {
    for (int i=0; i <= array.count; i++) {
        if (array[i] == matches) {
            return array[i];
        }
    }
    return nil;
}

