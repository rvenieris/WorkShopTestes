//
//  NetworkServices.swift
//  HTTP Viability Check
//
//  Created by Ricardo Venieris on 05/06/21.
//

import Foundation
import SystemConfiguration
import Network

enum NetworkError:Error {
    case undefined
}


class NetworkServices {
    
    static func checkState(of url:URL,
                           timeout:TimeInterval,
                           completion: @escaping (Result<HTTPURLResponse, Error>)->Void ) {
        
        var request = URLRequest(url: url,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: timeout)
        request.httpShouldHandleCookies = false
        request.httpShouldUsePipelining = false
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                completion(.success(httpResponse))
                
            }
        }
        task.resume()
    }
    
}


