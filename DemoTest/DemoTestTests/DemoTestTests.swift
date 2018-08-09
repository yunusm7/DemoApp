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
    var newsFeedSUT:NewsFeed!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.newsFeedFailableSUT = NewsFeed(data: self.loadDummyNewsFeedFailableData())
        self.newsFeedSUT = NewsFeed(data: self.loadDummyNewsFeedData())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        self.newsFeedSUT = nil
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
    //MARK: Synchronus Test
    func testNewsFeedFailableInitializer() {
        
        XCTAssertNotNil(self.newsFeedSUT, "Failed to create object.")
        
        //XCTAssertNotNil(self.newsFeedFailableSUT, "Failed to create object.")
    }
    
    
    
    //MARKL: Asynchronous Test
    func testNewsFeedListing() {
        
        /// Get expectation object
        let expect = expectation(description: "Success")
        
        let aboutNewsFeedUrl = APIPaths.baseUrl
        
        ServerHandler.sendGetRequest(functionName: aboutNewsFeedUrl, showLoader: true) { (result, error) in
            //Success result from the server
            if error == nil {
                
                let response = self.convertToDictionary(text: result as! String)
                
                let status = response!["status"] as? String ?? ""
                if status == "OK" {
                    XCTAssertEqual(status, "OK")
                    expect.fulfill()
                }else {
                    XCTFail()
                }
                
            } else {
                print(error ?? "")
                XCTAssertNil(error, "Unexpected error occured: \(String(describing: error?.localizedDescription))")
            }
        }
        ///We have to update timeout value corresponding to request time out
        waitForExpectations(timeout: 50) { (error) in
            XCTAssertNil(error, "Test timed out. \(error!.localizedDescription)")
        }
    }
    
    //MARK: Helper Static Data
    func loadDummyNewsFeedFailableData() -> [String : Any] {
        return ["title" : "",
                "byline" : "By NICHOLAS FANDOS and KEVIN ROOSE",
                "published_date" : "2018-07-31"
        ]
    }
    
    func loadDummyNewsFeedData() -> [String : Any] {
        return ["title" : "Facebook Identifies an Active Political Influence Campaign Using Fake Accounts",
                "byline" : "By NICHOLAS FANDOS and KEVIN ROOSE",
                "published_date" : "2018-07-31"
        ]
    }
    
    
    
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
    
}
