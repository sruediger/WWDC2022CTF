//
//  File.swift
//  MacOSWindow
//
//  Created by Sérgio Ruediger on 05/04/22.
//

import SwiftUI

/// Structure used to control the MacOSWindowView
public struct MacOSWindowViewModel: MacOSWindow {
    /// MacOSWindow top leading buttons (close, minimize, maximize)
    internal let topButtons: [TopButton] = TopButton.allCases
    /// Boolean that indicates if the window instance is presented
    internal var isPresented: Bool = true
    /// Boolean used to show the unavailable feature alert
    internal var showUnavailableFeatureAlert: Bool = false
    /// MacOSWindow dynamic position location
    internal var currentPosition: CGPoint = CGPoint(x: 0, y: 0)
//    public var isHoveringTopButton: Bool = false
}

/// MacOSWindowViewModel+Methods
extension MacOSWindowViewModel {
    
    /// Show an unavailable feature alert when some is tapped
    public mutating func hideUnavailableFeatureAlert() {
        withAnimation(.easeInOut) {
            self.showUnavailableFeatureAlert = false
        }
    }
    
    /// Perform the pressed action of an specific top-leading button
    /// - Parameter button: Top leading button that will trigger the action
    /// - Parameter windowIsClosed: Boolean that indicates if the MacOSWindow instance is already closed
    public mutating func pressedButtonAction(of button: TopButton, windowIsClosed: Bool) {
        switch button {
            case .close:
                guard !windowIsClosed else { return }
                self.isPresented = false
            case .minimize, .maximize: self.showUnavailableFeatureAlert = true
        }
    }
}


/// MacOSWindowViewModel+AssociatedTypes
extension MacOSWindowViewModel {
    
    /// Enumeration that represents the top leading buttons of an MacOS window
    @frozen public enum TopButton: String, CaseIterable, Identifiable {
        case close, minimize, maximize

        /// Identifier that conforms the type to the Identifiable protocol besides identifying an top-leading button
        public var id: String { self.rawValue }
        
        /// Fetch the color a given button
        /// - Returns Color corresponding to the button instance
        public func getColor() -> UIColor {
            switch self {
                case .close: return .systemRed
                case .minimize: return .systemYellow
                case .maximize: return .systemGreen
            }
        }
    }
}
