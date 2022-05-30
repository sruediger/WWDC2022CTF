//
//  ThreatViewModel+Methods.swift
//  
//
//  Created by Sérgio Ruediger on 21/04/22.
//

import SwiftUI

/// ThreatViewModel+Methods
extension ThreatViewModel {
    
    /// Fetch the object's (threat) description, composed by a title and info (body)
    /// - Returns a tuple of the type (title: String, info: String)
    internal func getDescription() -> (title: String, info: String) {
        let imagePath = self.properties.imagePath
        
        if imagePath.contains("virus") {
            return ("You have been infected by a Malware!", """
            Malwares are malicious softwares that can have multiple purposes and be of various types such as ransomware, spyware, adware, rootkits, worms, trojans, keyloggers, etc.

            Regardless of the type, they usually pass as legitimate files to give more credibility and are obtained in different ways, an example is from pirated content sites and from other infected devices. It is also common for attackers to use social engineering to convince targets to download malware, such as strange spam emails with attachments.

            """)
        }else if imagePath.contains("brokenchain") {
            return ("A critical vulnerability was exploited!", """
            Vulnerabilities exist everywhere and can be caused by anything, such as a poorly configured app, website, service etc that allows attacks, doesn't protect data as it should or even the user's own fault for bad security practices.

            Some examples of vulnerability exploits are outdated softwares, weak and/or reused passwords, database leaks with personal information, excessive exposure on social networks, SQL Injection, Cross-Site-Scripting, Man-In-The-Middle, etc.
            """)
        }else if imagePath.contains("incognito") {
            return ("A social engineer hacked you!", """
            Social engineering relies on human vulnerability to exploit system security and is relatively more difficult to protect against, since they target the user rather than just the hardware or software defenses.

            End user awareness can be considered as one of the simplest yet most effective ways to protect them against social engineering. These types of attacks happen in one or more steps, always carried out through direct or indirect human interactions.
            
            Some examples are baiting, phishing, scareware (false alarms with fictitious threats), physical breaches, DNS spoofing etc.
            """)
        }else { /* Shouldn't happen */ return ("", "") }
    }
    
    /// Get the item color based on it's selection status
    /// - Returns Color instance
    internal func getFallingThreatSpeed() -> CGFloat {
        switch properties.id {
            case 1: return 0.05
            case 2: return 0.053
            case 3: return 0.056
            default: return .zero
        }
    }
    
    /// Get the item color based on it's selection status
    /// - Returns Color instance
    internal func getItemColor() -> Color {
        return self.isSelected ? .yellow : .red
    }
}
