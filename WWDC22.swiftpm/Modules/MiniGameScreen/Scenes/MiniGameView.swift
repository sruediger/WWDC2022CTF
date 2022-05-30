//
//  MiniGameView.swift
//  
//
//  Created by Sérgio Ruediger on 07/04/22.
//

import SwiftUI

/// The Mini Game View which appears after the Introduction
public struct MiniGameView: View {
    internal typealias Callback = (Int?) -> Void
    @State internal var viewModel = MiniGameViewModel()
    /// Callback used when the level ends (passed or skipped)
    internal let completionHandler: Callback
    
    public var body: some View {
        ZStack {
            self.createMiniGameBackground()
            
            if viewModel.levelStarted && !viewModel.gameOver {
                VStack {
                    HStack {
                        Spacer()
                        RoundedText(content: String("Score\t\(viewModel.score)"), size: 28, weight: .bold)
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                    }.opacity(viewModel.isGameInProgress ? 1 : 0)
                        
                    if !viewModel.maxScoreReached {
                        Group {
                            self.createTriad(of: .threat)
                            Spacer()
                            self.createTriad(of: .defense)
                                .offset(x: .zero, y: -(UIScreen.main.bounds.height * 0.05)) // Defenses height offset is -5% of the screen size
                        }
                        .transition(.identity.animation(.easeOut(duration: 0.55)))
                        .disabled(!viewModel.maxScoreReached ? false : true)
                    }else { /// Level finished
                        self.createMacOSWindow()
                            .transition(.scale.animation(.easeIn(duration: 0.25)))
                            .onDisappear { self.completionHandler(viewModel.playAgain ? 0 : viewModel.score) }
                    }
                }.transition(.identity.animation(.easeOut(duration: 1)))
            }else { /// Level Intro or Game Over
                self.createMacOSWindow()
                    .transition(.scale.animation(.easeIn(duration: 0.25)))
            }
        }
    }
}
