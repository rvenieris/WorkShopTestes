//
//  ProgressBar.swift
//  HTTP Viability Check
//
//  Created by Ricardo Venieris on 05/06/21.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var barColor: Color
    @Binding var progress: CGFloat {
        didSet { progress.limit(max: 1) }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                // Main Bar
                Rectangle()
                    .fill(barColor.opacity(0.3))
                // Progress Bar
                Rectangle()
                    .fill(barColor)
                    .frame(width: min(geo.size.width, geo.size.width * progress))
            }.cornerRadius(45.0)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    @State static var progress: CGFloat = 0.3
    @State static var barColor: Color = .red
    static var previews: some View {
        ProgressBar(barColor: $barColor, progress: $progress)
    }
}
