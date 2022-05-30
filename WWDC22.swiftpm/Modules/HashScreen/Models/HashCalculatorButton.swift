//
//  HashCalculatorButton.swift
//  
//
//  Created by Sérgio Ruediger on 10/04/22.
//

import Foundation

/// Enumeration containing all HashCalculatorView buttons
@frozen internal enum HashCalculatorButton: String, CaseIterable, Identifiable, CustomStringConvertible {
    case allClear, clear, algorithm, salt, customSalt, randomSalt, pepper, customPepper, randomPepper, result
    
    /// Object's identifier that also conforms this type to the Identifiable protocol
    public var id: String { self.rawValue }
    
    /// Object's description that conforms this type to the CustomStringConvertible protocol
    public var description: String {
        switch self {
            case .allClear: return "AC" // AllClear (empty input)
            case .clear: return "C" // AllClear (empty input)
            case .algorithm: return "Algorithm"
            case .salt: return "Salt"
            case .customSalt: return "Custom\nSalt"
            case .randomSalt: return "Random\nSalt"
            case .pepper: return "Pepper"
            case .customPepper: return "Custom\nPepper"
            case .randomPepper: return "Random\nPepper"
            case .result: return "="
        }
    }
}
