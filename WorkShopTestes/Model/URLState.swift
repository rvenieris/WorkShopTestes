//
//  URLState.swift
//  HTTP Viability Check
//
//  Created by Ricardo Venieris on 30/05/21.
//

import Foundation


class URLState:NSObject, ObservableObject {
    let url:URL
    @Published var statusCode:Int = 0
    var state:URLStateCase { return .from(statusCode) }
    var lastUpdate:Date = Date.distantPast

    @Published private(set) var lastCheckResult:Result<HTTPURLResponse, Error>? {
        didSet {
            lastUpdate = Date()
            switch lastCheckResult {
            case .none, .failure(_):
                statusCode = 0
            case .success(let httpResponse):
                statusCode = httpResponse.statusCode
                
            }
        }
    }
    
    
    init?(url:String) {
        guard let url = URL(string: url) else {return nil}
        self.url = url
        super.init()
    }
    
    func refreshState(timeout: TimeInterval) {
        NetworkServices
            .checkState(of: url, timeout: timeout) { result in
                DispatchQueue.main.async {
                    self.lastCheckResult = result
                }
                
            }
    }
    
    static func == (lhs: URLState, rhs: URLState) -> Bool {
        return lhs.url.absoluteString.elementsEqual(rhs.url.absoluteString)
    }
    
}
