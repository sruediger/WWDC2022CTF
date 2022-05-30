//
//  Snippets.swift
//  
//
//  Created by Sérgio Ruediger on 12/04/22.
//

import UIKit

/// Collection of reusable methods
struct Snippets {
    
    /// Fetch the user's current device
    /// - Returns UIUserInterfaceIdiom corresponding to the user device
    public static func getCurrentDevice() -> UIUserInterfaceIdiom {
        return UIDevice.current.userInterfaceIdiom
    }
    
    /// DispatchQueue abstraction that performs a task asynchronously after a certain time in seconds
    /// - Parameter time: The time in seconds to perform a task
    /// - Parameter task: Task that will be performed after the specified time
    public static func runAfter(timeInSeconds time: Double, _ task: @escaping () -> Void) {
        if time <= 0 {
            DispatchQueue.main.async {
                task()
            }
        }else {
            DispatchQueue.main.asyncAfter(deadline: .now() + time) {
                task()
            }
        }
    }
    
}
