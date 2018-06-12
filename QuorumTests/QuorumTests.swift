//
//  QuorumTests.swift
//  QuorumTests
//
//  Created by Dmytro Nasyrov on 6/9/18.
//  Copyright © 2018 Pharos Production Inc. All rights reserved.
//

import XCTest
@testable import Quorum

class QuorumTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let quorum1 = Quorum()
        print("Q1: ", quorum1.params)
        
        let config = Web3Config(scheme: "http", host: "127.0.0.2", port: 22000, networkId: 10)
        let quorum2 = Quorum(params: config)
        print("Q2: ", quorum2.params)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
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
    
}
