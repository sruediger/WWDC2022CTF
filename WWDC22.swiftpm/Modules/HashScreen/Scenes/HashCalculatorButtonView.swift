//
//  HashCalculatorButtonView.swift
//  
//
//  Created by Sérgio Ruediger on 10/04/22.
//

import SwiftUI

/// A button that composes the HashCalculatorView
struct HashCalculatorButtonView: View {
    internal var model: HashCalculatorButton
    @Binding internal var viewModel: HashCalculatorViewModel

    var body: some View {
        Button {
            self.viewModel.performAction(of: model)
        } label: {
            ZStack {
                self.createBackground()
                VStack(alignment: .center, spacing: 5) {
                    if model == .result {
                        self.createEqualImageView()
                    }else {
                        self.createTextView()
                        if model == .algorithm { self.createAlgorithmSwitcherMenu() }
                    }
                }.foregroundColor(.white)
            }
        }
    }
}
