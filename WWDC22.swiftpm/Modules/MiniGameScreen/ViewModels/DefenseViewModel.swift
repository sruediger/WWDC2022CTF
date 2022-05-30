//
//  DefenseViewModel.swift
//  
//
//  Created by Sérgio Ruediger on 07/04/22.
//

import SwiftUI

/// MiniGame Defense controller
public struct DefenseViewModel: DefenseController {
    /// Defense item properties
    internal var properties: InfosecItemModel
    /// The item infection status
    internal var isInfected: Bool = false

    public init(_ type: DefenseType) {
        switch type {
            case .integrity: self.properties = .init(id: 4, name: "Integrity", imagePath: "Icons/checklist")
            case .confidenciality: self.properties = .init(id: 5, name: "Confidenciality", imagePath: "Icons/password")
            case .availability: self.properties = .init(id: 6, name: "Availability", imagePath: "clock.fill")
        }
    }
    
    /// AssociatedType that represents the information security pillars (aka defense items)
    @frozen public enum DefenseType: String {
        case confidenciality, integrity, availability
    }
}

/// DefenseViewModel+Methods
extension DefenseViewModel {
    /// Get the item color based on it's infection status
    /// - Returns Color instance
    internal func getItemColor() -> Color {
        return self.isInfected ? .red : .blue
    }
}
