//
//  MiniGameView+Builders.swift
//
//
//  Created by Sérgio Ruediger on 07/04/22.
//

import SwiftUI

/// MiniGameView+InternalBuilders
extension MiniGameView {
    
    /// Main builder used to create all MacOSWindow views generically
    /// - Returns MacOSWindowView instance
    @ViewBuilder internal func createMacOSWindow() -> some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
                .opacity(viewModel.levelStarted ? 0 : 1)
            
            let windowSize: CGSize = viewModel.getWindowSize()
            
            MacOSWindowView(dimensions: windowSize) {
                VStack(alignment: .center, spacing: 10) {
                    if !viewModel.levelStarted {
                        self.createStartWindowSubview()
                    }else if viewModel.gameOver {
                        self.createGameOverWindowSubview()
                    }else if viewModel.maxScoreReached {
                        self.createLevelPassedWindowSubview()
                    }
                }.foregroundColor(.white).frame(width: windowSize.width - 64)
            } onDismiss: {
                if !viewModel.levelStarted {
                    self.viewModel.levelStarted = true
                }else {
                    self.completionHandler(nil) // end game
                }
            }
        }
    }
    
    /// Creates a triad of an certain type
    /// - Parameter type: The type of the triad being created
    /// - Returns the specific triad view (attack or defense)
    @ViewBuilder internal func createTriad(of type: InfosecItemType) -> some View {
        HStack(spacing: type == .defense ? 15 : 20) {
            ForEach(0..<3, id: \.self) { index in
                switch type {
                    case .defense: create(defenseButton: $viewModel.securityPillars[index])
                    case .threat: create(threatButton: $viewModel.threats[index], at: index)
                }
            }
        }
    }
    
    /// Creates the MiniGame background
    /// - Returns MiniGameBackground View 
    @ViewBuilder internal func createMiniGameBackground() -> some View {
        Group {
            if viewModel.levelStarted { // GameInProgress
                BlueAndRedWavesBackgroundView()
            }else { // Default
                Color.black
            }
        }.ignoresSafeArea()
    }
}
    
/// MiniGameView+SubviewBuilders
extension MiniGameView {
    
    /// Creates the mini game intro (aka startWindow) window content
    /// - Returns Mini Game Intro View
    @ViewBuilder private func createStartWindowSubview() -> some View {
        let windowTexts: [String] = viewModel.getText(of: .introWindow)
        
        ForEach(0..<windowTexts.count, id: \.self) { row in
            let textContent: String = windowTexts[row]
            let fontSize: Double = (row == 0 ? 32 : 24)
            let fontWeight: Font.Weight = (row == 0 ? .heavy : (row == 3 ? .bold : .medium))
            RoundedText(content: textContent, size: fontSize, weight: fontWeight)
        }
    }
    
    /// Creates the game over window content
    /// - Returns Game Over View
    @ViewBuilder private func createGameOverWindowSubview() -> some View {
        if let infection = viewModel.infection {
            Image(infection.properties.imagePath)
                .resizable()
                .frame(width: 64, height: 64)
                .foregroundColor(.white)
            
            RoundedText(content: infection.getDescription().title, size: 28, weight: .bold)
            
            if !infection.properties.imagePath.contains("incognito") {
                Spacer()
            }
            
            ScrollView(.vertical) {
                Text(infection.getDescription().info)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.center)
            }

            self.createEndingButtons()
                .padding(.top, 25)
        }
    }
    
    /// Creates the level passed window content
    /// - Returns Level Passed View
    @ViewBuilder private func createLevelPassedWindowSubview() -> some View {
        VStack(spacing: 15) {
            RoundedText(content: "Congratulations!", size: 32, weight: .heavy)
            RoundedText(content: "All \(viewModel.score) threats eliminated.", size: 28, weight: .bold)
            self.createEndingButtons()
        }.padding(.top, 20)
    }
}

/// MiniGameView+ComponentBuilders
extension MiniGameView {
    
    /// Creates the endgame bottom leading buttons
    /// - Returns Ending Buttons View
    @ViewBuilder private func createEndingButtons() -> some View {
        VStack(alignment: .center, spacing: 15) {
            RoundedText(content: "Do you want to play again ?", size: 26, weight: .semibold)
            HStack {
                ForEach(0..<2, id: \.self) { column in
                    let label = (column == 0 ? "Yes" : "No")
                    let callback: () -> Void = (column == 0 ? { viewModel.playAgain = true } : {
                        self.completionHandler(viewModel.maxScoreReached ? viewModel.score : nil)
                    })
                    
                    self.createEndConfirmationButton(label: label, completionHandler: callback)
                    
                    if column == 0 { Spacer() }
                }
            }.padding(EdgeInsets(top: 0, leading: 64, bottom: 15, trailing: 64))
        }
    }

    /// Creates an specific ending button; called by createEndingButtons()
    /// - Returns Ending Button View
    @ViewBuilder private func createEndConfirmationButton(label: String, completionHandler: @escaping () -> Void) -> some View {
        Button(action: completionHandler) {
            RoundedText(content: label, size: 24, weight: .heavy)
                .foregroundColor(label.contains("N") ? .red : .green)
        }.padding()
    }
    
    /// Creates an defense button
    /// - Parameter source: Data source of the button
    /// - Returns Defense button view instance
    @ViewBuilder private func create(defenseButton source: Binding<DefenseViewModel>) -> some View {
        DefenseItemView(viewModel: source)
    }
    
    /// Creates an threat button
    /// - Parameter source: Data source of the button
    /// - Parameter index: Index of the button used to modify it's infection original reference
    /// - Returns Threat button view instance
    @ViewBuilder private func create(threatButton source: Binding<ThreatViewModel>, at index: Int) -> some View {
        ThreatItemView(viewModel: source) { status in
            if status { // Player made a score
                self.viewModel.score += 1
                
                if viewModel.score % 8 == 0 {
                    // Shuffle the threats
                    withAnimation(.linear(duration: 1)) {
                        viewModel.threats = viewModel.threats.shuffled()
                        viewModel.threats.indices.forEach {
                            viewModel.threats[$0].isSelected = false
                        }
                    }
                }
            }else { // Game over
                withAnimation(.linear(duration: 1)) {
                    self.viewModel.securityPillars[index].isInfected = true
                }
                if !self.viewModel.gameOver && self.viewModel.infection == nil {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            self.viewModel.gameOver = true
                        }
                        self.viewModel.infection = source.wrappedValue
                    }
                }
            }
        }
    }
}
