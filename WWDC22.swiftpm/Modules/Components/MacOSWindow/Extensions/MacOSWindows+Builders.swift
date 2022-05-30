//
//  MacOSWindows+Builders.swift
//  
//
//
//  Created by Sérgio Ruediger on 05/04/22.
//

import SwiftUI

/// MacOSWindows+Builders
extension MacOSWindowView {
    
    /// Creates the top area subview
    /// - Returns Top Area Subview
    @ViewBuilder internal func createTopAreaSubview() -> some View {
        Group { /// Navigation Bar (leading buttons and draggable area)
            Spacer().frame(height: 25)
            self.createTopLeadingButtons()
            Spacer()
        }
    }
    
    /// Creates the main window content subview
    /// - Returns Window Content View
    @ViewBuilder internal func createContentAreaSubview() -> some View {
        ZStack {
            contentView
            if viewModel.showUnavailableFeatureAlert {
                self.createWarningAlert()
            }
        }
    }
    
    /// Creates the top leading buttons
    /// - Returns Top Leading Buttons view
    @ViewBuilder private func createTopLeadingButtons() -> some View {
        HStack(spacing: 10) {
            Spacer().frame(width: 20)
            ForEach(viewModel.topButtons) { button in
                Button {
                    defer {
                        switch button {
                            case .close: self.onDismiss?()
                            default: break
                        }
                    }
                    self.viewModel.pressedButtonAction(of: button, windowIsClosed: self.isClosed?.wrappedValue ?? false)
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(Color(uiColor: button.getColor()))
                            .frame(width: 18, height: 18)
                    }
                }
            }
            Spacer()
        }
    }
    
    /// Creates an warning alert for unavailable features
    /// - Returns Warning 18776aa07da8890a1f2911fde3a730197aeb5014Alert View
    @ViewBuilder private func createWarningAlert() -> some View {
        VStack {
            Spacer()
            Rectangle()
                .cornerRadius(10)
                .shadow(radius: 10)
                .foregroundColor(.black.opacity(0.65))
                .frame(width: self.dimensions.width / 1.25, height: 100)
                .padding(.bottom, 25)
                .overlay(
                    VStack(alignment: .center, spacing: 5) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .foregroundColor(.red)
                            .frame(width: 20, height: 20)
                        
                        Group {
                            Text("Warning")
                                .bold()
                                .font(.title3)
                            
                            Text("Feature disabled.")
                                .font(.body)
                        }.foregroundColor(.white)
                    }.padding(.bottom, 25)
                ).transition(.opacity.animation(.easeInOut(duration: 1)))
        }.onAppear {
            Snippets.runAfter(timeInSeconds: 4) {
                self.viewModel.hideUnavailableFeatureAlert()
            }
        }.onTapGesture { self.viewModel.hideUnavailableFeatureAlert() }
    }
}
