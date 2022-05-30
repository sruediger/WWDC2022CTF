//
//  TypingTextAnimationView.swift
//  
//
//  Created by Sérgio Ruediger on 09/04/22.
//

import SwiftUI

/// View that creates a single or multiline animated text, for terminal (TTY) and Graphical User Interface (GUI) mode
struct TypingTextAnimationView: View {
    /// Type of the animation
    public let mode: TypingAnimationMode
    /// The full raw content unanimated, source of the viewModel text property
    public let content: String
    /// Parent contents used to control line changing
    @Binding public var contents: [String]
    @State internal var viewModel = TypingTextAnimationViewModel()
    
    var body: some View {
        self.createTextView().onAppear {
            // Text writing animation
            withAnimation(.easeOut(duration: mode == .terminal ? 2 : 1).delay(mode == .terminal ? 0 : 1).repeatForever(autoreverses: true)) {
                viewModel.writing.toggle()
                viewModel.movingCursor.toggle()
            }
            
            // Cursor Blinking Animation
            withAnimation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                viewModel.blinkingCursor.toggle()
            }
        }
    }
    
    /// AssociatedType used to determine the animation mode
    @frozen internal enum TypingAnimationMode {
        case terminal, userInterface
    }
}

/// TypingTextAnimationView+Builders
extension TypingTextAnimationView {
    
    /// Creates an generic animated TextView
    /// - Returns specific TextView according to the chosen mode
    @ViewBuilder fileprivate func createTextView() -> some View {
        switch self.mode {
            case .terminal: self.createTerminalText()
            case .userInterface: self.createGUIText()
        }
    }

    /// Creates an animated TerminalText
    /// - Returns TerminalText instance
    @ViewBuilder fileprivate func createTerminalText() -> some View {
        let smallText = self.content.count < 20
        HStack(spacing: 0) {
            Text(viewModel.text)
            //    .bold()
                .foregroundColor(.green)
                .font(.headline)
                .multilineTextAlignment(.leading)
                .onChange(of: viewModel.text) { text in
                    if text.count == self.content.count {
                        let lineSize = self.content.count
                        let timeForNextLine = CGFloat(smallText ? Double(lineSize / 5) : (Double(lineSize) * 0.08))
                        DispatchQueue.main.asyncAfter(deadline: .now() + timeForNextLine) {
                            self.contents.append(self.content)
                        }
                    }
                    if text.contains("▮") {
                        guard text.first == "$", let index = text.firstIndex(of: "▮") else { return }
                        viewModel.text.remove(at: index)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            viewModel.isDelimiter = true
                        }
                    }
                }
            
            if viewModel.isDelimiter {
                Text("▮")
                    .font(.title2)
                    .foregroundColor(.green)
                    .padding(.bottom, 4)
            }
            
            if !self.contents.contains(self.content) {
                Text("|")
                    .font(.title2)
                    .foregroundColor(.green)
                    .opacity(viewModel.blinkingCursor ? 0 : 1)
            }
        }.onAppear {
            withAnimation(.easeInOut(duration: 1).delay(0).speed(smallText ? 1 : 0.35)) {
                for char in self.content {
                    viewModel.text.append(contentsOf: String("\(char)"))
                }
            }
        }
    }
    
    /// Creates an animated Graphical User Interface (GUI) Text
    /// - Returns GUI Text
    @ViewBuilder fileprivate func createGUIText() -> some View {
        ZStack(alignment: .center) {
            let charCount = viewModel.text.count
            Text(viewModel.text)
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .mask(Rectangle().offset(x: viewModel.writing ? 0 : -CGFloat(charCount * 30)))
                .onAppear  {
                    viewModel.text = self.contents[0]
                }.onReceive(Timer.publish(every: CGFloat(5.5), on: .current, in: .common).autoconnect()) { _ in
                    withAnimation {
                        if let currentText = contents.firstIndex(of: viewModel.text) {
                            if currentText != contents.count - 1 {
                                viewModel.text = contents[currentText + 1]
                            }else {
                                viewModel.text = contents[0]
                            }
                        }
                    }
                }
            
            Rectangle()
                .fill(.blue)
                .frame(width: 4, height: 30)
                .opacity(viewModel.blinkingCursor ? 0 : 1)
                .offset(x: viewModel.getCursorOffset(charCount: charCount))
        }
    }
}
