//
//  HashPresenterView.swift
//  
//
//  Created by Sérgio Ruediger on 09/04/22.
//

import SwiftUI

/// View that appears after the Mini Game that shows the result and gives a brief introduction about passwords and hashes
struct HashPresenterView: View {
    /// Player's final MiniGame score
    internal let miniGameScore: Int
    /// Callback that happens when the main window is closed
    internal let completionHandler: () -> Void
    @State internal var viewModel = HashPresenterViewModel()
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .onAppear { viewModel.initTerminalText(withScore: miniGameScore) }
            
            TerminalTextView(viewModel: $viewModel.terminalText).onAppear {
                self.viewModel.firstWindowPresented = true
            }.padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 0))
            
            if viewModel.terminalText.linesOnScreen.count >= 4 {
                if viewModel.firstWindowPresented {
                    self.createMainWindowView()
                        .zIndex(viewModel.mainWindowTapped ? 1 : 0)
                        .onTapGesture { viewModel.mainWindowTapped = true }
                }
                
                if viewModel.secondWindowPresented {
                    self.createHashCalculatorView()
                        .zIndex(viewModel.mainWindowTapped ? 0 : 1)
                        .onAppear { viewModel.mainWindowTapped = false }
                        .onTapGesture { viewModel.mainWindowTapped = false }
                }
            }
        }
    }
    
}
