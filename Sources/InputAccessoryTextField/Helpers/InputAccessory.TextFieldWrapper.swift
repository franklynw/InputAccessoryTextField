//
//  InputAccessory.TextFieldWrapper.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import UIKit
import ButtonConfig


extension InputAccessory {
    
    class TextFieldWrapper: UITextField {
        
        internal var action: (() -> ())?
        internal var viewId: String?
        internal var toolBarColor: UIColor?
        internal var toolBarTintColor: UIColor?
        internal var doneButtonImageName: String?
        internal var leftButtons: [ImageButtonConfig] = []
        internal var rightButtons: [ImageButtonConfig] = []
        internal var insets = UIEdgeInsets.zero
        
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: insets)
        }
        
        override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: insets)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: insets)
        }
    }
}
