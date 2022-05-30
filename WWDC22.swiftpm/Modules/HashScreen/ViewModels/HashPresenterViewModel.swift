//
//  File.swift
//  
//
//  Created by Sérgio Ruediger on 09/04/22.
//

import Foundation

/// Structure used to control the HashPresenterView
struct HashPresenterViewModel {
    /// Terminal text controller
    internal var terminalText = TerminalTextViewModel(content: [])
    /// Array<String> that contains the content which will be displayed at the Password screen
    internal let animatedPasswordContent: [String] = ["Password"]
    /// Introduction window current index
    internal var currentIndex: Int = 0 {
        willSet { /// allows closing the firstWindow
            if newValue == 6 { self.introductionFinished = true }
        }
    }
    /// Boolean that shows the 1st (a.k.a introduction) window
    internal var firstWindowPresented: Bool = false {
        willSet {
            if !newValue { self.secondWindowPresented = false }
        }
    }
    /// Boolean that shows the 2nd (a.k.a HashCalculator) window
    internal var secondWindowPresented: Bool = false {
        willSet { self.mainWindowTapped.toggle() }
    }
    /// Boolean that controls both windows zPosition
    internal var mainWindowTapped: Bool = false
    /// Boolean used to proceed to the next scene
    internal var introductionFinished: Bool = false
    /// Introduction window pages amount
    internal let pagesAmount: Int = 6
}

extension HashPresenterViewModel {
    
    /// Initializes the TerminalTextView based on the MiniGame score
    /// - Parameter miniGameScore: The MiniGame score
    internal mutating func initTerminalText(withScore miniGameScore: Int) {
        let scoreLine = (miniGameScore == 0 ? "The server was compromised but it was only a simulation." : "Congratulations, all \(miniGameScore) threats have been mitigated!")
        let questionLine = (miniGameScore == 0 ? "And how about you, are you really safe ?" : "But are you really safe?")
        
        self.terminalText.content = ["Scan successfully completed.", scoreLine, questionLine, "$ \(TerminalContent.hashScript)", "$ ▮", "clear"]
    }
    
    /// Fetch the first the 1st (intro) window title and icon
    /// - Parameter index: Index of the window that called this method
    /// - Returns Tuple of the type (title: String?, imagePath: String?)
    internal func getTitleAndIcon(ofIndex index: Int) -> (title: String?, imagePath: String?) {
        switch index {
            case 0: return ("", "🔐")
            case 1: return (nil, nil) // Doesn't uses any
            case 2: return ("Size Matters", "size")
            case 3: return ("Password Storage", "storage")
            case 4: return ("Hashes", "number")
            case 5: return ("Salt and Pepper", "saltnpepper")
            case 6: return ("Let's see how it works ?", "questionmark.circle")
            default: return (nil, nil)
        }
    }
    
    /// Fetch an emoji from a data source
    /// - Parameter source: Data source of the emoji
    /// - Parameter isFirst: Boolean that indicates if the emoji is the front one
    /// - Returns String representing the emoji
    internal func getEmoji(from source: String, isFirst: Bool) -> String {
        if isFirst {
            return (source == "size" ? "📏" : (source == "storage" ? "💾" : "🌶"))
        }else {
            return (source == "size" ? "⌚️" : (source == "storage" ? "☁️" : "🧂"))
        }
    }
    
    /// Fetch the the 1st (intro) window font size
    /// - Parameter index: Index of the window that called this method
    /// - Parameter footnote: Boolean indicating if the text it's a footnote
    /// - Returns Double corresponding to the Font Size
    internal func getFontSize(ofIndex index: Int, footnote: Bool = false) -> Double {
        guard index >= 0 && index <= 6 else { return 0 }
        let footnoteFontSize: Double = 18
        let bodyFontSize: Double = (index == 0 ? 32 : (index == 2 ? 22 : 24))
        return footnote ? footnoteFontSize : bodyFontSize
    }
    
    /// Fetch the 1st (intro) window content, composed by a body and info
    /// - Parameter index: Index of the window that called this method
    /// - Returns Tuple of the type (body: String, info: String?)
    internal func getFirstWindowContent(fromIndex index: Int) -> (body: String, info: String?) {
        switch index {
            case 0: return ("What are passwords and why it’s important to have strong ones ?", nil)
            case 1: return ("Passwords are combinations of characters, usually alphanumeric, used to protect access to something from unauthorized people by confirming their identity through the chosen password.", nil)
            case 2: return ("The time taken to crack a password is directly proportional to its size and complexity.", "Without any measures against brute force attacks, alphanumeric passwords containing up to 6 characters can be cracked instantly, while another password with twice that length and special characters exponentially increases the time needed to crack it by years.")
            case 3: return ("The most effective ways to store passwords securely are based on hash algorithms because they are irreversible and generate a unique value of fixed size for any type of data or password.\n\nPasswords stored this way make them useless to an attacker if he manages to compromise the database.", nil)
            case 4: return ("Besides being used as a basis for storing passwords securely, hash values are also used as a checksum to validate the integrity of files and even in digital signatures.", "Although they are irreversible, some hash functions are not the best choice for storing passwords because they are calculated too fast, which can facilitate hash cracking attacks like rainbow table, lookup, reverse lookup tables and others, especially if the password is easy.")
            case 5: return ("Salts and peppers are an extra layer of security that ensure that each hash value will be unique, even if the passwords are the same. Both are randomly generated and the main difference between them is that the salt is stored along with the password hash unlike the pepper, which is kept secret.", nil)
            case 6: return ("Close this window when you finish to proceed.", "This calculator uses the algorithms from the Secure Hash Algorithm 2 (SHA-2) family, designed by the US National Security Agency (NSA) in collaboration with the National Institute of Science and Technology (NIST). The CryptoKit framework contains the implementation of these algorithms for Apple platforms and is available from iOS and iPadOS 13, macOS 10.15, tvOS 15 or WatchOS 8.")
            default: return ("", nil)
        }
    }
}
