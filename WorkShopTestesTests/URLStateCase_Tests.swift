//
//  URLStateCase_Tests.swift
//  WorkShopTestesTests
//
//  Created by Ricardo Venieris on 14/06/21.
//

import XCTest

class URLStateCase_Tests: XCTestCase {

    func testResponseStateConversion() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertEqual(URLStateCase.from(Int.min), .unreachable)
        XCTAssertEqual(URLStateCase.from(000), .unreachable)
        XCTAssertEqual(URLStateCase.from(099), .unreachable)
        XCTAssertEqual(URLStateCase.from(100), .onLine)
        XCTAssertEqual(URLStateCase.from(199), .onLine)
        XCTAssertEqual(URLStateCase.from(200), .onLine)
        XCTAssertEqual(URLStateCase.from(299), .onLine)
        XCTAssertEqual(URLStateCase.from(300), .onLine)
        XCTAssertEqual(URLStateCase.from(399), .onLine)
        XCTAssertEqual(URLStateCase.from(400), .offLine)
        XCTAssertEqual(URLStateCase.from(499), .offLine)
        XCTAssertEqual(URLStateCase.from(500), .offLine)
        XCTAssertEqual(URLStateCase.from(599), .offLine)
        XCTAssertEqual(URLStateCase.from(Int.max), .unreachable)

    }
}
