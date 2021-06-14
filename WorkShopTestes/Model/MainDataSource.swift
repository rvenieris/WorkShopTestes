//
//  MainDataSource.swift
//  HTTP Viability Check
//
//  Created by Ricardo Venieris on 30/05/21.
//

import SwiftUI

let mainDataSource = MainDataSource()

/**
 This class cotains  information that will be saved between user sessions
 */
class MainDataSource: NSObject, ObservableObject {
    
    @objc dynamic var refreshTimeInSeconds:TimeInterval = 60
    @Published var urlList:[URLState] = []
    
    fileprivate override init() {
        super.init()
        #if DEBUG
        if self.urlList.isEmpty {
            self.urlList =
                [
                    "http://localhost:9999",
                    "http://localhost:80",
                    "https://www.google.com",
                    "https://www.google.com/wnorgjnwrog.xxx",
                ].asURLStateArray
        }
        
        #endif
    }
    
    func refreshUrlList() {

    }
}
