//
//  File.swift
//  WWDC22
//
//  Created by Sérgio Ruediger on 29/03/22.
//

import SwiftUI

/// TextField abstraction that allows customization and adds a placeholder
struct TextEditorView: View {
    /// Placeholder text that appears when the userInput is empty
    let placeholder: String
    /// Main text that contains the userInput
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Group {
                if text.isEmpty  {
                    Text(placeholder)
                        .foregroundColor(Color.white.opacity(0.45))//.primary.opacity(0.45))
                        .padding(EdgeInsets(top: 4, leading: 4, bottom: 0, trailing: 0))
                }
                TextField("", text: $text)
                    .foregroundColor(Color.white.opacity(0.45))//.primary)
            }.font(.title).padding(5)
        }.onAppear {
            UITextView.appearance().backgroundColor = .clear
        }.onDisappear {
            UITextView.appearance().backgroundColor = nil
        }.frame(height: 55)
        .font(.body)
        .background(Color.clear)//.gray.opacity(0.15))
        .opacity(0.8)
        .accentColor(.green)
        .cornerRadius(8)
        .padding(.top)
        .shadow(radius: 1)
    }
}
