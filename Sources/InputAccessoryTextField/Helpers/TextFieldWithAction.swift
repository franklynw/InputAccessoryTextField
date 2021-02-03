//
//  TextFieldWithAction.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import UIKit


private var actionAssociatedKey: UInt8 = 0
private var viewIdAssociatedKey: UInt8 = 0
private var doneButtonAssociatedKey: UInt8 = 0

public class TextFieldWithAction: UITextField {
    
    internal var action: (() -> ())? {
        get {
            return objc_getAssociatedObject(self, &actionAssociatedKey) as? () -> ()
        }
        set {
            objc_setAssociatedObject(self, &actionAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    internal var viewId: String? {
        get {
            return objc_getAssociatedObject(self, &viewIdAssociatedKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &viewIdAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    internal var doneButtonImageName: String? {
        get {
            return objc_getAssociatedObject(self, &doneButtonAssociatedKey) as? String
        }
        set {
            objc_setAssociatedObject(self, &doneButtonAssociatedKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    deinit {
        TextFieldManager.shared.removeController(forViewId: viewId)
    }
}
