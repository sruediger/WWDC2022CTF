//
//  WWDCSceneViewModel.swift
//  
//
//  Created by Sérgio Ruediger on 07/04/22.
//

import Foundation

/// The main interactive scene controller
struct WWDCSceneViewModel {
    /// Boolean used to present the introduction while it's false
    public var introductionFinished: Bool = false
    /// Boolean used to present the MiniGame while it's false
    public var miniGamePassed: Bool = false {
        willSet {
            if newValue { self.showFallingLetters = true }
        }
    }
    /// The player mini game score
    public var miniGameScore: Int = 0
    /// Boolean used to present the Falling Letters
    public var showFallingLetters: Bool = false
    /// Boolean used to present the Password Breaker (aka Password Strength Meter)
    public var showPasswordBreaker: Bool = false
    
}
