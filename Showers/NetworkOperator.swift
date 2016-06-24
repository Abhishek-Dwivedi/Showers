//
//  NetworkOperator.swift
//  Showers
//
//  Created by Abhishek Dwivedi on 15/05/16.
//  Copyright © 2016 Abhishek Dwivedi. All rights reserved.
//

/*
NetworkOperator responsible for network operations.
The sole purpose of this class is to get a URL and download json from the URL and return the NSData.
*/

import Foundation

class NetworkOperator {
    
    lazy var configuration: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    lazy var session: NSURLSession = NSURLSession(configuration:self.configuration)
    var URL: NSURL
    
    typealias CompletionType = ([String: AnyObject]?) -> Void
    
    init(url: NSURL) {
        self.URL = url
    }
    /*
    Downloads json from the URL;
    convert it to NSData and
    returns the dictionary
    */
    func downloadDataFromURL(completion: CompletionType) {
        
        let request = NSURLRequest(URL: self.URL)
        
        let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            do{
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! [String:AnyObject]
                 completion(jsonDict)
            }
            catch {
                print("json error: \(error)")
            }
        });
        task.resume()
    }
}