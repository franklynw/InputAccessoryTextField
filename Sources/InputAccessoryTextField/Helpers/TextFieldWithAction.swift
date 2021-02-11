//
//  TextFieldWithAction.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import UIKit


public class TextFieldWithAction: UITextField {
    
    internal var action: (() -> ())?
    internal var viewId: String?
    internal var doneButtonImageName: String?
    internal var insets = UIEdgeInsets.zero
    
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    deinit {
        TextFieldManager.shared.removeController(forViewId: viewId)
    }
}
