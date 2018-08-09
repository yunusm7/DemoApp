//
//  NewsFeed.swift
//  DemoTest
//
//  Created by Mohammad Yunus on 8/9/18.
//  Copyright © 2018 Mohammad Yunus. All rights reserved.
//

import UIKit

class NewsFeed: NSObject {
    var title: String
    var byline: String
    var publishedDate: String
    
    init?(data:[String : Any]) {
        guard let title = data["title"] as? String, !title.isEmpty else { return nil }
        self.title = title
        byline = data["byline"] as? String ?? ""
        publishedDate = data["published_date"] as? String ?? ""
    }
    
}
