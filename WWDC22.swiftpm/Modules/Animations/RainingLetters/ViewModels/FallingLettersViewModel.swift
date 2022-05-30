//
//  FallingLettersViewModel.swift
//  
//
//  Created by Sérgio Ruediger on 11/04/22.
//

import SwiftUI

/// Structure used to control the LetterRainView
struct FallingLettersViewModel {
    /// The charset source of the letters that appear on the FallingLettersView
    internal let charset = "0123456789abcdefghijklmnoprstuvwxyz"
    /// Boolean that indicates if the animation has started or not
    public var startAnimation: Bool = false
    /// Random number used during the animation iterations. Initialized at FallingLettersView .onReceive modifier located at the body var
    public var random: Int = 0
    
    /*
    /// Computed property that calculates all gradient colors used on the animation (- MARK: inProgress)
    internal var gradientColors: [Color] {
        var colors: [Color] = [.clear]
        
        for opacity in 1...7 { colors.append(.black.opacity(Double(opacity / 10))) }
        
        colors.append(.black)
        
        return colors
    }*/
    
    /// Fetch the gradient colors used on the animation
    /// - Returns Array<Color>
    internal func getGradientColors() -> [Color] {
        // Unfortunately for some reason the computed property containing this method implementation using forEach/forIn doesn't returns the same result
        return [.clear, .black.opacity(0.1), .black.opacity(0.2), .black.opacity(0.3), .black.opacity(0.4), .black.opacity(0.5), .black.opacity(0.6), .black.opacity(0.7), .black]
    }
    
    /// Fetch a random letter index from the FallingLettersView
    /// - Parameter index: The index of the letter that called this method
    /// - Returns Int representing a valid random index
    internal func getRandomIndex(index: Int) -> Int {
        let max = self.charset.count - 1
        if (index + self.random) > max {
            if (index - self.random) < 0 { return index }
            return (index - self.random)
        }else { return (index + self.random) }
    }
}
