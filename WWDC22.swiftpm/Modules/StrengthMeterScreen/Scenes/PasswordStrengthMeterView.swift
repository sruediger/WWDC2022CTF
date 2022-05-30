//
//  PasswordStrengthMeterView.swift
//  
//
//  Created by Sérgio Ruediger on 10/04/22.
//
import SwiftUI

/// The last interactive scene View
struct PasswordStrengthMeterView: View {
    @State internal var viewModel = PasswordStrengthMeterViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            TerminalTextView(viewModel: $viewModel.terminalText)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            
            if viewModel.terminalText.linesOnScreen.count >= 1 {
                // Creates the Password Strength Meter (aka iBreaker) window
                self.createMacOSWindow(iBreaker: true)
                    .zIndex(viewModel.mainWindowTapped ? 1 : 0)
                
                if viewModel.presentInfoWindow {
                    self.createMacOSWindow(iBreaker: false) // Creates the info window
                        .offset(x: 96, y: 160)
                        .transition(.scale.animation(.easeIn(duration: 0.25)))
                        .zIndex(viewModel.mainWindowTapped ? 0 : 1)
                }
            }
        }
    }
}
