//
//  WWDCSceneView+Builders.swift
//
//
//  Created by Sérgio Ruediger on 20/04/22.
//

import SwiftUI

extension WWDCSceneView {
    
    /// Warning displayed on unsupported devices
    /// - Returns createUnsupportedDeviceWarningView
    @ViewBuilder internal func createUnsupportedDeviceWarningView() -> some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("Unsupported device. Please run this playground on an iPad.")
                    .bold()
                    .font(.headline)
                    .foregroundColor(.green)
                Spacer()
            }
        }
    }
    
    /// Main method that automatically switches the interactive scene views
    /// - Returns the currently displayed view
    @ViewBuilder internal func autoSwitchViews() -> some View {
        if !viewModel.introductionFinished {
            self.createIntroductionView()
        }else if !viewModel.miniGamePassed {
            self.createMiniGameView()
        }else {
            if viewModel.showFallingLetters {
                self.createLetterRainView()
            }else if !viewModel.showPasswordBreaker {
                self.createHashPresenterView()
            }else { PasswordStrengthMeterView() }
        }
    }
    
    /// Creates an IntroductionView
    /// - Returns IntroductionView instance
    @ViewBuilder private func createIntroductionView() -> some View {
        IntroductionView() {
            Snippets.runAfter(timeInSeconds: 3.25) {
                self.viewModel.introductionFinished = true
            }
        }.transition(.identity.animation(.easeInOut))
    }
    
    /// Creates an MiniGameView
    /// - Returns MiniGameView instance
    @ViewBuilder private func createMiniGameView() -> some View {
        MiniGameView() { score in
            let playAgain: Int = 0
            if score != playAgain {
                // Happens even if the score is nil, which represents game over
                self.viewModel.miniGamePassed = true
            }
            self.viewModel.miniGameScore = score ?? 0
        }.transition(.identity.animation(.easeInOut))
    }
    
    /// Creates an HashPresenterView
    /// - Returns HashPresenterView instance
    @ViewBuilder private func createHashPresenterView() -> some View {
        HashPresenterView(miniGameScore: viewModel.miniGameScore) {
            Snippets.runAfter(timeInSeconds: 2) {
                self.viewModel.showPasswordBreaker = true
            }
        }
    }
    
    /// Creates an LetterRainView
    /// - Returns LetterRainView instance
    @ViewBuilder private func createLetterRainView() -> some View {
        LetterRainView(duration: 3)
            .scaleEffect(UIScreen.main.bounds.height >= 1366 ? 1.2 : 1)
            .onAppear {
                Snippets.runAfter(timeInSeconds: 6) {
                    self.viewModel.showFallingLetters = false
                }
            }
    }
}
