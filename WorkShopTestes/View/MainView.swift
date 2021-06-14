//
//  ContentView.swift
//  HTTP Viability Check
//
//  Created by Ricardo Venieris on 28/05/21.
//

import SwiftUI

//@available(iOS 15.0, *)
struct MainView: View {
    
    let timeTrigger:TimeTriggerController
    @ObservedObject var dataSource:MainDataSource
    var urlList:[URLState] { return self.dataSource.urlList }
    
    @State var newURL:String = "http://"
    @State var alertOn = false
    @State var alertMSG:(title:Text, message: Text)
                      = (title:Text(""), message: Text(""))
    
    
    init(timeTrigger: TimeTriggerController) {
        self.timeTrigger = timeTrigger
        self.dataSource = timeTrigger.data
    }
    
    var body: some View {
        VStack {
            Text("URL Monitor")
                .font(.headline)
            TimedBar(totalTime: dataSource.refreshTimeInSeconds, barColor: .gray, restartOnFinish: true)
                .frame(height: 2.0)
            
            List {
                HStack {
                    TextField(
                        "Add URL to monitor", text: $newURL, onCommit: {
                            add(newURL: newURL)
                        })
                    Button("+") {
                        add(newURL: newURL)
                    }
                }
                Spacer()

                ForEach(urlList, id:\.self) {item in
                    URLItem(urlState:item)
                        .onTapGesture {
                            self.newURL = item.url.absoluteString
                        }

//                    Text(item.url.absoluteString)
                }.onDelete(perform: delete)
                    .onMove(perform: move)
            }
            
            
        }.alert(isPresented: $alertOn, content: {
            Alert(title: alertMSG.title,
                  message: alertMSG.message,
                  dismissButton: Alert
                    .Button
                    .default(Text("Ok"),
                             action: {
                                alertOn = false
                             }))
        })
    }
    
    func add(newURL: String) {
        guard let newURLState = URLState(url: newURL) else {
            showAlert(title: "Invalid URL",
                      message: "Please Insert a Valid URL")
            return
        }
        
        guard !urlList.exists(newURLState) else {
            showAlert(title: "Duplicated URL",
                      message: "URL already exists")
            return
        }
        
        dataSource.urlList.insert(newURLState, at:0)

        self.newURL = "http://"

    }
    
    func delete(at offsets: IndexSet) {
        print(offset)
        dataSource.urlList.remove(atOffsets: offsets)
    }
    func move(at offsets: IndexSet, to new:Int) {
        print(offsets, new)
    }
    
    func showAlert(title:String, message: String) {
        alertMSG = (title:Text(title), message: Text(message))
        alertOn = true
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(timeTrigger: TimeTriggerController(dataToObserve: mainDataSource))
    }
}
