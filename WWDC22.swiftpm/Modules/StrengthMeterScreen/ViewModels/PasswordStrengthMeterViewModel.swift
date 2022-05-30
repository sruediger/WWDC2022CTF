//
//  PasswordStrengthMeterViewModel.swift
//  
//
//  Created by Sérgio Ruediger on 10/04/22.
//

import SwiftUI

/// Structure used to control the Password Strength Meter View
struct PasswordStrengthMeterViewModel: PasswordStrengthMeter {
    /// Object used to handle password-related tasks like validation and categorization
    private(set) var passwordHandler: PasswordParser = .init()
    /// User's password
    internal var userInput: String = "" {
        willSet {
            if newValue.isEmpty {
                self.purgeIO()
            }else {
                self.passwordHandler.password = newValue
            }
        }
    }
    /// Estimated time to crack the password (a.k.a userInput)
    private(set) var output: String = ""
    /// Boolean that presents the info window
    private(set) var presentInfoWindow: Bool = false {
        willSet { self.mainWindowTapped = false }
    }
    /// Boolean that controls both windows zPosition
    internal var mainWindowTapped: Bool = false
    /// Mirror of the this object passwordHandler.guessesPerSecond property
    internal var guessesPerSecondMirror: Double = 100000000000000/2 {
        willSet {
            self.passwordHandler.guessesPerSecond = UInt64(newValue)
            self.userInput = String(self.userInput) // Assigning to itself to force-update the output via an PasswordStrengthMeterView .onChange(of:) modifier.
            self.updateOutput()
        }
    }
    /// Terminal text controller
    internal var terminalText = TerminalTextViewModel(content: ["$ \(TerminalContent.passwordsScript)", "$ ▮", "Congratulations, you solved all challenges!", "I hope you had fun in this interactive scene and learned something new.", "That's all folks, have a wonderful WWDC2022!", " ",  "Saving session...completed.", " ", "[Process completed]▮"])
    
    /// Checks if the device is the iPad Pro 12.9" or above
    internal var isLargeiPad: Bool {
        return UIScreen.main.bounds.width >= 1024
    }
}

/// PasswordStrengthMeterViewModel+Methods
extension PasswordStrengthMeterViewModel {
    
    /// Fetch the attacker's guesses per second in a more convenient format
    /// - Returns String containing the attacker's guesses per second
    internal func getFormattedGuessesPerSecond() -> String {
        var suffix: String = ""
        var guessesPerSecond: Double = self.guessesPerSecondMirror
        switch self.guessesPerSecondMirror {
            case 1000000000...999999999999:
                guessesPerSecond /= 1000000000
                suffix = "billion"
            case 1000000000000...:
                guessesPerSecond /= 1000000000000
                suffix = "trillion"
            default: return "" /// Shouldn't happen
        }
        return String(format: "%.2f", guessesPerSecond).appending(" \(suffix)")
    }
    
    /// Present or hide the info window
    internal mutating func toggleInfoWindow() {
        self.presentInfoWindow.toggle()
    }
    
    /// Purge all Input & Output variables
    private mutating func purgeIO() {
        self.output = ""
    }
    
    /// Get the color of the estimated time to crack a password
    internal func getEstimatedTimeColor() -> Color {
        let estimatedTime = self.output
        if estimatedTime == "Instantly" || estimatedTime.contains("seconds") || estimatedTime.contains("minutes") {
            return .red
        }else if estimatedTime.contains("hour") || estimatedTime.contains("days") {
            return .orange
        }else if estimatedTime.contains("weeks") || estimatedTime.contains("months") {
            return .yellow
        }else if estimatedTime.contains("years") {
            return .green
        }else { return .purple }
    }
    
    /// Updates the output
    internal mutating func updateOutput() {
        // old: .easeIn(duration: 1)
        withAnimation(.linear(duration: 2)) {
            self.output = (self.passwordHandler.entropy <= 32 ? "Instantly" : self.convertSecondsToTime(passwordHandler.secondsToCrack))
        }
    }
    
    /// Fetch the PasswordStrengthMeterView displayed windows height
    /// - Parameter mainWindow: Desired window to get it's height
    /// - Returns CGFloat containing the windowHeight
    internal func getHeight(of mainWindow: Bool) -> CGFloat {
        let deviceHeight = UIScreen.main.bounds.height
        switch deviceHeight {
            case ...1024: /// All iPads up to Pro 9.7"
                return deviceHeight * 0.54
            case ...1194: /// iPad Pro 11"
                return deviceHeight * (mainWindow ? 0.465 : 0.5)
            case ...1366: /// iPad Pro 12.9"
                return deviceHeight * 0.44
            default: return .zero
        }
    }
    
    /// Converts a given time in seconds to a more convenient format if necessary
    /// - Parameter amount: The amount of time in seconds
    /// - Returns String describing the amount in the new format
    private func convertSecondsToTime(_ amount: Double) -> String {
        if amount <= 60 { // Show time in seconds
            let timeInSeconds = (amount > 1 ? String("\(Int(amount))") : String(format: (amount < 0.01 ? "%.4f" : "%.2f"), amount))
        //    print("time in seconds: \(amount)")

            return String("\(timeInSeconds) seconds")
        }else { // Convert to a more convenient format
            let timeInMinutes = {() -> Double in amount / 60 }
            let timeInHours = {() -> Double in amount / 3600 }
            let timeInDays = {() -> Double in amount / 86400 }
            let timeInWeeks = {() -> Double in amount / 604800 }
            let timeInMonths = {() -> Double in timeInWeeks() / 4.345 }
            let timeInYears = {() -> Double in timeInWeeks() / 52.143 }
            
            if timeInMinutes() >= 1 && timeInMinutes() <= 60 { // Minutes
                return String("\(UInt64(timeInMinutes())) minutes")
            }else if timeInHours() >= 1 && timeInHours() <= 24 { // Hours
                return String("\(UInt64(timeInHours())) hours")
            }else if timeInDays() >= 1 && timeInDays() <= 7 { // Days
                return String("\(UInt64(timeInDays())) days")
            }else if timeInWeeks() >= 1 && timeInWeeks() <= 5 { // Weeks
                return String("\(UInt64(timeInWeeks())) weeks")
            }else if timeInMonths() >= 1 && timeInMonths() <= 12 { // Months
                return String("\(UInt64(timeInMonths())) months")
            }else { // Years
                let timeInYears = timeInYears()
                var timeAmount: String = ""
                
                switch timeInYears {
                    case 1...999: timeAmount.append(contentsOf: "\(UInt64(timeInYears))")
                    case 1000...999999: timeAmount.append(contentsOf: "\(UInt64(timeInYears / 1000)) thousand")
                    case 1000000...999999999: timeAmount.append(contentsOf: "\(UInt64(timeInYears / 1000000)) million")
                    case 1000000000...999999999999: timeAmount.append(contentsOf: "\(UInt64(timeInYears / 1000000000)) billion")
                    case 1000000000000...999999999999999: timeAmount.append(contentsOf: "\(UInt64(timeInYears / 1000000000000)) trillion")
                    case 1000000000000000...:
                        let quadrillionYears = Double(timeInYears / 1000000000000000)
                        if quadrillionYears < 100000 {
                            timeAmount.append(contentsOf: "\(String(format: "%.0f", quadrillionYears)) quadrillion")
                        }else { return "Infinite" }
                    default: return "" // Shouldn't happen
                }
                return timeAmount.appending(" years")
            }
        }
    }
    
}
