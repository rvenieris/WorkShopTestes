//
//  ModelExtensions.swift
//  HTTP Viability Check
//
//  Created by Ricardo Venieris on 30/05/21.
//

import Foundation

extension Array where Element == String {
    var asURLStateArray:[URLState] {
        return self.compactMap {URLState(url: $0)}
    }
}

extension Array where Element == URLState {
    func exists(_ otherURLState:URLState)->Bool {
        for item in self {
//            print(item.url.absoluteString)
//            print(otherURLState.url.absoluteString)
            if item == otherURLState { return true }
        }        
        return false
    }
}

extension Comparable where Self:Numeric {
    mutating func limit(min: Self) {
        self = self < min ? min : self
    }
    mutating func limit(max: Self) {
        self = self > max ? max : self
    }
    mutating func limit(min: Self, max: Self) {
        limit(min: min)
        limit(max: max)
    }
    
}
