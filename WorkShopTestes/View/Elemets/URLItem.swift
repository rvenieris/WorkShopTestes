//
//  URLItem.swift
//  HTTP Viability Check
//
//  Created by Ricardo Venieris on 28/05/21.
//

import SwiftUI

struct URLItem: View {
    @StateObject var urlState:URLState
    var url:String {
        return self.urlState.url.absoluteString
    }
    
    var state:String {
        return self.urlState.state.rawValue
    }
    
    var statusCode:String {
        return "\(self.urlState.statusCode)"
    }
    
    var body: some View {
        HStack {
            Text(url)
                .multilineTextAlignment(.leading)
                .lineLimit(100)
            Spacer()
            
            ZStack {
                Text(state)
                    .font(.largeTitle)
                Text(statusCode)
                    .font(.subheadline)
                    .fontWeight(.light)
                    .opacity(0.5)
            }
        }
    }
}

struct URLItem_Previews: PreviewProvider {
    @State static var url = URLState(url: "TestURL.com.br/thisIsALongLongURL_JustForTestPurposes")!
    static var previews: some View {
        URLItem(urlState: Self.url)
    }
}
