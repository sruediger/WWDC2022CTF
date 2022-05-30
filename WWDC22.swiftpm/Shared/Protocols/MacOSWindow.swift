//
//  MacOSWindow.swift
//  
//
//  Created by Sérgio Ruediger on 21/04/22.
//

import CoreGraphics

/// MacOSWindow controller that declares the viewModel properties and methods
internal protocol MacOSWindow {
    /// MacOSWindow top leading buttons (close, minimize, maximize)
    var topButtons: [TopButton] { get }
    /// Boolean that indicates if the window instance is presented
    var isPresented: Bool  { get set }
    /// Boolean used to show the unavailable feature alert
    var showUnavailableFeatureAlert: Bool { get set }
    /// MacOSWindow dynamic position location
    var currentPosition: CGPoint { get set }

    // Methods
    
    /// Show an unavailable feature alert when some is tapped
    mutating func hideUnavailableFeatureAlert()
    
    /// Perform the pressed action of an specific top-leading button
    /// - Parameter button: Top leading button that will trigger the action
    /// - Parameter windowIsClosed: Boolean that indicates if the MacOSWindow instance is already closed
    mutating func pressedButtonAction(of button: TopButton, windowIsClosed: Bool)
    
    /// Enumeration that represents the top leading buttons of an MacOS window
    associatedtype TopButton : RawRepresentable where TopButton.RawValue : StringProtocol
}
