//
//  TerminalTextView.swift
//  
//
//  Created by Sérgio Ruediger on 06/04/22.
//

import SwiftUI

/// View that simulates the MacOS terminal, w/o interaction and command parsing
public struct TerminalTextView: View {
    @Binding public var viewModel: TerminalTextViewModel
//    @State private var nextLine: Bool = false
        
    public var body: some View {
        VStack {
            HStack {
                LazyVStack(alignment: .leading, spacing: 4.5) { // Terminal text lines
                    let pageContent = viewModel.content // Lines content
                    let foregroundTask = pageContent.firstIndex(of: "$ ▮")// Appears while viewModel.showEndingText is false
                    let dynamicLines = (foregroundTask != nil && !viewModel.showEndingText ? foregroundTask! + 1 : pageContent.count)
                    
                    ForEach(0..<dynamicLines, id: \.self) { line in
                        if line <= viewModel.linesOnScreen.count {
                            let delimiterIndex = (pageContent[line] == "$ ▮" ? line : nil)
                            TypingTextAnimationView(mode: .terminal, content: pageContent[line], contents: $viewModel.linesOnScreen)
                                .opacity(viewModel.getTaskDelimiterOpacity(of: delimiterIndex))
                        }
                    }
                }
                Spacer()
            } // HStack end
            Spacer()
        } // VStack end
    }
}
