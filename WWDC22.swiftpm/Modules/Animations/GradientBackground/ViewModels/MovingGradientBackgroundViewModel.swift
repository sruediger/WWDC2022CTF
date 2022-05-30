//
//  MovingGradientBackgroundViewModel.swift
//  
//
//  Created by Sérgio Ruediger on 22/04/22.
//

import SwiftUI

/// Structure used to control the MovingGradientBackgroundView
struct MovingGradientBackgroundViewModel {
    /// Coordinates used at the beginning of the animation
    internal var start: UnitPoint = .init(x: 0, y: -2)
    /// Coordinates used at the end of the animation
    internal var end: UnitPoint = .init(x: 4, y: 0)
    /// Timer object used to animate the background
    internal let timer = Timer.publish(every: 1, on: .current, in: .default).autoconnect()
    
    /// Updates the animation coordinates
    internal mutating func updatePosition() {
        self.start = UnitPoint(x: 4, y: 0)
        self.end = UnitPoint(x: 0, y: 2)
        self.start = UnitPoint(x: -4, y: 20)
        self.start = UnitPoint(x: 4, y: 0)
    }
}
