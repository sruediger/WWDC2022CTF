//
//  DefenseItemView.swift
//  
//
//  Created by Sérgio Ruediger on 07/04/22.
//

import SwiftUI

/// View that represents an Information Security Pillar (a.k.a Defense Item)
public struct DefenseItemView: View {
    @Binding var viewModel: DefenseViewModel

    public var body: some View {
        VStack(spacing: 10) {
            Rectangle()
                .cornerRadius(32)
                .foregroundColor(viewModel.getItemColor())
                .overlay(self.createImageView().frame(width: 48, height: 48))
                .frame(width: 98, height: 98)
            
            Text(viewModel.properties.name)
                .bold()
                .font(.footnote)
                .foregroundColor(.white)
        }
    }
}

/// DefenseItemView+Builders
extension DefenseItemView {
    /// Creates a custom Defense Image View
    /// - Returns Image View
    @ViewBuilder fileprivate func createImageView() -> some View {
        let imagePath: String = viewModel.properties.imagePath
        let imageView: Image = imagePath.contains("clock") ? Image(systemName: imagePath) : Image(imagePath)
        imageView.resizable()
    }
}
