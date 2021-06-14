//
//  TimerTrigger.swift
//  HTTP Viability Check
//
//  Created by Ricardo Venieris on 30/05/21.
//

import Foundation


/**
 The timer
 */
class TimeTriggerController: NSObject {
    
    private var timer:Timer?
    
    // Add a KVO to the mainDataSource
    @objc var data: MainDataSource
    private var refreshTimeInSecondsObservation: NSKeyValueObservation?
    
    init(dataToObserve data: MainDataSource) {
        self.data = data
        super.init()
        
        refreshTimeInSecondsObservation = observe(
            \.data.refreshTimeInSeconds,
            options: [.old, .new]
        ) { object, change in
            self.renewRefreshTimer()
        }
        self.data.refreshTimeInSeconds = 5
    }
    
    func renewRefreshTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: mainDataSource.refreshTimeInSeconds,
            repeats: true, block: {_ in
                self.data.refreshUrlList()
            })
    }
    
}
