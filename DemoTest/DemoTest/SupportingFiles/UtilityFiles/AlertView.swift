//
//  AlertView.swift
//  DemoTest
//
//  Created by Mohammad Yunus on 8/9/18.
//  Copyright © 2018 Mohammad Yunus. All rights reserved.
//

import UIKit

class AlertView: NSObject {
    
    class func showAlert(title: String, message: String, cancelBtnTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let OkAction = UIAlertAction(title: cancelBtnTitle, style: UIAlertActionStyle.cancel) { (action) -> Void in                    }
        alert.addAction(OkAction)
        let rootViewcontroller = rootViewController()
        DispatchQueue.main.async {
            rootViewcontroller?.present(alert, animated: true, completion: nil)
        }
    }
    
    // Returns the RootViewController of Window.
    class func rootViewController() -> UIViewController? {
        
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            if let presented = viewController.presentedViewController {
                return presented
            } else {
                return viewController
            }
        } else {
            return nil
        }
        
    }
}
