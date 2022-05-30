//
//  IntroductionModel.swift
//
//
//  Created by Sérgio Ruediger on 06/04/22.
//

/// Structure that contains some Introduction contents
public struct IntroductionModel {    
    /// Text content displayed at the TerminalTextView
    internal static let terminalTextContent: [String] = ["Wake up X...", "You have been summoned to test your knowledge about information security.", "Are you ready to see a brief introduction of how far the rabbit-hole can go ?", "$ \(TerminalContent.introScript)", "Interactive scene started successfully. Try close this window...", "$ ▮", "Loading MiniChallenges..."]
    
    /// Tuple that contains the title and body of the introduction 2nd window
    internal static let secondWindowText: (title: String, body: String) = ("Another window ? How is that possible ?", "Vulnerable apps, websites and systems may not only expose your data to intruders, but can also have a major security flaw that could allow them to take full control of your device in the worst case, as shown here.\n\nAre you ready to learn how to prevent things like this from happening?\n\nClose this window to begin.")
}
