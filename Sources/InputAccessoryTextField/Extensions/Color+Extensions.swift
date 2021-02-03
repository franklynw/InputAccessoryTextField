//
//  Color+Extensions.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import SwiftUI


extension Color {
 
    var uiColor: UIColor {

        if #available(iOS 14.0, *) {
            return UIColor(self)
        }

        let components = self.components()
        
        return UIColor(red: components.red, green: components.green, blue: components.blue, alpha: components.alpha)
    }

    private func components() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        
        var hex: UInt64 = 0
        
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        if scanner.scanHexInt64(&hex) {
            red = CGFloat((hex & 0xff000000) >> 24) / 255
            green = CGFloat((hex & 0x00ff0000) >> 16) / 255
            blue = CGFloat((hex & 0x0000ff00) >> 8) / 255
            alpha = CGFloat(hex & 0x000000ff) / 255
        }
        
        return (red, green, blue, alpha)
    }
}
