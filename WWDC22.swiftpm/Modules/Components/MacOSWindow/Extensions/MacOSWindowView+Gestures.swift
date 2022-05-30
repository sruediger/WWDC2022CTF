//
//  MacOSWindowView+Gestures.swift
//  
//
//  Created by Sérgio Ruediger on 20/04/22.
//

import SwiftUI

/// MacOSWindowView+Gestures
extension MacOSWindowView {
    
    /// MacOSWindowView main Drag Gesture
    var dragWindow: some Gesture {
        DragGesture(coordinateSpace: .named("WindowHeader"))
            .onChanged { windowPosition in
                withAnimation(.interactiveSpring()) {
                    var newLocation = CGPoint()
                //    var newLocation = startPosition ?? currentPosition
                    
                    newLocation.x = windowPosition.translation.width
                    newLocation.y = windowPosition.translation.height
    //                    newLocation.x += windowPosition.translation.width
    //                    newLocation.y += windowPosition.translation.height
                    
                    self.viewModel.currentPosition = newLocation
                    self.isDragging?.wrappedValue.toggle()
                //    print("newLocation = \(newLocation)")
                }
            }.onEnded { _ in self.isDragging?.wrappedValue.toggle() }
            /*.updating($startPosition) { (_, startLocation, _) in
                startLocation = startLocation ?? self.currentPosition
            }*/
    }
    /*
    /// Drag Gesture that is restricted to updating the WindowHeader coordinateSpace dragPosition
    var restrictDrag: some Gesture {
        DragGesture(coordinateSpace: .named("WindowHeader"))
            .updating($dragPosition) { (value, dragPosition, _) in
                dragPosition = value.location
            }
    }*/
}
