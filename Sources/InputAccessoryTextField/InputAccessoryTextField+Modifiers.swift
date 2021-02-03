//
//  InputAccessoryTextField+Modifiers.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import SwiftUI


extension InputAccessoryTextField {
    
    public func font(_ font: UIFont) -> Self {
        var copy = self
        copy.font = font
        return copy
    }
    
    public func font(_ style: Font.TextStyle, weight: Font.Weight) -> Self {
        var copy = self
        let uiStyle = style.uiStyle
        let uiWeight = weight.uiWeight
        let font = UIFont.preferredFont(style: uiStyle, weight: uiWeight)
        copy.font = font
        return copy
    }
    
    public func foregroundColor(_ foregroundColor: Color) -> Self {
        var copy = self
        copy.foregroundColor = foregroundColor
        return copy
    }
    
    public func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        var copy = self
        copy.keyboardType = keyboardType
        return copy
    }
    
    public func returnKeyType(_ returnKeyType: UIReturnKeyType) -> Self {
        var copy = self
        copy.returnKeyType = returnKeyType
        return copy
    }
    
    public func disableAutocorrection(_ disableAutocorrection: Bool = true) -> Self {
        var copy = self
        copy.disableAutocorrection = disableAutocorrection
        return copy
    }
    
    public func autocapitalization(_ autocapitalization: UITextAutocapitalizationType) -> Self {
        var copy = self
        copy.autocapitalization = autocapitalization
        return copy
    }
    
    public func startInput(_ shouldStart: (() -> Bool)? = nil) -> Self {
        guard let tag = tag else {
            return self
        }
        accessoryController.startInput(tag)
        return self
    }
    
    public func done(buttonImage: ImageNaming? = nil, action: (() -> ())? = nil) -> Self {
        var copy = self
        copy.commitAction = action
        copy.doneButtonImageName = buttonImage
        return copy
    }
}
