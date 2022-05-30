//
//  TerminalTextViewModel.swift
//  
//
//  Created by Sérgio Ruediger on 06/04/22.
//

import Foundation

/// Structure used to control the TerminalTextView
public struct TerminalTextViewModel {
    /// Array<String> that receives the raw content to be displayed
    public var content: [String]
    /// Currently shown lines as an Array<String>
    public var linesOnScreen: [String] = []
    /// Boolean used to show the remaining content after the task delimiter
    public var showEndingText: Bool = false
}


/// TerminalTextViewModel+Methods
extension TerminalTextViewModel {
    
    /// Fetch the task delimiter opacity
    /// - Parameter index: Optional<Int> that indicates the delimiter index
    /// - Returns Double corresponding to the opacity
    public func getTaskDelimiterOpacity(of index: Int?) -> Double {
        return index == nil ? 1 : (self.showEndingText ? 0 : 1)
    }
    
}
