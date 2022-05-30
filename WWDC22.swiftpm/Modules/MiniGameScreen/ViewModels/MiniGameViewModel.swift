//
//  MiniGameViewModel.swift
//  
//
//  Created by Sérgio Ruediger on 07/04/22.
//
import CoreGraphics
import UIKit.UIScreen

/// MiniGame controller
public struct MiniGameViewModel: MiniGameController {
    /// The player score
    internal var score: Int = 0
    /// The game status
    internal var gameOver: Bool = false
    /// Boolean used to dismiss the intro and start the game
    internal var levelStarted: Bool = false
    /// Highest reachable score
    internal let maxScore = Int.random(in: 28..<64)
    /// Security pillars infection status, non-nil when the game is over
    internal var infection: ThreatViewModel? = nil
    /// Boolean used to restart the MiniGame
    internal var playAgain: Bool = false {
        willSet {
            if newValue { self.resetIO() }
        }
    }
    /// The falling threats
    internal var threats: [ThreatViewModel] = [ .init(.malwares), .init(.vulnerabilities), .init(.socialEngineering)]
        
    /// Information security pillars (aka defenses)
    internal var securityPillars: [DefenseViewModel] = [.init(.confidenciality), .init(.integrity), .init(.availability)]
    
    // Computed properties
    
    /// Check if the max score was reached
    internal var maxScoreReached: Bool { self.score >= self.maxScore }
    /// Check if the game is in progress
    internal var isGameInProgress: Bool { !self.gameOver && !self.maxScoreReached }
}
