//
//  InputAccessory.TextField+Modifiers.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import SwiftUI
import FWCommonProtocols
import ButtonConfig


extension InputAccessory.TextField {
    
    /// Set the textField's placeholder text
    /// - Parameter placeholder: the text to use for the placeholder
    public func placeholder(_ placeholder: PlaceHolder?) -> Self {
        var copy = self
        copy.placeholder = placeholder
        return copy
    }
    
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
    public func foregroundColor(_ foregroundColor: Color?) -> Self {
        var copy = self
        copy.foregroundColor = foregroundColor
        return copy
    }
    
    /// Set the background colour of the textField
    /// - Parameter backgroundColor: a Color
    public func backgroundColor(_ backgroundColor: Color?) -> Self {
        var copy = self
        copy.backgroundColor = backgroundColor
        return copy
    }
    
    /// Set the background colour of the toolBar
    /// - Parameter toolBarColor: a Color
    public func toolBarColor(_ toolBarColor: Color?) -> Self {
        var copy = self
        copy.toolBarColor = toolBarColor
        return copy
    }
    
    /// Set the colour of the toolBar buttons
    /// - Parameter toolBarTintColor: a Color
    public func toolBarTintColor(_ toolBarTintColor: Color?) -> Self {
        var copy = self
        copy.toolBarTintColor = toolBarTintColor
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
    public func returnKey(type returnKeyType: UIReturnKeyType = .default, action: (() -> ())? = nil) -> Self {
        var copy = self
        copy.returnKeyType = returnKeyType
        copy.returnKeyAction = action
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
    
    /// Set the insets of the textField (or the padding around the text in the field)
    /// - Parameter insets: EdgeInsets
    public func insets(_ insets: EdgeInsets) -> Self {
        var copy = self
        copy.insets = insets
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
    
    /// Use this to hide the accessory toolBar
    public var hideToolBar: Self {
        var copy = self
        copy._hideToolBar = true
        return copy
    }
    
    /// Set the image for the accessory view's "Done" button, and any action to perform when the keyboard is dismissed using this button
    /// - Parameters:
    ///   - image: the system image name for the accessory view's "Done" button
    ///   - action: an action to perform when the keyboard is dismissed with this button
    public func toolBarDoneButton(_ image: SystemImageNaming? = nil, action: (() -> ())? = nil) -> Self {
        var copy = self
        copy.keyboardDismissButtonAction = action
        copy.doneButtonImageName = image
        return copy
    }
    
    /// Adds a button to the left of the toolBar, just on the right of the '<' & '>' buttons
    /// - Parameter additionalLeftButton: the configuration for the button
    public func additionalLeftButton(_ additionalLeftButton: ImageButtonConfig) -> Self {
        var copy = self
        copy.additionalLeftButtons = [additionalLeftButton]
        return copy
    }
    
    /// Adds a button to the right of the toolBar, just on the left of the dismiss keyboard button
    /// - Parameter additionalRightButton: the configuration for the button
    public func additionalRightButton(_ additionalRightButton: ImageButtonConfig) -> Self {
        var copy = self
        copy.additionalRightButtons = [additionalRightButton]
        return copy
    }
    
    /// An action to perform when editing ends
    /// - Parameter editingEnded: the closure to invoke, which is passed the textField's text
    public func editingEnded(_ editingEnded: @escaping ((String?) -> ())) -> Self {
        var copy = self
        copy.editingEnded = editingEnded
        return copy
    }
}
