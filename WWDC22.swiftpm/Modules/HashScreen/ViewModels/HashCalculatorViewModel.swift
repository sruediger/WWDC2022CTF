//
//  HashCalculatorViewModel.swift
//  WWDC22
//
//  Created by Sérgio Ruediger on 18/03/22.
//

import SwiftUI

/// Structure used to control the HashCalculatorView
struct HashCalculatorViewModel {
    /// Modified userInput used to compute the output
    private var processedInput: String = ""
    /// Textual input entered by the user
    internal var userInput: String = ""
//    internal var customSauce: String = ""
    /// The hash representation of the ProcessedInput
    private(set) var output: String = ""
    /// Boolean that indicates if a random salt is being used
    private(set) var isSaltEnabled: Bool = false
    /// Boolean that indicates if a random pepper is being used
    private(set) var isPepperEnabled: Bool = false
    /// The currently chosen hash algorithm
    internal var chosenAlgorithm: HashAlgorithm = .SHA256
}

/// HashCalculatorViewModel+Methods
extension HashCalculatorViewModel {
    
    /// HashCalculatorViewModel's main method that performs the action of a button and updates the Input & Output
    /// - Parameter model: HashCalculatorButton object used to determine the action that will be performed
    internal mutating func performAction(of model: HashCalculatorButton) {
        withAnimation(.easeIn(duration: 1.5)) {
            switch model {
                case .allClear, .clear: purgeIO()
                case .algorithm: break
                case .salt: isSaltEnabled.toggle()
                case .customSalt: break
                case .randomSalt: self.addSalt()
                case .pepper: isPepperEnabled.toggle()
                case .customPepper: break
                case .randomPepper: self.addPepper()
                case .result: updateOutput()
            }
        }
    }
    
    /// Adds a pepper to the userInput before calculating its hash
    /// - Parameter randomly: Boolean that indicates if the pepper is generated randomly
    /// - Parameter custom: Optional<String> that allows the user to enter a custom pepper
    private mutating func addPepper(randomly: Bool = true, custom: String? = nil) {
        if randomly && custom == nil {
            if !self.output.isEmpty { self.purgeIO() }
            self.userInput.append(contentsOf: UUID().uuidString.components(separatedBy: "-")[0])
        }else { /* Do nothing */ }
    }
    
    /// Adds a salt to the userInput before calculating its hash
    /// - Parameter randomly: Boolean that indicates if the salt is generated randomly
    /// - Parameter custom: Optional<String> that allows the user to enter a custom salt
    private mutating func addSalt(randomly: Bool = true, custom: String? = nil) {
        if randomly && custom == nil {
            if !self.output.isEmpty { self.purgeIO() }
            self.userInput.append(contentsOf: UUID().uuidString.components(separatedBy: "-")[0])
        }else { /* Do nothing */ }
    }
    
    /// Updates the output
    private mutating func updateOutput() {
        guard !self.userInput.isEmpty else { return }
        self.processedInput = calculateHash(of: userInput, with: chosenAlgorithm)
        self.output = self.processedInput
    }
    
    /// Purge all Input & Output variables
    private mutating func purgeIO() {
        self.processedInput = ""
        self.userInput = ""
        self.output = ""
    }
    
    /// Calculates the digest (output) of an text entered by the user using a specific hash algorithm
    /// - Parameter input: Text entered by the user that will be hashed
    /// - Parameter algorithm: Chosen algorithm to calculate the digest (output)
    /// - Returns String containing the hash representation of the input
    private func calculateHash(of input: String, with algorithm: HashAlgorithm) -> String {
        switch algorithm {
            case .SHA256: return input.getSHA256()
            case .SHA384: return input.getSHA384()
            case .SHA512: return input.getSHA512()
        }
    }
}
