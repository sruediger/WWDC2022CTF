//
//  DynamicGreeterView.swift
//  
//
//  Created by Sérgio Ruediger on 06/04/22.
//

import SwiftUI

/// Introduction's 1st window content
struct DynamicGreeterView: View {
    @State private var viewModel = DynamicGreeterViewModel()
    
    var body: some View {
        VStack {
            RoundedText(content: "WWDC 2022", size: 56, weight: .heavy)
                .foregroundColor(.white)
                        
            Text("Swift Student Challenge **Infosec Edition**") // Using regular Text instead of RoundedText because the 2nd doesn't render markdown
                .foregroundColor(.white)
                .font(.system(size: 22, weight: .semibold, design: .rounded))
            
            Spacer().frame(height: 20)
        
            RoundedText(content: viewModel.greeting, size: 48, weight: .bold)
                .transition(.scale)
                .foregroundColor(.green)
                .id("Greet" + viewModel.greeting)
                .onReceive(Timer.publish(every: 1.25, on: .current, in: .common).autoconnect()) { _ in
                //    guard !isDragging else { return }
                    withAnimation {
                        if let currentGreet = viewModel.greetings.firstIndex(of: viewModel.greeting) {
                            if currentGreet != viewModel.greetingsAmount {
                                viewModel.greeting = viewModel.greetings[currentGreet + 1]
                            }else {
                                viewModel.greeting = viewModel.greetings[0]
                            }
                        }
                    }
                }
        }
    }
}
