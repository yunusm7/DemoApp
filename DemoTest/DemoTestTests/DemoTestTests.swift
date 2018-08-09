//
//  DemoTestTests.swift
//  DemoTestTests
//
//  Created by Mohammad Yunus on 8/9/18.
//  Copyright © 2018 Mohammad Yunus. All rights reserved.
//

import XCTest
@testable import DemoTest

class DemoTestTests: XCTestCase {
    
    var newsFeedFailableSUT:NewsFeed!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.newsFeedFailableSUT = NewsFeed(data: self.loadDummyNewsFeedFailableData())

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.newsFeedFailableSUT = nil

    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: Helper Static Data
    func loadDummyNewsFeedFailableData() -> [String : Any] {
        return ["title" : "",
                "byline" : "By NICHOLAS FANDOS and KEVIN ROOSE",
                "published_date" : "2018-07-31"
        ]
    }
    
}
