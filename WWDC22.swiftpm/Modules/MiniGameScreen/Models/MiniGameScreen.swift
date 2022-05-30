//
//  MiniGameScreen.swift
//  
//
//  Created by Sérgio Ruediger on 08/04/22.
//

import Foundation

/// Enumeration representing the current Mini Game View state
@frozen public enum MiniGameScreen {
    case introWindow,
        /*gameInProgress*/ // Unused
         levelPassed,
         gameOver
}
