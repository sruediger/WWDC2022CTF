//
//  IntroductionViewModel.swift
//  
//
//  Created by Sérgio Ruediger on 06/04/22.
//

import Foundation

/// Structure used to control the Introduction View
struct IntroductionViewModel {
    /// Terminal text controller
    public var terminalText = TerminalTextViewModel(content: IntroductionModel.terminalTextContent)

    /// Boolean to temporary disable the DynamicGreeterView animation when the window is dragged
    public var firstWindowDragged: Bool = false
    
    /// Boolean that controls the 1st window presentation
    public var firstWindowPresented: Bool = false
    
    /// Boolean that controls the 2nd window presentation
    public var secondWindowPresented: Bool = false {
        willSet {
            if newValue { self.mainWindowTapped = false }
        }
    }
    
    /// Boolean that controls both windows zPosition
    internal var mainWindowTapped: Bool = false
    
    /// Toggles the visibility of specific window(s)
    /// - Parameter firstWindow: Optional Bool that toggles the 1st window
    /// - Parameter secondWindow: Optional Bool that toggles the 2nd window
    public mutating func toggleVisibilityOf(firstWindow: Bool? = nil, secondWindow: Bool? = nil) {
        if firstWindow != nil { self.firstWindowPresented.toggle() }
        if secondWindow != nil { self.secondWindowPresented.toggle() }
    }
    
}
