//
//  ThreatViewModel.swift
//  
//
//  Created by Sérgio Ruediger on 07/04/22.
//

import CoreGraphics

/// MiniGame Threat controller
public struct ThreatViewModel: ThreatController {
    /// Threat item properties
    internal var properties: InfosecItemModel
    /// Selection (tap) status
    internal var isSelected: Bool = false
    /// Dynamic falling position
    internal var currentPosition: CGSize = .zero
    
    public init(_ type: ThreatType) {
        switch type {
            case .malwares: self.properties = .init(id: 1, name: "Malwares", imagePath: "Icons/virus")
            case .vulnerabilities: self.properties = .init(id: 2, name: "Common Vulnerabilities Exploits (CVE's)", imagePath: "Icons/brokenchain")
            case .socialEngineering: self.properties = .init(id: 3, name: "Social Engineering", imagePath: "Icons/incognito")
        }
    }
    
    /// AssociatedType that represents this challenge threats
    @frozen public enum ThreatType: Int {
        case malwares, vulnerabilities, socialEngineering
    }
}
