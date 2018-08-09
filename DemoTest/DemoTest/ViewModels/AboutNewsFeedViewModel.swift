//
//  AboutNewsFeedViewModel.swift
//  DemoTest
//
//  Created by Mohammad Yunus on 8/9/18.
//  Copyright © 2018 Mohammad Yunus. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class AboutNewsFeedViewModel {
    var aboutNewsDatas = [NewsFeed]()
    
    // MARK:- Get About NewsFeed Data From Server
    func getAboutNewsFeedData(completionBlock : @escaping (() ->())) {
        let aboutNewsFeedUrl = APIPaths.baseUrl
        
        ServerHandler.sendGetRequest(functionName: aboutNewsFeedUrl, showLoader: true) { (result, error) in
            //Success result from the server
            if error == nil {
                // self.aboutCountryDatas = result
                //print(result)
                let response = self.convertToDictionary(text: result as! String)
                
            } else {
                print(error ?? "")
                AlertView.showAlert(title: "Alert!", message: "Can't load items", cancelBtnTitle: "OK")
            }
            completionBlock()
            
        }
    }
    
    //MARK: Convert String to Dictionary
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func numberofRows() -> Int {
        return aboutNewsDatas.count
    }
    
    func getNewsFeedRecord(indexPath : IndexPath) -> NewsFeed {
        return aboutNewsDatas[indexPath.row]
    }
    
    
}
extension UIImageView {
    
    func setImage(_ url: String) {
        guard url.isEmpty == false else {
            return
        }
        if let uRL = URL(string: url) {
            self.sd_setImage(with: uRL, completed: nil)
        }
    }
}
