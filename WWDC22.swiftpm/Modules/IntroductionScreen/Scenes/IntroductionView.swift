//
//  IntroductionView.swift
//  
//
//  Created by Sérgio Ruediger on 06/04/22.
//

import SwiftUI

/// The first interactive scene View
struct IntroductionView: View {
    @State internal var viewModel = IntroductionViewModel()
    /// Callback that happens when the introduction ends
    let completionHandler: () -> Void
        
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            self.createTerminalTextView()
            
            if viewModel.terminalText.linesOnScreen.count >= 5 {
                Group {
                    if viewModel.firstWindowPresented {
                        self.createFirstWindowView()
                            .zIndex(viewModel.mainWindowTapped ? 1 : 0)
                            .onTapGesture { viewModel.mainWindowTapped = true }
                    }
                    if viewModel.secondWindowPresented {
                        self.createSecondWindowView()
                            .zIndex(viewModel.mainWindowTapped ? 0 : 1)
                            .onTapGesture { viewModel.mainWindowTapped = false }
                    }
                }
            }
        }
    }
}
