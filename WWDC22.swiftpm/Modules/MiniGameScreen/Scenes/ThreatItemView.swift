//
//  ThreatItemView.swift
//  
//
//  Created by Sérgio Ruediger on 07/04/22.
//

import SwiftUI

/// View that represents an Infosec Threat 
public struct ThreatItemView: View {
    @Binding var viewModel: ThreatViewModel
    /// The falling threats dynamic position
    @State private var dynamicPosition: CGSize = .zero
    /// Completion Handler used to tell the parent view if the player made a score or lost
    public let callback: (Bool) -> Void

    public var body: some View {
        Circle()
            .foregroundColor(viewModel.getItemColor())
            .overlay(
                Image(viewModel.properties.imagePath)
                    .resizable()
                    .frame(width: 48, height: 48)
            ).frame(width: 98, height: 98)
            .offset(x: self.dynamicPosition.width, y: self.dynamicPosition.height)
           // .opacity(viewModel.isSelected ? 0 : 1)
            .onAppear {
                self.dynamicPosition.height = -250
            }.onTapGesture {
                withAnimation(.easeOut(duration: 1)) {
                    self.viewModel.isSelected = true
                }
            }//.animation(.linear(duration: 1.75), value: 1)
          //  .transition(.asymmetric(insertion: .scale, removal: .opacity))
            .onReceive(Timer.publish(every: viewModel.getFallingThreatSpeed(), on: .current, in: .common).autoconnect()) { _ in  // Update offset
                let backToStart = {() -> Void in /// Closure used to move the threat item back to it's origin
                    self.dynamicPosition.height = -200
                    withAnimation(.linear(duration: 2)) {
                        self.viewModel.isSelected = false
                    }
                }
                
                if self.dynamicPosition.height <= (UIScreen.main.bounds.height * 0.75) {// If the dynamic position of the threat is lower or equal than 75% of the screen, the threat will keep falling until it's eliminated by the player (score) or the game is over
                    if !viewModel.isSelected { // keep falling
                        self.dynamicPosition.height += 20
                    }else { // Threat eliminated (score)
                        self.callback(true)
                        backToStart()
                    }
                }else { // Game over
                //    withAnimation(.linear(duration: 1)) {
                        self.callback(false)
                        backToStart()
                 //   }
                }
            }
    }
}
