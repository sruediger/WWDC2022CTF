//
//  HashAlgorithms.swift
//  
//
//  Created by Sérgio Ruediger on 10/04/22.
//

import Foundation

/// HashAlgorithms methods declaration. This protocol requires the CryptoKit framework or equivalent to be implemented
public protocol HashAlgorithms {
    
    /** Hashes given data using the SHA256 algorithm
        - Returns: String representation of the hashed input  */
    func getSHA256() -> String

    /** Hashes given data using the SHA384 algorithm
        - Returns: String representation of the hashed input  */
    func getSHA384() -> String
    
    /** Hashes given data using the SHA512 algorithm
        - Returns: String representation of the hashed input  */
    func getSHA512() -> String
    
}
