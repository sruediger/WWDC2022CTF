//
//  InfosecItemModel.swift
//  
//
//  Created by Sérgio Ruediger on 07/04/22.
//

import Foundation

/// Infosec Item (defense or threat) commom properties
struct InfosecItemModel: Identifiable {
    /// Item identifier
    internal let id: Int
    /// Item name
    internal let name: String
    /// Item icon's imagePath
    internal let imagePath: String
    /// Item type (threat or defense)
    internal let type: InfosecItemType
    
    public init(id: Int, name: String, imagePath: String) {
        self.id = id
        self.name = name
        self.imagePath = imagePath
        self.type = self.id <= 3 ? .threat : .defense
    }
}
