//
//  IntroductionView+Builders.swift
//  
//
//  Created by Sérgio Ruediger on 19/04/22.
//

import SwiftUI

/// IntroductionView+Builders
extension IntroductionView {
    
    /// Creates an TerminalTextView
    /// - Returns TerminalTextView instance
    @ViewBuilder internal func createTerminalTextView() -> some View {
        TerminalTextView(viewModel: $viewModel.terminalText).onAppear{
            self.viewModel.firstWindowPresented = true
        }.onChange(of: viewModel.firstWindowPresented) { windowOpened in
            if !windowOpened {
                viewModel.terminalText.showEndingText.toggle()
            }
        }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
    }
    
    /// Creates the 1st MacOS Window View (greeter)
    /// - Returns MacOSWindowView instance
    @ViewBuilder internal func createFirstWindowView() -> some View {
        MacOSWindowView(dimensions: CGSize(width: 512, height: 320), windowClosed: $viewModel.firstWindowPresented, isDragging: $viewModel.firstWindowDragged) {
                WavesBackgroundView()
                    .allowsHitTesting(false)
                
                DynamicGreeterView()
            } onDismiss: {
                guard viewModel.terminalText.linesOnScreen.count >= IntroductionModel.terminalTextContent.count - 2 else { return }
                self.viewModel.toggleVisibilityOf(secondWindow: true)
            }.transition(.slide)
            .disabled(viewModel.secondWindowPresented && !viewModel.mainWindowTapped ? true : false)
            .onDisappear { completionHandler() }
    }
    
    /// Creates the 2nd MacOS Window View
    /// - Returns MacOSWindowView instance
    @ViewBuilder internal func createSecondWindowView() -> some View {
       // let size = CGSize(width: UIScreen.main.bounds.width * 0.45, height: UIScreen.main.bounds.height * 0.45)
        MacOSWindowView(dimensions: CGSize(width: 448, height: 340)) {
            VStack(alignment: .leading, spacing: 10) {
                RoundedText(content: IntroductionModel.secondWindowText.title, size: 20, weight: .bold)
                RoundedText(content: IntroductionModel.secondWindowText.body, size: 18, weight: .semibold)
            }.foregroundColor(.white).frame(width: 400)
        } onDismiss: {
            self.viewModel.toggleVisibilityOf(firstWindow: false, secondWindow: false)
        }.transition(.scale.animation(.linear(duration: 0.25))).offset(x: 64, y: -200)
    }
    
}
