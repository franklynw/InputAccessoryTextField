//
//  InputAccessoryTextField.swift
//
//  Based on work by Swift Student - https://swiftstudent.com/2020-01-15-swiftui-inputaccessoryview/
//  Built on by Franklyn Weber on 01/02/2021.

import SwiftUI
import FWCommonProtocols


public struct InputAccessoryTextField<I: Identifiable>: UIViewRepresentable where I.ID == String {
    
    @Binding private var text: String
    
    internal var placeholder: String?
    internal var font: UIFont?
    internal var foregroundColor: Color?
    internal var keyboardType: UIKeyboardType?
    internal var returnKeyType: UIReturnKeyType?
    internal var disableAutocorrection = false
    internal var autocapitalization: UITextAutocapitalizationType = .sentences
    internal var _showsClearButton = false
    internal var commitAction: (() -> ())?
    internal var doneButtonImageName: SystemImageNaming?
    
    internal let accessoryController: Controller
    internal let tag: Int?
    
    private let viewId: String
    
    
    /// Initialiser for InputAccessoryTextField
    /// - Parameters:
    ///   - view: the parent view (usually the main view for the screen) - must conform to Identifiable, where id is a String
    ///   - tag: a tag which is used if you want to enable tabbing between textFields
    ///   - placeholder: the placeholder text
    ///   - text: a binding to the String var for the input
    public init(parentView view: I, tag: Int? = nil, placeholder: String? = nil, text: Binding<String>) {
        viewId = view.id
        self.accessoryController = TextFieldManager.shared.controller(forViewId: viewId)
        self.tag = tag
        self.placeholder = placeholder
        self._text = text
    }
    
    public func makeCoordinator() -> InputAccessoryTextField.Coordinator {
        return Coordinator(self)
    }
    
    public func makeUIView(context: UIViewRepresentableContext<InputAccessoryTextField>) -> TextFieldWithAction {
        
        let textField = TextFieldWithAction()
        textField.delegate = context.coordinator
        
        textField.viewId = viewId
        textField.action = commitAction
        textField.doneButtonImageName = doneButtonImageName?.systemImageName
        
        textField.inputAccessoryView = accessoryController.view
        textField.autocorrectionType = disableAutocorrection ? .no : .yes
        textField.autocapitalizationType = autocapitalization
        
        if let tag = tag {
            textField.tag = tag
        }
        if let font = font {
            textField.font = font
        }
        if let foregroundColor = foregroundColor {
            textField.textColor = foregroundColor.uiColor
        }
        if let keyboardType = keyboardType {
            textField.keyboardType = keyboardType
        }
        if let returnKeyType = returnKeyType {
            textField.returnKeyType = returnKeyType
        }
        if _showsClearButton {
            textField.clearButtonMode = .whileEditing
        }
        
        accessoryController.addTextField(textField)
        
        return textField
    }
    
    public func updateUIView(_ uiView: TextFieldWithAction, context: UIViewRepresentableContext<InputAccessoryTextField>) {
        
        let textField = uiView
        
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        textField.setContentCompressionResistancePriority(.required, for: .vertical)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        textField.placeholder = placeholder
        textField.text = text
        textField.font = font
    }
    
    public static func dismantleUIView(_ uiView: TextFieldWithAction, coordinator: InputAccessoryTextField.Coordinator) {
        coordinator.parent.accessoryController.removeTextField(uiView)
    }
    
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        
        var parent: InputAccessoryTextField
        
        init(_ parent: InputAccessoryTextField) {
            self.parent = parent
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.accessoryController.setCurrentTextFieldTag(textField.tag)
        }
        
        public func textFieldDidChangeSelection(_ textField: UITextField) {
            if let text = textField.text {
                parent.text = text
            }
        }
        
        public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            parent.commitAction?()
            return true
        }
    }
}
