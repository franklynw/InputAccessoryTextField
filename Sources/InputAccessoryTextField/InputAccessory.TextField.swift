//
//  InputAccessory.TextField.swift
//
//  Based on work by Swift Student - https://swiftstudent.com/2020-01-15-swiftui-inputaccessoryview/
//  Built on by Franklyn Weber on 01/02/2021.

import SwiftUI
import FWCommonProtocols


extension InputAccessory {
    
    public struct TextField<I: Identifiable>: UIViewRepresentable where I.ID == String {
        
        @Binding private var text: String
        
        internal var placeholder: PlaceHolder?
        internal var font: UIFont?
        internal var foregroundColor: Color?
        internal var backgroundColor: Color?
        internal var toolBarColor: Color?
        internal var toolBarTintColor: Color?
        internal var keyboardType: UIKeyboardType?
        internal var returnKeyType: UIReturnKeyType?
        internal var disableAutocorrection = false
        internal var autocapitalization: UITextAutocapitalizationType = .sentences
        internal var _showsClearButton = false
        internal var insets = EdgeInsets()
        internal var returnKeyAction: (() -> ())?
        internal var keyboardDismissButtonAction: (() -> ())?
        internal var doneButtonImageName: SystemImageNaming?
        internal var _hideToolBar = false
        
        internal let accessoryController: Controller
        internal let tag: Int?
        
        private let viewId: String
        
        
        public enum PlaceHolder {
            case text(String)
            case attributed(NSAttributedString)
        }
        
        
        /// Initialiser for InputAccessoryTextField
        /// - Parameters:
        ///   - view: the parent view (usually the main view for the screen) - must conform to Identifiable, where id is a String
        ///   - tag: a tag which is used if you want to enable tabbing between textFields
        ///   - text: a binding to the String var for the input
        public init(parentView view: I, tag: Int? = nil, text: Binding<String>) {
            viewId = view.id
            self.accessoryController = TextFieldManager.shared.controller(forViewId: viewId)
            self.tag = tag
            self._text = text
        }
        
        public func makeCoordinator() -> TextField.Coordinator {
            return Coordinator(self)
        }
        
        public func makeUIView(context: UIViewRepresentableContext<TextField>) -> UITextField {
            
            let textField = TextFieldWrapper()
            textField.delegate = context.coordinator
            
            textField.viewId = viewId
            textField.action = keyboardDismissButtonAction
            textField.doneButtonImageName = doneButtonImageName?.systemImageName
            textField.insets = UIEdgeInsets(top: insets.top, left: insets.leading, bottom: insets.bottom, right: insets.trailing)
            
            if !_hideToolBar {
                textField.inputAccessoryView = accessoryController.view
            }
            
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
            if let backgroundColor = backgroundColor {
                textField.backgroundColor = backgroundColor.uiColor
            }
            if let toolBarColor = toolBarColor {
                textField.toolBarColor = toolBarColor.uiColor
            }
            if let toolBarTintColor = toolBarTintColor {
                textField.toolBarTintColor = toolBarTintColor.uiColor
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
        
        public func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextField>) {
            
            let textField = uiView
            
            textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
            textField.setContentCompressionResistancePriority(.required, for: .vertical)
            textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            
            switch placeholder {
            case .text(let placeholder):
                textField.placeholder = placeholder
            case .attributed(let attributedPlaceHolder):
                textField.attributedPlaceholder = attributedPlaceHolder
            case .none:
                break
            }
            
            textField.text = text
            textField.font = font
        }
        
        public static func dismantleUIView(_ uiView: UITextField, coordinator: TextField.Coordinator) {
            coordinator.parent.accessoryController.removeTextField(uiView)
        }
        
        
        public class Coordinator: NSObject, UITextFieldDelegate {
            
            var parent: TextField
            
            init(_ parent: TextField) {
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
                parent.returnKeyAction?()
                return true
            }
        }
    }
}
