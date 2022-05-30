//
//  MiniGameViewModel+Methods.swift
//  
//
//  Created by Sérgio Ruediger on 21/04/22.
//

import CoreGraphics

/// MiniGameViewModel+Methods
extension MiniGameViewModel {

    /// Fetch all MacOSWindow texts of a specific screen; this solution is currently the best only for the introduction (because the others have less text which is easier to call directly with less lines)
    /// - Parameter window: Desired MiniGameScreen to get the text
    /// - Returns the chosen window text content, represent by an Array<String>
    internal func getText(of window: MiniGameScreen) -> [String] {
        switch window {
            case .introWindow: return ["Real Threats", "In this challenge you must protect the pillars of information security, preventing threats from reaching them by tapping these threats.", "Can you eliminate them all without getting hit ?", "Close this window to start."]
            default: return []
        }
    }
    
    /// MiniGame MacOSWindow sizes getter
    /// - Returns CGSize corresponding to the specific MacOSWindow
    internal func getWindowSize() -> CGSize {
        if self.levelStarted {
            if self.gameOver {
                return CGSize(width: 640, height: 576) // Game over
            }else if self.maxScoreReached {
                return CGSize(width: 416, height: 288) // Level passed
            }
        }
        return CGSize(width: 560, height: 384) // Level intro
    }

    /// Resets all Input & Output variables
    internal mutating func resetIO() {
        self.score = 0
        self.gameOver = false
        self.infection = nil
        self.playAgain = false
        self.levelStarted = false
        self.securityPillars.indices.forEach { securityPillars[$0].isInfected = false }
    }
}
