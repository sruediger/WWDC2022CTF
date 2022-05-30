//
//  MiniGame.swift
//  
//
//  Created by Sérgio Ruediger on 21/04/22.
//

import SwiftUI // required by the MiniGameController getItemColor() method
import CoreGraphics // Used by the DefenseController getWindowSize() method and required by the ThreatController currentPosition property

/// The main MiniGame Controller
internal protocol MiniGameController {
    /// The player score
    var score: Int { get set }
    /// The game status
    var gameOver: Bool { get set }
    /// Boolean used to dismiss the intro and start the game
    var levelStarted: Bool { get set }
    /// Highest reachable score
    var maxScore: Int { get }
    /// Security pillars infection status, non-nil when the game is over
    var infection: ThreatViewModel? { get set }
    /// Boolean used to restart the MiniGame
    var playAgain: Bool { get set }
    /// The falling threats
    var threats: [ThreatViewModel] { get set }
    /// Information security pillars (aka defenses)
    var securityPillars: [DefenseViewModel] { get set }
    
    // MiniGameController+Methods
    
    /// Fetch all MacOSWindow texts of a specific screen; this solution is currently the best only for the introduction (because the others have less text which is easier to call directly with less lines)
    /// - Parameter window: Desired MiniGameScreen to get the text
    /// - Returns the chosen window text content, represent by an Array<String>
    func getText(of window: MiniGameScreen) -> [String]
    
    /// MiniGame MacOSWindow sizes getter
    /// - Returns CGSize corresponding to the specific MacOSWindow
    func getWindowSize() -> CGSize
    
    /// Resets all Input & Output variables
    mutating func resetIO()
}

/// MiniGame's Defense Controller methods and properties
internal protocol DefenseController {
    /// Defense item properties
    var properties: InfosecItemModel { get set }
    /// The item infection status
    var isInfected: Bool { get set }
    
    /// DefenseController (viewModel) default initializer
    init(_ type: DefenseType)
    
    // DefenseController+Methods
    
    /// Get the item color based on it's infection status
    /// - Returns Color instance
    func getItemColor() -> Color
    
    // DefenseController+AssociatedTypes
    
    /// Enumeration that represents the information security pillars (aka defense items)
    associatedtype DefenseType : RawRepresentable where DefenseType.RawValue : StringProtocol
}

/// MiniGame's Threat Controller methods and properties
internal protocol ThreatController {
    /// Threat item properties
    var properties: InfosecItemModel { get set }
    /// Selection (tap) status
    var isSelected: Bool { get set }
    /// Dynamic falling position
    var currentPosition: CGSize { get set }
    
    /// ThreatController (viewModel) default initializer
    init(_ type: ThreatType)
    
    // ThreatController+AssociatedTypes
    
    /// Enumeration that represents this challenge threats
    associatedtype ThreatType : RawRepresentable where ThreatType.RawValue : SignedInteger
}
