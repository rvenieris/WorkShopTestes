//
//  TimerBar.swift
//  HTTP Viability Check
//
//  Created by Ricardo Venieris on 05/06/21.
//

import SwiftUI

struct TimedBar: View {
    var totalTime: TimeInterval = 5
    @State var barColor: Color = .blue
    @State var progress: CGFloat = 0.0
    var refreshRate:Double = 30
    var restartOnFinish = false
    var completion: ()->Void = {}
    
    var body: some View {
        ProgressBar(barColor: $barColor, progress: $progress)
        .onAppear {
            self.start()
        }
    }
    
    
    func start() {
        let totalSteps = totalTime * refreshRate
        let interval = totalTime/totalSteps
        let step = CGFloat(1/totalSteps)
        Timer.scheduledTimer(withTimeInterval: interval, repeats: true) {
            timer in
            self.progress += step
            if self.progress >= 1 {
                if restartOnFinish {
                    self.progress = 0
                } else {
                timer.invalidate()
                completion()
                }
            }
        }
    }
    
}
    
struct TimerBar_Previews: PreviewProvider {
    static var previews: some View {
        TimedBar(totalTime: 2,
                 barColor: .blue ,
                 restartOnFinish: true)
//            .animation(.linear)
    }
}
