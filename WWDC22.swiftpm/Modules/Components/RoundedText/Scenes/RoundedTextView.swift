//
//  RoundedTextView.swift
//  
//
//  Created by Sérgio Ruediger on 08/04/22.
//

import SwiftUI

/// SwiftUI Text abstraction that creates an Rounded Text View with custom content, size and weight
struct RoundedText: View {
    /// The text that will be displayed
    let content: String
    /// Size of the text
    let size: CGFloat
    /// Text's font weight
    let weight: Font.Weight
    
    var body: some View {
        Text(content)
            .font(.system(size: size, weight: weight, design: .rounded))
    }
}
