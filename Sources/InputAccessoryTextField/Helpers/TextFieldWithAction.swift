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
    
    deinit {
        TextFieldManager.shared.removeController(forViewId: viewId)
    }
}
