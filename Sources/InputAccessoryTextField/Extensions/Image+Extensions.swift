//
//  Image+Extensions.swift
//
//  Created by Franklyn Weber on 27/01/2021.
//

import SwiftUI


extension Image {
    
    enum SystemName: String, ImageNaming {
        case chevronLeft = "chevron.left"
        case chevronRight = "chevron.right"
        case keyboardDismiss = "keyboard.chevron.compact.down"
        
        var imageName: String {
            rawValue
        }
    }
    
    init(_ systemName: SystemName) {
        self.init(systemName: systemName.rawValue)
    }
}
