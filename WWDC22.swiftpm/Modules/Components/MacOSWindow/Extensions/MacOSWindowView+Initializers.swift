//
//  MacOSWindowView+Initializers.swift
//  
//
//  Created by Sérgio Ruediger on 13/04/22.
//

import SwiftUI

/// MacOSWindows+Initializers
extension MacOSWindowView {
    
    /// MacOSWindow default initializer
    public init(dimensions: CGSize, @ViewBuilder content: @escaping () -> Content) {
        self.dimensions = dimensions
        self.contentView = content()
        self.onDismiss = nil
        self.isDragging = nil
    }
    
    /// MacOSWindow custom initializer #1
    public init(dimensions: CGSize, windowClosed: Binding<Bool> = Binding.constant(false), isDragging: Binding<Bool> = Binding.constant(false), @ViewBuilder content: @escaping () -> Content, onDismiss: Callback) {
        self.dimensions = dimensions
        self.isClosed = windowClosed
        self.isDragging = isDragging
        self.contentView = content()
        self.onDismiss = onDismiss
    }
}
