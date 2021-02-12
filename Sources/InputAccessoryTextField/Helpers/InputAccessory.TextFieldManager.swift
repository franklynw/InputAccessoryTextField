//
//  InputAccessory.TextFieldManager.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import Foundation


extension InputAccessory {
    
    internal class TextFieldManager {
        
        static let shared = TextFieldManager()
        
        private var controllers: [String: Controller] = [:]
        
        func controller(forViewId viewId: String) -> Controller {
            
            guard let controller = controllers[viewId] else {
                let controller = Controller()
                controllers[viewId] = controller
                return controller
            }
            
            return controller
        }
        
        func removeController(forViewId viewId: String?) {
            guard let viewId = viewId else {
                return
            }
            controllers.removeValue(forKey: viewId)
        }
    }
}
