//
//  HashCalculatorButtonView+Builders.swift
//  
//
//  Created by Sérgio Ruediger on 20/04/22.
//

import SwiftUI

extension HashCalculatorButtonView {
    
    /// Creates the calculator's Algorithm Switcher Menu
    /// - Returns AlgorithmSwitcherMenu
    @ViewBuilder internal func createAlgorithmSwitcherMenu() -> some View {
        Menu {
            let hashAlgorithms = HashAlgorithm.allCases
            ForEach(hashAlgorithms, id: \.self) { hashAlgorithm in
                Button {
                    withAnimation {
                        viewModel.chosenAlgorithm = hashAlgorithm
                    }
                } label: {
                    Text(hashAlgorithm.description)
                }
            }
        }label: {
            HStack(alignment: .center, spacing: 5) {
                Text(viewModel.chosenAlgorithm.description)
                    .bold()
                    .font(.title)
                
                Image(systemName: "chevron.down")
                    .resizable()
                    .frame(width: 20, height: 12)
            }
        }
    }
    
    /// Creates an reusable TextView for all buttons
    /// - Returns Text View
    @ViewBuilder internal func createTextView() -> some View {
        Text(model.description)
            .bold()
            .font((model != .algorithm && (model != .randomSalt && model != .randomPepper)) ? .title : .title3)
    }
    
    /// Creates the Equal Button Image View
    /// - Returns ImageView
    @ViewBuilder internal func createEqualImageView() -> some View {
        Image(systemName: "equal")
            .resizable()
            .frame(width: 32, height: 24)
    }
    
    /// Creates the button's background
    /// - Returns BackgroundView
    @ViewBuilder internal func createBackground() -> some View {
        switch model {
            case .clear, .allClear: Color.gray.opacity(0.20)
            case .algorithm, .result: Color.orange
            case .salt, .randomSalt, .customSalt, .pepper, .customPepper, .randomPepper: Color.gray
        }
    }
    
}
