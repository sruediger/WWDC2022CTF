//
//  String+HashAlgorithms.swift
//  
//
//  Created by Sérgio Ruediger on 10/04/22.
//

import CryptoKit
import Foundation

extension String: HashAlgorithms {
    
    /** Hashes given data using the SHA256 algorithm
        - Returns: String representation of the hashed input  */
    public func getSHA256() -> String {
        return SHA256.hash(data: Data(self.utf8)).compactMap { String(format: "%02x", $0)}.joined()
    }
    
    /** Hashes given data using the SHA384 algorithm
        - Returns: String representation of the hashed input  */
    public func getSHA384() -> String {
        return SHA384.hash(data: Data(self.utf8)).compactMap { String(format: "%02x", $0)}.joined()
    }
    
    /** Hashes given data using the SHA512 algorithm
        - Returns: String representation of the hashed input  */
    public func getSHA512() -> String {
        return SHA512.hash(data: Data(self.utf8)).compactMap { String(format: "%02x", $0)}.joined()
    }
}
