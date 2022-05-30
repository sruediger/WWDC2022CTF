//
//  BlueAndRedWavesBackgroundView.swift
//  
//
//  Created by Sérgio Ruediger on 21/04/22.
//

import SwiftUI

/// MovingGradientBackground wrapper that creates a blue and red gradient background
struct BlueAndRedWavesBackgroundView: View {
    
    var body: some View {
        MovingGradientBackgroundView(animationColors: [.black, .red, .blue, .black])
            .ignoresSafeArea()
            .blur(radius: 50)
            .scaleEffect(1.4)
            .opacity(0.125)
            .transition(.opacity.animation(.easeIn))
    }
}
