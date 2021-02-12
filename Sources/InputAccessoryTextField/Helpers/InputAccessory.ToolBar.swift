//
//  InputAccessory.ToolBar.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import SwiftUI


extension InputAccessory {
    
    struct ToolBar: View {
        
        var textFields = [TextFieldWrapper]() {
            didSet {
                textFields.sort(by: {$0.tag < $1.tag})
            }
        }
        
        var currentTextFieldTag = 0
        
        static let barHeight: CGFloat = 44
        
        var body: some View {
            
            ZStack {
                
                Rectangle()
                    .foregroundColor(barColor())
                    .frame(height: Self.barHeight)
                
                HStack {
                    
                    Button(action: previousTextField, label: {
                        Image(.chevronLeft)
                            .resizable()
                            .frame(width: 18, height: 27)
                            .font(Font.title.weight(.semibold))
                            .accentColor(buttonColor())
                    })
                    .opacity(previousButtonOpacity())
                    .disabled(currentIndex() == 0)
                    .padding()
                    
                    Button(action: nextTextField, label: {
                        Image(.chevronRight)
                            .resizable()
                            .frame(width: 18, height: 27)
                            .font(Font.title.weight(.semibold))
                            .accentColor(buttonColor())
                    })
                    .opacity(nextButtonOpacity())
                    .disabled(currentIndex() == textFields.count - 1)
                    
                    Spacer()
                    
                    Button(action: dismissCurrentTextField, label: {
                        doneButtonImage()
                    })
                    .padding()
                    
                }
                .accentColor(.blue)
            }
        }
        
        func currentIndex() -> Int? {
            textFields.firstIndex {$0.tag == self.currentTextFieldTag}
        }
        
        func nextTextField() {
            if let currentIndex = currentIndex() {
                textFields[currentIndex + 1].becomeFirstResponder()
            }
        }
        
        func previousTextField() {
            if let currentIndex = currentIndex() {
                textFields[currentIndex - 1].becomeFirstResponder()
            }
        }
        
        func dismissCurrentTextField() {
            
            guard let currentIndex = currentIndex() else {
                return
            }
            
            let textField = textFields[currentIndex]
            
            textField.resignFirstResponder()
            textField.action?()
        }
        
        private func doneButtonImage() -> AnyView {
            
            let imageName: String
            
            if let currentIndex = currentIndex() {
                let textField = textFields[currentIndex]
                imageName = InputAccessory.dismissKeyboardButtonSystemImageName ?? textField.doneButtonImageName ?? Image.SystemName.keyboardDismiss.systemImageName
            } else {
                imageName = InputAccessory.dismissKeyboardButtonSystemImageName ?? Image.SystemName.keyboardDismiss.systemImageName
            }
            
            // because the system images have varying aspect ratios, if we put it in an HStack with some space
            // & contentMode .fit it'll be the size we want with its original aspect ratio
            
            let image = HStack {
                Spacer()
                Image(systemName: imageName)
                    .resizable()
                    .font(Font.title.weight(.semibold))
                    .accentColor(buttonColor())
                    .aspectRatio(contentMode: .fit)
                    .frame(alignment: .trailing)
            }
            .frame(width: 100, height: 26)
            
            return AnyView(image)
        }
        
        private func buttonColor() -> Color? {
            
            guard let currentIndex = currentIndex() else {
                return InputAccessory.barTintColor ?? Color(.lightGray)
            }
            
            let textField = textFields[currentIndex]
            
            guard let toolBarTintColor = textField.toolBarTintColor else {
                return InputAccessory.barTintColor ?? Color(.lightGray)
            }
            
            return Color(toolBarTintColor)
        }
        
        private func barColor() -> Color? {
            
            guard let currentIndex = currentIndex() else {
                return InputAccessory.barColor ?? Color(.systemBackground)
            }
            
            let textField = textFields[currentIndex]
            
            guard let toolBarColor = textField.toolBarColor else {
                return InputAccessory.barColor ?? Color(.systemBackground)
            }
            
            return Color(toolBarColor)
        }
        
        private func previousButtonOpacity() -> Double {
            
            if textFields.count == 1 {
                return 0
            }
            
            return currentIndex() == 0 ? 0.2 : 1
        }
        
        private func nextButtonOpacity() -> Double {
            
            if textFields.count == 1 {
                return 0
            }
            
            return currentIndex() == textFields.count - 1 ? 0.2 : 1
        }
    }
}
