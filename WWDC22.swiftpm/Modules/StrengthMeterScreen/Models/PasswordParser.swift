//
//  PasswordParser.swift
//  
//
//  Created by Sérgio Ruediger on 11/04/22.
//

import Foundation

/// Parser used by PasswordStrengthMeterViewModel that parses the user input as a password and calculates the estimated time to crack it
struct PasswordParser {
    /// Users' plaintext password (userInput)
    internal var password: String = "" {
        willSet {
            self.entropy = 0
            self.poolSize = 0
            self.secondsToCrack = 0
            self.parse(password: newValue)
        }
    }
    /// Amount of guesses per second that a cracker can perform
    internal var guessesPerSecond: UInt64 = 100000000000000/2 {
        didSet { self.calculateEntropy() }
    }
    /// Password charset pool size (possible combinations per character)
    private(set) var poolSize: Int = 0 {
        didSet { self.calculateEntropy() }
    }
    /// Password entropy in bits
    private(set) var entropy: Double = 0 {
        didSet { self.calculateEstimatedTimeToCrack() }
    }
    /// Estimated time to crack in seconds
    private(set) var secondsToCrack: Double = 0 {
        willSet {
            #if DEBUG
                print("""
                Input: \(password) (\(password.count) characters)
                PoolSize: \(poolSize)
                Entropy: \(entropy)
                Est. Time to crack: \(newValue) seconds
                """)
            #endif
        }
    }
}
    
/// PasswordParser+Methods
extension PasswordParser {
    
    /// Calculates the estimated time to brute force an password hash based on its entropy and the attacker computer power (guesses per second)
    private mutating func calculateEstimatedTimeToCrack() {
        /// Formula: Time = (2 ^ entropy) / guessesPerSecond
        self.secondsToCrack = Double(pow(2, entropy)) / Double(guessesPerSecond)
    }
    
    /// Calculates the password entropy (predictability) in bits
    private mutating func calculateEntropy() {
        /// Formula: Entropy = log2(symbolPool ^ passwordLength)
        self.entropy = log2(pow(Double(self.poolSize), Double(self.password.count)))
    }
    
    /// Main parser method that parses the password and sets its poolSize
    /// - Parameter password: The password that will be parsed
    private mutating func parse(password: String) {
        var category: [PasswordCategory] = []
        var charsetPoolSize = 0
                
        let verifyPasswordContents = {() in
            if Validator.passwordContains(digits: password) {
                charsetPoolSize += 10 /// charset range: [0-9]
                category.append(.numeric)
            }
            if Validator.passwordContains(lowercaseCharacters: password) {
                charsetPoolSize += 26 /// charset range: [a-Z]
                category.append(.lowercase)
            }
            if Validator.passwordContains(uppercaseCharacters: password) {
                charsetPoolSize += 26 /// charset range: [A-Z]
                category.append(.uppercase)
            }
            if Validator.passwordContains(specialCharacters: password) {
                charsetPoolSize += 32 /// charset range: [`~!@#$%^&*()-=_+[{]}\|;':",.<>/?]
                category.append(.specialCharacters)
            }
        }
        
        verifyPasswordContents()
        self.poolSize = charsetPoolSize
    }
}

/// PasswordParser+AssociatedTypes
extension PasswordParser {
    
    /// AssociatedType that implements the PasswordValidator protocol
    private struct Validator: PasswordValidator {
        /// Check if the parameter contains any lowercase letters.
        /// - Parameter digits: The userInput that may or not contains digits
        /// - Returns true if the input contains one or more digits
        static func passwordContains(digits: String) -> Bool {
            return digits.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil ? true : false
        }
        
        /// Check if the parameter contains any lowercase letters.
        /// - Parameter lowercaseCharacters: The userInput that may or not contains lowercase letters
        /// - Returns true if the input contains one or more lowercase letters
        static func passwordContains(lowercaseCharacters: String) -> Bool {
            return lowercaseCharacters.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil ? true : false
        }
        
        /// Check if the parameter contains any uppercase letters.
        /// - Parameter uppercaseCharacters: The userInput that may or not contains uppercase letters
        /// - Returns true if the input contains one or more uppercase letters
        static func passwordContains(uppercaseCharacters: String) -> Bool {
            return uppercaseCharacters.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil ? true : false
        }
        
        /// Check if the parameter contains any special characters.
        /// - Parameter specialCharacters: The userInput that may or not contains special characters
        /// - Returns true if the input contains one or more special characters
        static func passwordContains(specialCharacters: String) -> Bool {
            let initCharset = {(charsets: CharacterSet...) -> CharacterSet in
                var sets = CharacterSet()
                charsets.forEach { sets.formUnion($0) }
                return sets
            }, charset = initCharset(.symbols, .whitespaces, .nonBaseCharacters, .punctuationCharacters)
            return specialCharacters.rangeOfCharacter(from: charset) != nil ? true : false
        }
    }
    
    /// Enumeration that categorizes passwords based on the charset complexity
    @frozen private enum PasswordCategory: String {
        case unset, // Empty input (shouldn't happen)
             numeric, // eg: 0123456
             lowercase, // eg: password
             uppercase, // eg: PASSWORD
             alphanumeric, // eg: Password123
             specialCharacters // eg: {_P4sSw0rd_}
    }
}
