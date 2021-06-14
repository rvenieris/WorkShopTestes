//
//  TestHelper.swift
//  HTTP Viability Check
//
//  Created by Ricardo Venieris on 06/06/21.
//

import Combine
import SwiftUI
import Foundation
import XCTest


extension XCTestCase {
    /**
     Helpers
     */
    func expect<T: ObservableObject>(publisher: T,
                                     expectation: XCTestExpectation)->AnyCancellable {
        var expectationNotFulfilled = true
        return publisher.objectWillChange
            .sink(receiveCompletion: {_ in
                print("---- receiveCompletion ----")
                if expectationNotFulfilled {
                    expectationNotFulfilled = false
                    expectation.fulfill()
                }
            },receiveValue: {_ in
                print("---- receiveValue ----", expectation.description)
                if expectationNotFulfilled {
                    expectationNotFulfilled = false
                    expectation.fulfill()
                }
                  })
    }

}

