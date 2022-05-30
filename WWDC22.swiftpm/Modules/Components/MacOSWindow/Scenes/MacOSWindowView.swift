//
//  MacOSWindowView.swift
//  MacOSWindow
//
//  Created by Sérgio Ruediger on 05/04/22.
//

import SwiftUI

/// Structure that creates a Mac OS Window instance to show Graphical User Interface (GUI) content
struct MacOSWindowView<Content: View>: View {
    typealias Callback = (() -> Void)?
    /// Window dimensions (width and height)
    public var dimensions: CGSize
    /// Optional binding property used to do additional settings outside this view
    public var isDragging: Binding<Bool>? = nil
    /// Optional binding property used to do additional settings outside this view
    public var isClosed: Binding<Bool>? = nil
    /// Window controller
    @State public var viewModel = MacOSWindowViewModel()
    /// Main content subview which will be presented by the MacOSWindow instance
    @ViewBuilder var contentView: Content
    /// Completion handler for the standard close button (top leading)
    public let onDismiss: Callback
//    @GestureState private var startPosition: CGPoint? = nil // Initial position when the window is dragged
    
    var body: some View {
        Rectangle()
            .cornerRadius(20)
            .foregroundColor(Color("Colors/background")).ignoresSafeArea()
            .shadow(color: .black, radius: 5, x: 0, y: 5)
            .overlay(
                VStack {
                    self.createTopAreaSubview()
                        .background(Color.secondary.opacity(0.01).frame(height: 55))
                        .coordinateSpace(name: "WindowHeader")
                        .highPriorityGesture(self.dragWindow)
                    
                    self.createContentAreaSubview()
                    Spacer()
                }
            ).frame(width: dimensions.width, height: dimensions.height)
            .opacity(viewModel.isPresented ? 1 : 0)
            .offset(x: viewModel.currentPosition.x, y: viewModel.currentPosition.y)
    }
}
