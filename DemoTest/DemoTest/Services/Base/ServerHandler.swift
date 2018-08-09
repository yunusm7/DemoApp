//
//  ServerHandler.swift
//  DemoTest
//
//  Created by Mohammad Yunus on 8/9/18.
//  Copyright © 2018 Mohammad Yunus. All rights reserved.
//

import UIKit
import SystemConfiguration
import Alamofire

class ServerHandler: NSObject {
    
    // Network Activity
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
        // Check Network Availability
        if isNetWorkAvailable() == true {
            // Show the Activity
            if showLoader {
                DispatchQueue.main.async(execute: {
                    ActivityIndicatorView.showActivity()
                })
            }
            let url = functionName
            print("Request Url: \(url)")
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseString(completionHandler: { (response) in
                
                // Hide the Activity
                if showLoader {
                    DispatchQueue.main.async(execute: {
                        ActivityIndicatorView.hideActivity()
                    })
                }
                switch(response.result) {
                case .success(_):
                    if response.result.isSuccess {
                        let result = response.result.value
                        print("Response: \(result!)")
                        completionHandler(result, nil)
                    }
                    break
                    
                case .failure(_):
                    if response.result.isFailure {
                        let error = response.result.error!
                        completionHandler(nil, error)
                    }
                    break
                }
            })
        } else {
            AlertView.showAlert(title: Messages.Network.title, message: Messages.Network.message, cancelBtnTitle: "OK")
        }
    }
    
}
