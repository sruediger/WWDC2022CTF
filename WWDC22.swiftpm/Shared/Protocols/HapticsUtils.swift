//
//  HapticUtils.swift
//  Secretly
//
//  Created by Sérgio Ruediger on 08/02/22.
//

import Foundation

/// The HapticsManager blueprint
public protocol HapticsUtils {
    associatedtype HapticType
    
    /** Trigger and activate a haptic feedback
        - Parameter type: Type of the Haptic Feedback */
    static func trigger(_ type: HapticType)
}
