//
//  HashAlgorithm.swift
//  
//
//  Created by Sérgio Ruediger on 10/04/22.
//

import Foundation

/// Enumeration containing all available HashAlgorithms from the CryptoKit framework
@frozen internal enum HashAlgorithm: String, CustomStringConvertible, CaseIterable {
    case SHA256, SHA384, SHA512
    
    /// Object's description 
    internal var description: String {
        switch self {
            case .SHA256: return "SHA-256"
            case .SHA384: return "SHA-384"
            case .SHA512: return "SHA-512"
        }
    }
}
