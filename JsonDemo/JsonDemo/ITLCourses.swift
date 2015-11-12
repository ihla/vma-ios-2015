//
//  ITLCourses.swift
//  JsonDemo
//
//  Created by Lubos Ilcik on 07/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import Foundation
import SwiftyJSON

class ITLCourses {
    
    static let dataFeedURLString = "http://www.itlearning.sk/edi/json.php"
    
    lazy var url = {
        NSURL(string: dataFeedURLString)
    }()
    
    var courses: [Course]?
    
    func load(completion: ()->()) {
        guard let url = url else {
            print("error making url")
            return
        }
        let dataTask = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            // you are not in main thread!!!!!!
            
            guard let data = data else {
                print("error getting data: \(error)")
                return
            }
            //self.courses = self.parseJsonData(data)
            self.courses = self.parseJsonDataEasy(data)
            print("received \(self.courses?.count) new courses")
            dispatch_async(dispatch_get_main_queue()) {
                completion()
            }
        }
        dataTask.resume()
    }
    
    // táto funkcia používa NSJSONSerialization API, čo vedie k vnoreným if-let {}
    private func parseJsonData(data: NSData) -> [Course]? {
        do {
            if let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? NSDictionary {
                if let records = jsonObject["records"] as? [NSDictionary] {
                    var courses = [Course]()
                    for record in records {
                        let title = record["title"] as? String ?? ""
                        let imageURLStr = record["url_image"] as? String ?? ""
                        courses.append(Course(title: title, url: imageURLStr))
                    }
                    return courses
                }
            }
        } catch let error {
            print("error parsing json data: \(error)")
        }
        return nil
    }

    // táto funkcia používa SwiftyJson lib (https://github.com/SwiftyJSON/SwiftyJSON), ktorá skrýva všetky tie if-let {}
    private func parseJsonDataEasy(data: NSData) -> [Course] {
        let jsonObject = JSON(data: data)
        let records = jsonObject["records"].arrayValue
        var courses = [Course]()
        for record in records {
            let title = record["title"].stringValue ?? ""
            let imageURLStr = record["url_image"].stringValue ?? ""
            courses.append(Course(title: title, url: imageURLStr))
        }
        return courses
    }
}
