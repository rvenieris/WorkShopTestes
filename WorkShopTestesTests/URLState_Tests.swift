//
//  URLState_Tests.swift
//  WorkShopTestesTests
//
//  Created by Ricardo Venieris on 14/06/21.
//

import Combine
import SwiftUI
import Foundation

import XCTest

class URLState_Tests: XCTestCase {
    
    @ObservedObject var obj1:URLState = URLState(url: TestData.URLString_apple)!
    @ObservedObject var obj2:URLState = URLState(url: TestData.URLString_apple_inexistent_file)!
    @ObservedObject var obj3:URLState = URLState(url: TestData.URLString_apple)!

    
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        obj1 = URLState(url: TestData.URLString_apple)!
        obj2 = URLState(url: TestData.URLString_apple_inexistent_file)!
        obj3 = URLState(url: TestData.URLString_apple)!
    }

    func testURLStateEquality() throws {
        // 2 URLStates are equal if both urls are the same, other properties aren't important

        // if equality is correct different statusCode do not metter
        obj1.statusCode = 1
        obj2.statusCode = 1
        obj3.statusCode = 3
        
        // Objects are different
        XCTAssertNotEqual(obj1, obj2)
        XCTAssertNotEqual(obj1, obj3)

        // Equality came false if url aren't the same
        XCTAssertFalse(obj1 == obj2)

        // Equality came true if url are the same
        XCTAssertTrue(obj1 == obj3)
        
        
    }
    
    func testURLStateRefreshOnLine() throws {
        let obj = obj1
        let cancellable1 = expect(publisher: obj,
                                 expectation: expectation(description: "Checking \(obj.url.absoluteString)"))
        
        // Before refresh, state must be .unreachable
        XCTAssertTrue(obj.state == .unreachable)

        obj.refreshState(timeout: 1)
        
        waitForExpectations(timeout: 2, handler: {_ in
            XCTAssertEqual(obj.state, URLStateCase.onLine)
            cancellable1.cancel()
        })
    }
    
    func testURLStateRefreshOffLine() throws {
        let obj = obj2
        let cancellable = expect(publisher: obj,
                                 expectation: expectation(description: "Checking \(obj.url.absoluteString)"))
        
        // Before refresh state must be .unreachable
        XCTAssertTrue(obj.state == .unreachable)

        obj.refreshState(timeout: 5)
        
        waitForExpectations(timeout: 50, handler: {_ in
            XCTAssertEqual(obj.state, URLStateCase.offLine)
            cancellable.cancel()
        })
    }
    
    func testInvalidURL() throws {
        let testURLState = URLState(url: "invalid string url")
        XCTAssertTrue(testURLState == nil)
    }

    
    

}
