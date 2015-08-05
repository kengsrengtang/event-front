//
//  RestUtil.swift
//  event-front
//
//  Created by kengsrengtang on 8/4/15.
//  Copyright (c) 2015 event. All rights reserved.
//

import Foundation
class RestUtil:NSObject{
    
    func post(url:String, payLoad: NSDictionary, success_cb: (NSDictionary) -> Void, error_cb(NSError)) -> Void{
        // MARK: POST
        // Create new post
        var postsUrlRequest = NSMutableURLRequest(URL: NSURL(string: url)!)
        postsUrlRequest.HTTPMethod = "POST"
        
        var postJSONError: NSError?
        var jsonPost = NSJSONSerialization.dataWithJSONObject(payLoad, options: nil, error:  &postJSONError)
        postsUrlRequest.HTTPBody = jsonPost
        
        NSURLConnection.sendAsynchronousRequest(postsUrlRequest, queue: NSOperationQueue(), completionHandler:{
            (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if let anError = error
            {
                // got an error in getting the data, need to handle it
                println("error calling POST on /posts")
                cb(null, null, error)
            }
            else
            {
                // parse the result as json, since that's what the API provides
                var jsonError: NSError?
                let post = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
                if let aJSONError = jsonError
                {
                    // got an error while parsing the data, need to handle it
                    println("error parsing response from POST on /posts")
                    
                    cb(null, null, error)
                }
                else
                {
                    // we should get the post back, so print it to make sure all the fields are as we set to and see the id
                    println("The post is: " + post.description)
                    
                    cb(response, null, error)
                }
            }
        })
        
    
    }
    
    func delete() -> Void{
        // MARK: DELETE
        // Delete first post
        var firstPostEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
        var firstPostUrlRequest = NSMutableURLRequest(URL: NSURL(string: firstPostEndpoint)!)
        firstPostUrlRequest.HTTPMethod = "DELETE"
        
        NSURLConnection.sendAsynchronousRequest(firstPostUrlRequest, queue: NSOperationQueue(), completionHandler:{
            (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if let anError = error
            {
                // got an error while deleting, need to handle it
                println("error calling DELETE on /posts/1")
                println(anError)
            }
        })

    }
    
    func get()->Void{
        // MARK: GET
        // Get first post
        var postEndpoint: String = "http://jsonplaceholder.typicode.com/posts/1"
        var urlRequest = NSURLRequest(URL: NSURL(string: postEndpoint)!)
        
        NSURLConnection.sendAsynchronousRequest(urlRequest, queue: NSOperationQueue(), completionHandler:{
            (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            if let anError = error
            {
                // got an error in getting the data, need to handle it
                println("error calling GET on /posts/1")
            }
            else
            {
                // parse the result as json, since that's what the API provides
                var jsonError: NSError?
                // WARNING: assuming the post is a dictionary is dangerous but saves a bunch of boilerplate (see bottom of blog post)
                let post = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary!
                if let aJSONError = jsonError
                {
                    // got an error while parsing the data, need to handle it
                    println("error parsing /posts/1")
                }
                else
                {
                    // now we have the results, let's just print them though a tableview would definitely be better UI:
                    println("The post is: " + post.description)
                    // to access a field:
                    if var postTitle = post["title"] as? String
                    {
                        println("The title is: " + postTitle)
                    }
                }
            }
        })
    }
}