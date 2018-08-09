//
//  ActivityIndicatorView.swift
//  DemoTest
//
//  Created by Mohammad Yunus on 8/9/18.
//  Copyright © 2018 Mohammad Yunus. All rights reserved.
//

import UIKit
import RappleProgressHUD

class ActivityIndicatorView: NSObject {
    
    class func showActivity() {
        RappleActivityIndicatorView.startAnimating()
    }
    
    class func showActivityWithText() {
        RappleActivityIndicatorView.startAnimatingWithLabel("Processing...", attributes: RappleModernAttributes)
    }
    
    class func showActivityWithText(text: String) {
        RappleActivityIndicatorView.startAnimatingWithLabel(text, attributes: RappleModernAttributes)
    }
    
    class func hideActivity() {
        RappleActivityIndicatorView.stopAnimation()
    }
    
    class func hideActivity(_ status: RappleCompletion, text: String) {
        RappleActivityIndicatorView.stopAnimation(completionIndicator: status, completionLabel: text)
    }
    
}
