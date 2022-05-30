//
//  PasswordStrengthMeterView+Builders.swift
//  
//
//  Created by Sérgio Ruediger on 19/04/22.
//

import SwiftUI

/// PasswordStrengthMeterView+ViewBuilders
extension PasswordStrengthMeterView {
    
    /// Creates an MacOSWindow instance
    /// - Parameter iBreaker: Boolean that represents the Password Strength Meter window
    /// - Returns MacOSWindow View
    @ViewBuilder internal func createMacOSWindow(iBreaker: Bool = true) -> some View {
        let windowSize: CGSize = .init(width: UIScreen.main.bounds.width * (!viewModel.isLargeiPad ? 0.6 : 0.5), height: viewModel.getHeight(of: iBreaker))

        MacOSWindowView(dimensions: CGSize(width: windowSize.width, height: windowSize.height)) {
            if iBreaker {
                self.createMainSubview(windowSize: windowSize)
                    .onTapGesture {
                        viewModel.mainWindowTapped = true
                    }
            } else {
                self.createInfoSubview(contentWidth: windowSize.width - 64)
                    .onTapGesture {
                        viewModel.mainWindowTapped = false
                    }
            }
        } onDismiss: {
            if iBreaker { viewModel.terminalText.showEndingText = true }
            guard viewModel.presentInfoWindow else { return }
            viewModel.toggleInfoWindow()
        }.onTapGesture { viewModel.mainWindowTapped.toggle() }
    }
    
    /// Creates the 1st window (iBreaker / Password Strength Meter) View
    /// - Parameter windowSize: CGSize containing the width and height of the window
    /// - Returns MainWindowSubview
    @ViewBuilder private func createMainSubview(windowSize: CGSize) -> some View {
        ZStack {
            Rectangle()
                .cornerRadius(24)
                .foregroundColor(Color("Colors/customBlack").opacity(0.75))
            
            VStack(alignment: .center, spacing: 15) {
            //    Spacer()
                self.createTitleView()
                self.createPasswordInputView(size: windowSize)
                self.createEstimatedTimeView(textWidth: windowSize.width - 136)
                Spacer()
            }
        }.frame(width: windowSize.width / 1.15, height: windowSize.height / 1.2)
    }
    
    /// Creates the 2nd window (Info) Subview
    /// - Parameter textWidth: CGFloat representing the content (window subview) width
    /// - Returns InfoSubview
    @ViewBuilder private func createInfoSubview(contentWidth: CGFloat) -> some View {
        ScrollView(.vertical) {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: "questionmark.circle")
                    .resizable()
                    .frame(width: 64, height: 64)
                
                Text("How passwords are cracked ?").font(.title).bold()
                                            
                VStack(alignment: .leading, spacing: 10) {
                    Text("The **estimated time** to **crack an password** is **directly proportional** to **its size and complexity** because they form its **entropy**, which represents the **predictability** and consists of a logarithmic operation of the **pool size** (**possible combinations per character**) raised to the power of the **password length**.")
                                    
                    Text("The **formula** for **estimating the time required to crack a password** via **brute-force attacks** is **2 raised to the power of entropy divided by the attacker's computing power**, **measured in guesses per second**.")
                    
                    + Text(" Change the slider below to get different estimates!").bold()
                }.font(.callout).padding(.bottom, 10)
                
                Group {
                    Text("Attacker guesses per second: \(viewModel.getFormattedGuessesPerSecond()).")
                        .bold()
                        .font(.callout)
                    
                    Slider(value: $viewModel.guessesPerSecondMirror, in: 1000000000...100000000000000)
                }
                
                Text("**Note:** These **estimates** refers to **brute-force attacks** and even if a **password** is **relatively secure**, this time can be **drastically reduced** through **dictionary-based attacks**, **lookup tables** or **rainbow tables**, that's why is **important** to have **complex passwords without personal information** to also **mitigate social engineering attacks**.")
                    .font(.footnote).padding(.top, 10)
            }.foregroundColor(.white)
        }.frame(width: contentWidth)
    }
}

/// PasswordStrengthMeterView+ComponentBuilders
extension PasswordStrengthMeterView {
    
    /// Creates the 1st window (iBreaker / Password Strength Meter) TitleView
    /// - Parameter textWidth: CGFloat representing the text width
    /// - Returns TitleView
    @ViewBuilder private func createTitleView() -> some View {
        VStack(alignment: .center, spacing: 0) {
            HStack(spacing: 5) {
                
                Image("Icons/iBreaker")
                    .resizable()
                    .frame(width: 192, height: 56)
                    .foregroundColor(.white)
            }.padding(.top, 48)
                
            RoundedText(content: "Password Strength Meter", size: 28, weight: .bold)
        }.foregroundColor(.white)
    }

    /// Creates the 1st window (iBreaker / Password Strength Meter) PasswordInputView
    /// - Parameter windowSize: CGSize containing the width and height of the parent window
    /// - Returns PasswordInputView
    @ViewBuilder private func createPasswordInputView(size: CGSize) -> some View {
        let color = Color.black.opacity(0.28)
        Rectangle()
            .cornerRadius(12)
            .foregroundColor(color)
            .frame(width: size.width - 128, height: size.height / 8)
            .overlay(
                SecureTextField(text: $viewModel.userInput)
                    .frame(width: size.width - 160)
            ).onChange(of: viewModel.userInput) { _ in
                withAnimation { viewModel.updateOutput() }
            }
    }
    
    /// Creates the 1st window (iBreaker / Password Strength Meter) EstimatedTimeView
    /// - Parameter textWidth: CGFloat representing the text width
    /// - Returns EstimatedTimeToCrackView
    @ViewBuilder private func createEstimatedTimeView(textWidth: CGFloat) -> some View {
        Group {
            if viewModel.userInput.isEmpty {
                Text("Type a password above to see it's strength")
                    .bold()
                    .font(.subheadline)
                    .foregroundColor(.white)
            }else {
                VStack(alignment: .center, spacing: 10) {
                    Group {
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 64, height: 64)
                        
                        RoundedText(content: "\(viewModel.output)", size: 22, weight: .semibold)
                    }.foregroundColor(viewModel.getEstimatedTimeColor())
                    Group {
                        Text("Estimated time to crack with brute-force")
                            .bold()
                            .font(.headline)
                            .multilineTextAlignment(.center)
                        Group {
                            if viewModel.userInput.count <= 6 {
                                Text("**Tip:** **Passwords** with **less than 7 characters** can be **cracked** almost **instantly**.")
                            }else {
                                Text("How are these estimates calculated ?")

                                Button {
                                    self.viewModel.toggleInfoWindow()
                                } label: {
                                    Text("Tap here to learn more about.")
                                        .bold()
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }.font(.callout).multilineTextAlignment(.center)
                    }.foregroundColor(.white)
                }
            }
        }
        .frame(width: textWidth)
        .transition(.opacity.animation(.easeInOut(duration: 0.25)))
    }
    
}
