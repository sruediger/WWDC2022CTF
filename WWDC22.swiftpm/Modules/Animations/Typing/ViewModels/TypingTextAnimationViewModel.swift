//
//  TypingTextAnimationViewModel.swift
//  
//
//  Created by Sérgio Ruediger on 09/04/22.
//

import SwiftUI

/// Structure used to control the TypingTextAnimationView
struct TypingTextAnimationViewModel {
    /// Dynamic string that animates the content property
    public var text: String = ""
    /// Text writing animation status
    public var writing: Bool = false
    /// Moving cursor animation status
    public var movingCursor: Bool = false
    /// Blinking cursor animation status
    public var blinkingCursor: Bool = false
    /// Indicates if a line contain the foreground delimiter character ('▮')
    public var isDelimiter: Bool = false
    
}

/// TypingTextAnimationViewModel+Methods
extension TypingTextAnimationViewModel {
    
    /// Fetch the cursor animation offset
    /// - Parameter charCount: Text that's being displayed character count
    /// - Returns CGFloat representing the cursor offset based on the text charCount
    public func getCursorOffset(charCount: Int) -> CGFloat {
        return self.movingCursor ? (75) : -CGFloat(charCount > 11 ? (charCount * 12) : (charCount >= 8 ? (charCount * 10) : (charCount)))
    }
}
