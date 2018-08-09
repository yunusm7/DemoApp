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
    
    /// Get the NewsFeed data from server using REST API.
    ///
    /// - Parameter completionBlock: completion block to notify get the response from REST API

    func getAboutNewsFeedData(completionBlock : @escaping (() ->())) {
        let aboutNewsFeedUrl = APIPaths.baseUrl
        
        ServerHandler.sendGetRequest(functionName: aboutNewsFeedUrl, showLoader: true) { (result, error) in
            //Success result from the server
            if error == nil {
                /// Remove old data from array
                self.aboutNewsDatas.removeAll()

                let response = self.convertToDictionary(text: result as! String)
                if let responseData = response!["results"], responseData is [[String: Any]]{
                    let responseDictionary = responseData as! [[String : Any]]
                    for newsFeed in responseDictionary {
                        if let news = NewsFeed(data: newsFeed) {
                            self.aboutNewsDatas.append(news)
                        }
                    }
                }
            } else {
                /// In case if server send the error then show the message
                AlertView.showAlert(title: "Alert!", message: "Can't load items", cancelBtnTitle: "OK")
            }
            completionBlock()
            
        }
    }
    
    // MARK: Convert String to Dictionary
    
    /// Convert String to Dictionary with jsonObject method of JSONSerialization
    ///
    /// - Parameter text: pass the valid string
    /// - Returns: Optional Dictionary of type [String: Any]?
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
    
    //MARK: Return number of rows
    
    /// Get the count of the News to show news list
    ///
    /// - Returns: total number of news count

    func numberofRows() -> Int {
        return aboutNewsDatas.count
    }
    
    //MARK: Return About News data for showing on cell
    
    /// Get the news corresponding to passed index path
    ///
    /// - Parameter indexPath: pass the valid/selected index path
    /// - Returns: AboutNews object

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
