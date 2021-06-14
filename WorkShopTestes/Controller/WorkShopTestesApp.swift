//
//  WorkShopTestesApp.swift
//  WorkShopTestes
//
//  Created by Ricardo Venieris on 13/06/21.
//

import SwiftUI

@main
struct WorkShopTestesApp: App {
    var body: some Scene {
        WindowGroup {
            MainView(timeTrigger: TimeTriggerController(dataToObserve: mainDataSource))
        }
    }
}
