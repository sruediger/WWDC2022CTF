//
//  PasswordValidator.swift
//  
//
//  Created by Sérgio Ruediger on 11/04/22.
//

import Foundation

/// Password Strength Meter methods declaration
internal protocol PasswordValidator {
    
    /// Check if the parameter contains any lowercase letters.
    /// - Parameter digits: The userInput that may or not contains digits
    /// - Returns true if the input contains one or more digits
    static func passwordContains(digits: String) -> Bool
    
    /// Check if the parameter contains any lowercase letters.
    /// - Parameter lowercaseCharacters: The userInput that may or not contains lowercase letters
    /// - Returns true if the input contains one or more lowercase letters
    static func passwordContains(lowercaseCharacters: String) -> Bool
    
    /// Check if the parameter contains any uppercase letters.
    /// - Parameter uppercaseCharacters: The userInput that may or not contains uppercase letters
    /// - Returns true if the input contains one or more uppercase letters
    static func passwordContains(uppercaseCharacters: String) -> Bool
    
    /// Check if the parameter contains any special characters.
    /// - Parameter specialCharacters: The userInput that may or not contains special characters
    /// - Returns true if the input contains one or more special characters
    static func passwordContains(specialCharacters: String) -> Bool
}
