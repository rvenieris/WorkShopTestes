//
//  URLStateCases.swift
//  HTTP Viability Check
//
//  Created by Ricardo Venieris on 30/05/21.
//

enum URLStateCase:String {
    case onLine = "🟢"
    case offLine = "🔴"
    case unreachable = "⚪️"
    
    static func from(_ statusCode:Int)->URLStateCase {
        switch statusCode {
        case 100...199: // Informational responses
            return .onLine
        case 200...299: // Successful responses
            return .onLine
        case 300...399: // Redirects
            return .onLine
        case 400...499: // Client errors
            return .offLine
        case 500...599: // Server errors
            return .offLine
        default:
            return .unreachable
        }

    }
}
