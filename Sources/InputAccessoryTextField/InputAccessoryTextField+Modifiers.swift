//
//  InputAccessoryTextField+Modifiers.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import SwiftUI
import FWCommonProtocols


extension InputAccessoryTextField {
    
    /// Set the font of the textField
    /// - Parameter font: a UIFont instance
    public func font(_ font: UIFont) -> Self {
        var copy = self
        copy.font = font
        return copy
    }
    
    /// Set the font style and weight of the textField
    /// - Parameters:
    ///   - style: a Font.TextStyle
    ///   - weight: a Font.Weight
    public func font(_ style: Font.TextStyle, weight: Font.Weight) -> Self {
        var copy = self
        let uiStyle = style.uiStyle
        let uiWeight = weight.uiWeight
        let font = UIFont.preferredFont(style: uiStyle, weight: uiWeight)
        copy.font = font
        return copy
    }
    
    /// Set the text colour of the textField
    /// - Parameter foregroundColor: a Color
    public func foregroundColor(_ foregroundColor: Color) -> Self {
        var copy = self
        copy.foregroundColor = foregroundColor
        return copy
    }
    
    /// Set the keyboard type of the textField
    /// - Parameter keyboardType: a UIKeyboardType case
    public func keyboardType(_ keyboardType: UIKeyboardType) -> Self {
        var copy = self
        copy.keyboardType = keyboardType
        return copy
    }
    
    /// Set the return key type of the textField
    /// - Parameter returnKeyType: a UIReturnKeyType case
    public func returnKeyType(_ returnKeyType: UIReturnKeyType) -> Self {
        var copy = self
        copy.returnKeyType = returnKeyType
        return copy
    }
    
    /// Specify whether or not to apply autocorrection to the input
    /// - Parameter disableAutocorrection: true to enable autocorrection
    public func disableAutocorrection(_ disableAutocorrection: Bool = true) -> Self {
        var copy = self
        copy.disableAutocorrection = disableAutocorrection
        return copy
    }
    
    /// Set the autocapitalisation policy of the textField input
    /// - Parameter autocapitalization: a UITextAutocapitalizationType case
    public func autocapitalization(_ autocapitalization: UITextAutocapitalizationType) -> Self {
        var copy = self
        copy.autocapitalization = autocapitalization
        return copy
    }
    
    /// Use this to show the clear button while editing the textField
    public var showsClearButton: Self {
        var copy = self
        copy._showsClearButton = true
        return copy
    }
    
    /// Tell the textField to become the first responder
    /// - Parameter shouldStart: if set to true (default) then it will become the first responder
    public func startInput(_ shouldStart: Bool = true) -> Self {
        guard let tag = tag else {
            return self
        }
        if shouldStart {
            accessoryController.startInput(tag)
        }
        return self
    }
    
    /// Tell all tagged InputAccessoryTextFields to resignFirstResponder
    /// - Parameter shouldEnd: if set to true then it will resign the first responder from the tagged InputAccessoryTextField which is currently the first responder
    public func endInput(_ shouldEnd: Bool) -> Self {
        if shouldEnd {
            accessoryController.endInput()
        }
        return self
    }
    
    /// Set the image for the accessory view's "Done" button, and any additional action to perform when the keyboard is dismissed
    /// - Parameters:
    ///   - buttonImage: the image for the accessory view's "Done" button
    ///   - action: an additional action to perform when the keyboard is dismissed
    public func done(buttonImage: SystemImageNaming? = nil, action: (() -> ())? = nil) -> Self {
        var copy = self
        copy.commitAction = action
        copy.doneButtonImageName = buttonImage
        return copy
    }
}
