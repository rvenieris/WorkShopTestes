//
//  NetworkServices_Test.swift
//  HTTP Viability CheckTests
//
//  Created by Ricardo Venieris on 06/06/21.
//

import XCTest

class NetworkServices_Test: XCTestCase {
    let url_onemillionpi = URL(string: TestData.URLString_onemillionpi)!
    let url_fasterwebsite = URL(string: TestData.URLString_fasterwebsite)!
    let url_inexistent = URL(string: TestData.URLString_apple_inexistent_file)!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNetworkServicesCheckState200() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let testURL = url_fasterwebsite
        let expect = expectation(description: "Checking \(testURL.absoluteString)")
        
        NetworkServices.checkState(of: testURL,
                                   timeout: 5, completion: { result in
                                    switch result {
                                    case .success(let response):
                                        XCTAssertEqual(response.statusCode, 200)
                                        expect.fulfill()
                                    case .failure(_):
                                        XCTFail("No internet connection to fulfill Network Tests")
                                    }
                                   })
        
        waitForExpectations(timeout: 5, handler: nil)

        
    }
    
    func testNetworkServicesCheckState404() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let testURL = url_inexistent
        let expect = expectation(description: "Checking \(testURL.absoluteString)")
        
        NetworkServices.checkState(of: testURL,
                                   timeout: 5, completion: { result in
                                    switch result {
                                    case .success(let response):
                                        XCTAssertEqual(response.statusCode, 404)
                                        expect.fulfill()
                                    case .failure(_):
                                        XCTFail("No internet connection to fulfill Network Tests")
                                    }
                                   })
        
        waitForExpectations(timeout: 5, handler: nil)

        
    }

    func testNetworkServicesCheckStateTimeOut() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let testURL = url_onemillionpi
        let expect = expectation(description: "Checking timeout on \(testURL.absoluteString)")
        
        NetworkServices.checkState(of: testURL,
                                   timeout: 0.1, completion: { result in
                                    switch result {
                                    case .success(_):
                                        XCTFail("Request timeout not reached")
                                    case .failure(_):
                                        expect.fulfill()
                                    }
                                   })
        
        waitForExpectations(timeout: 1, handler: nil)

        
    }

}
