//
//  DispatchAfterCTests.swift
//  DispatchAfterCTests
//
//  Created by Nick Brook on 13/09/2016.
//  Copyright © 2016 NickBrook. All rights reserved.
//

import XCTest
@testable import DispatchAfterC

class DispatchAfterCTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let expectation = self.expectation(description: "Called")
        _ = DispatchQueue.main.asyncAfterC(deadline: DispatchTime(timeIntervalSinceNow: 1)) {
            expectation.fulfill()
        }
        let t = DispatchQueue.main.asyncAfterC(deadline: DispatchTime(timeIntervalSinceNow: 1)) {
            XCTFail()
        }
        DispatchQueue.asyncAfterCCancel(token: t)
        self.waitForExpectations(timeout: 1.1, handler: nil)
    }
    
}
