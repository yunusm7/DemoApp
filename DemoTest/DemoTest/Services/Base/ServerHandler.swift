//
//  ServerHandler.swift
//  DemoTest
//
//  Created by Mohammad Yunus on 8/9/18.
//  Copyright © 2018 Mohammad Yunus. All rights reserved.
//

import UIKit
import SystemConfiguration

/*
 - Network Activity
 - Fetch server data
 
 */

class ServerHandler: NSObject {
    
    /// Network Activity for checking the network in device
    class func isNetWorkAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
        
    }
    
    class func sendGetRequest(functionName : String, showLoader: Bool,  completionHandler:@escaping ((_ responseValue: Any?, _ error: Error?) -> Void)) -> Void {
        /// Check Network Availability
        
        if isNetWorkAvailable() == true {
            // Show Activity
            if showLoader {
                DispatchQueue.main.async(execute: {
                    ActivityIndicatorView.showActivity()
                })
            }
            
            /// Set up the URL request
            guard let url = URL(string: functionName) else {
                print("Error: cannot create URL")
                return
            }
            let urlRequest = URLRequest(url: url)
            
            /// set up the session
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            
            /// make the request
            let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                
                /// Hide Activity
                if showLoader {
                    DispatchQueue.main.async(execute: {
                        ActivityIndicatorView.hideActivity()
                    })
                }
                
                /*
                 Check the server data and error if we get error result equal to nil
                 then we immediate return the function
                 */
                guard let data = data, error == nil else {
                    return
                }
                let httpStatus = response as? HTTPURLResponse
                
                /*
                 Check server response status code
                 
                 - Success: If we get status code equal to 200 it means we get success response
                 and return success result to the function.
                 - Failure: If we get status code not equal to 200 then return the error message  to the function
                 
                 */
                if httpStatus?.statusCode == 200 {
                    /// Convert first data to UTF8 encoding
                    let utfStringData = String(data: data, encoding: String.Encoding.ascii)
                    completionHandler(utfStringData, nil)
                } else {
                    completionHandler(nil, error)
                }
            })
            task.resume()
            
        } else {
            AlertView.showAlert(title: Messages.Network.title, message: Messages.Network.message, cancelBtnTitle: "OK")
        }
    }
    
}
