//
//  TerminalContent.swift
//  
//
//  Created by Sérgio Ruediger on 12/04/22.
//

import Foundation

/// Shared Terminal Content used through the interactive scene
struct TerminalContent {
    /// This project filename
    private static let projectPath: String = "WWDC22CTF.swiftpm"
    /// Folder of the hidden scripts used on this interactive scene
    private static let scriptsPath: String = "\(projectPath)/.scripts"
    
    /// Main introduction script
    public static let introScript: String = "./\(scriptsPath)/.autorun.sh"
    
    /// Hash introduction and calculator script
    public static let hashScript: String = "./\(scriptsPath)/.passwdhashes.sh"

    /// Password strength meter (iBreaker) script
    public static let passwordsScript: String = "./\(scriptsPath)/.passwdbreaker.sh"
    
}
