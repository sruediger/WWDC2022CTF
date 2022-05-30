//
//  PasswordStrengthMeter.swift
//  
//
//  Created by Sérgio Ruediger on 21/04/22.
//

import SwiftUI

/// The Password Strength Meter controller that declares the viewModel properties and methods
internal protocol PasswordStrengthMeter {
    /// The user password
    var userInput: String { get set }
    
    /// Mirror of the this object passwordHandler.guessesPerSecond property
    var guessesPerSecondMirror: Double { get set }
     
    /// Terminal text controller
    var terminalText: TerminalTextViewModel { get set }
    
    /// Fetch the attacker's guesses per second in a more convenient format
    /// - Returns String containing the attacker's guesses per second
    func getFormattedGuessesPerSecond() -> String
    
    /// Present or hide the info window
    mutating func toggleInfoWindow()
    
    /// Get the color of the estimated time to crack a password
    func getEstimatedTimeColor() -> Color
    
    /// Updates the output
    mutating func updateOutput()
}
