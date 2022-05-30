//
//  DynamicGreeterViewModel.swift
//  
//
//  Created by Sérgio Ruediger on 19/04/22.
//

import Foundation

/// Structure used to control the DynamicGreeterView
struct DynamicGreeterViewModel {
    /// Currently displayed greeting
    internal var greeting: String = "Welcome"
    
    /// Greetings in some languages from english to ukrainian
    internal let greetings: [String] = ["Welcome", "Wilkommen", "Welkom", "Bienvenido", "Bem-vindo", "Välkommen", "Vitajte", "Benvenuto", "Velkommen", "Bienvenue", "Dobrodošli", "Tervetuloa", "ようこそ", "欢迎", "환영하다", "Ласкаво просимо"]
    
    /// Computed property which returns the size of the greetings array
    internal var greetingsAmount: Int { self.greetings.count - 1 }
}
