//
//  SecureTextField.swift
//  
//
//  Created by Sérgio Ruediger on 11/04/22.
//

import SwiftUI

/// SecureField and TextField abstraction that switches to the most appropriate one according to the situation
struct SecureTextField: View {
    /// Boolean that indicates if the user is using an SecureField (password masked with bullet-points)
    @State private var isSecureField: Bool = true
    /// Plaintext that contains the userInput (raw password)
    @Binding var text: String
    
    var body: some View {
        HStack {
            if isSecureField {
                SecureField((text.isEmpty ? "Password" : text), text: $text).font(.title2)
            } else {
                TextField((text.isEmpty ? "Password" : text), text: $text).font(.title2)
            }
            Spacer()
            Image(systemName: !isSecureField ? "eye.slash": "eye").onTapGesture {
                isSecureField.toggle()
            }
        }.foregroundColor(.white)
    }
}
