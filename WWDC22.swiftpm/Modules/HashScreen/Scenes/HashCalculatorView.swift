//
//  HashCalculatorView.swift
//  
//
//  Created by Sérgio Ruediger on 07/04/22.
//

import SwiftUI

/// Simple Hash Calculator based on the iOS/MacOS Calculator App
struct HashCalculatorView: View {
    @State private var viewModel: HashCalculatorViewModel = .init()
    
    var body: some View {
        VStack {
            // Time complexity O(n). There are several solutions with fewer lines (of the extension methods below) but they increase the time complexity considerably
            self.createUserInputSubview()
            Spacer()
            self.createCalculatorButtonsSubview()
        }
    }
}

extension HashCalculatorView {
    
    /// Creates the calculator's User Input Subview
    /// - Returns UserInputSubview
    @ViewBuilder private func createUserInputSubview() -> some View {
        if viewModel.output.isEmpty {
            TextEditorView(placeholder: "Type something here", text: $viewModel.userInput)
                .padding(EdgeInsets(top: 30, leading: 15, bottom: 0, trailing: 15))
        }else {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()
                    Text(viewModel.userInput)
                        .bold()
                        .font(.title3)
                    
                    ScrollView(.vertical) {
                        Text(String("\(viewModel.output)"))
                            .font(.title2)
                            .multilineTextAlignment(.center)
                    }
                }.foregroundColor(.white).padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
            //    Spacer()
            }
        }
    }
    
    /// Creates all calculator's buttons
    /// - Returns CalculatorButtonsSubview
    @ViewBuilder private func createCalculatorButtonsSubview() -> some View {
        HStack(spacing: 2) {
            let buttonHeight: CGFloat = UIScreen.main.bounds.width * 0.17
            ForEach(0..<2) { column in
                VStack(spacing: 1) {
                    if column == 0 {
                        Group {
                            HashCalculatorButtonView(model: viewModel.userInput.isEmpty ? .allClear : .clear, viewModel: $viewModel)
                            
                            HashCalculatorButtonView(model: .randomSalt, viewModel: $viewModel)

                            HashCalculatorButtonView(model: .randomPepper, viewModel: $viewModel)
                            /*
                            if !viewModel.isSaltEnabled {
                                HashCalculatorButtonView(model: .salt, viewModel: $viewModel)
                            }else {
                                HStack(spacing: 2) {
                                    HashCalculatorButtonView(model: .customSalt, viewModel: $viewModel)
                                    
                                    HashCalculatorButtonView(model: .randomSalt, viewModel: $viewModel)
                                }
                            }
                            if !viewModel.isPepperEnabled {
                                HashCalculatorButtonView(model: .pepper, viewModel: $viewModel)
                            }else {
                                HStack(spacing: 2) {
                                    HashCalculatorButtonView(model: .customPepper, viewModel: $viewModel)
                                    
                                    HashCalculatorButtonView(model: .randomPepper, viewModel: $viewModel)
                                }
                            }*/
                        }.frame(height: buttonHeight)
                    }else {
                        Group {
                            HashCalculatorButtonView(model: .algorithm, viewModel: $viewModel)
                                .frame(height: buttonHeight)
                            
                            HashCalculatorButtonView(model: .result, viewModel: $viewModel)
                                .frame(height: buttonHeight * 2)
                        }
                    }
                }.cornerRadius(10)//.ignoresSafeArea() // End VStack
            }
        }
    }
}
