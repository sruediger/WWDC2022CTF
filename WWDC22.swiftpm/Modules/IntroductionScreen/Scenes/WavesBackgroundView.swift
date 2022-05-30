//
//  WavesBackgroundView.swift
//  
//
//  Created by Sérgio Ruediger on 22/04/22.
//

import SwiftUI

/// MovingGradientBackground wrapper that creates the IntroductionView background
struct WavesBackgroundView: View {
    /// The colors used in this animation
    private var colors: [Color] { [.clear, Color(uiColor: .systemPurple), Color(uiColor: .systemIndigo), Color(uiColor: .systemTeal), Color(uiColor: .systemCyan), Color(uiColor: .systemMint), Color(uiColor: .systemBlue), Color(uiColor: .magenta), Color(uiColor: .systemPink), .clear] }
    
    var body: some View {
        MovingGradientBackgroundView(animationColors: colors)
            .blur(radius: 50)
            .scaleEffect(1.4)
            .opacity(0.2)
            .mask(
                Rectangle()
                    .cornerRadius(22)
                    .frame(width: 512, height: 318)
                    .padding(.bottom, 40)
            )
    }
}
