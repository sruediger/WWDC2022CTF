//
//  MovingGradientBackgroundView.swift
//  
//
//  Created by Sérgio Ruediger on 22/04/22.
//

import SwiftUI

/// View that creates an animated gradient background
struct MovingGradientBackgroundView: View {
    /// Colors used in the background animation
    internal let animationColors: [Color]
    @State private var viewModel = MovingGradientBackgroundViewModel()
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: animationColors), startPoint: viewModel.start, endPoint: viewModel.end)
            .animation(.easeInOut(duration: 6).repeatForever(autoreverses: true), value: [viewModel.start, viewModel.end])
            .onReceive(viewModel.timer, perform: { _ in
                DispatchQueue.main.async {
                    viewModel.updatePosition()
                }
            })
    }
}
