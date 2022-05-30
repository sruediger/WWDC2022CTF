//
//  FallingLettersViewModel.swift
//
//
//  Created by Sérgio Ruediger on 08/04/22.
//

import SwiftUI

/// View that simulates the digital rain that happens on *The Matrix* movie
struct LetterRainView: View {
    /// Total duration of the animation on-screen. The default value is nil which represents infinite
    internal var duration: CGFloat? = nil

    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            HStack { /// Time complexity: O(nˆ2)
                ForEach(1...Int(size.width / 32), id: \.self) { _ in
                    FallingLettersView(size: size, duration: duration)
                }
            }
        }
    }
}

/// LetterRainView+AssociatedTypes
extension LetterRainView {
    
    /// AssociatedType that creates a column of Falling Letters
    private struct FallingLettersView: View {
        @State private var viewModel = FallingLettersViewModel()
        internal let size: CGSize
        internal let duration: CGFloat?
        
        var body: some View {
            let randomHeight: CGFloat = .random(in: (size.height / 2)...size.height)
            
            VStack {
                ForEach(0..<viewModel.charset.count, id: \.self) { index in
                    let char = Array(viewModel.charset)[viewModel.getRandomIndex(index: index)]
                    Text(String(char))
                        .font(.title)
                        .foregroundColor(.green)
                }
            }.mask(alignment: .top){
                Rectangle()
                    .fill(LinearGradient(
                        colors: viewModel.getGradientColors(),
                        startPoint: .top,
                        endPoint: .bottom))
                    .frame(height: size.height / 2)
                    .offset(y: viewModel.startAnimation ? size.height : -randomHeight)
            }.onAppear {
                if let duration = self.duration {
                    withAnimation(.linear(duration: duration).delay(.random(in: 0...2))) {
                        viewModel.startAnimation = true
                    }
                }else {
                    withAnimation(.linear(duration: 3).delay(.random(in: 0...2)).repeatForever(autoreverses: false)) {
                        viewModel.startAnimation = true
                    }
                }
            }.onReceive(Timer.publish(every: 0.2, on: .current, in: .common).autoconnect()) { _ in
                viewModel.random = Int.random(in: 0..<viewModel.charset.count)
            }
        }
    }
}
