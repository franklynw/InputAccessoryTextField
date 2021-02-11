//
//  Controller.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import SwiftUI


internal class Controller: UIHostingController<InputAccessoryView> {
    
    private var hasStartedInput = false
    
    convenience init () {
        self.init(rootView: InputAccessoryView())
    }
    
    private override init(rootView: InputAccessoryView) {
        super.init(rootView: rootView)
        view.frame = CGRect(x: 0, y: 0, width: 0 , height: InputAccessoryView.barHeight)
    }
    
    @objc
    required dynamic init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
    }

    func addTextField(_ textField: TextFieldWithAction) {
        rootView.textFields.append(textField)
    }
    
    func removeTextField(_ textField: TextFieldWithAction) {
        rootView.textFields.removeAll(where: {$0 == textField})
    }
    
    func setCurrentTextFieldTag(_ tag: Int) {
        rootView.currentTextFieldTag = tag
    }
    
    func advanceToNextTextField() {
        rootView.nextTextField()
    }
    
    func startInput(_ tag: Int) {
        
        // this needs to be done after the view has laid out all of its textFields
        
        guard !hasStartedInput else {
            return
        }
        
        hasStartedInput = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            guard tag < self.rootView.textFields.count else {
                return
            }
            self.rootView.textFields[tag].becomeFirstResponder()
        }
    }
    
    func endInput() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.rootView.textFields.forEach { $0.resignFirstResponder() }
        }
    }
}
