//
//  InputAccessory.ToolBar.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import SwiftUI
import ButtonConfig


extension InputAccessory {
    
    struct ToolBar: View {
        
        var textFields = [TextFieldWrapper]() {
            didSet {
                textFields.sort(by: {$0.tag < $1.tag})
            }
        }
        
        var currentTextFieldTag = 0
        
        static var barHeight: CGFloat {
            let size = fontSize(for: .title)
            return size * 1.571
        }
        
        var body: some View {
            
            ZStack {
                
                Rectangle()
                    .foregroundColor(barColor())
                    .frame(height: Self.barHeight)
                
                HStack {
                    
                    Button(action: previousTextField, label: {
                        Image(.chevronLeft)
                            .font(Font.title.weight(.semibold))
                            .accentColor(buttonColor())
                    })
                    .opacity(previousButtonOpacity())
                    .disabled(currentIndex() == 0)
                    .padding()
                    
                    Button(action: nextTextField, label: {
                        Image(.chevronRight)
                            .font(Font.title.weight(.semibold))
                            .accentColor(buttonColor())
                    })
                    .opacity(nextButtonOpacity())
                    .disabled(currentIndex() == textFields.count - 1)
                    
                    leftButtons()
                    
                    Spacer()
                    
                    rightButtons()
                    
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
        
        private func doneButtonImage() -> some View {
            
            let imageName: String
            
            if let currentIndex = currentIndex() {
                let textField = textFields[currentIndex]
                imageName = InputAccessory.dismissKeyboardButtonSystemImageName ?? textField.doneButtonImageName ?? Image.SystemName.keyboardDismiss.systemImageName
            } else {
                imageName = InputAccessory.dismissKeyboardButtonSystemImageName ?? Image.SystemName.keyboardDismiss.systemImageName
            }
            
            return Image(systemName: imageName)
                .font(Font.title.weight(.semibold))
                .accentColor(buttonColor())
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
        
        @ViewBuilder
        private func leftButtons() -> some View {
            
            if let currentIndex = currentIndex() {
                
                let textField = textFields[currentIndex]
                
                HStack {
                    ForEach(textField.leftButtons) {
                        FWImageButton($0)
                            .font(Font.title.weight(.semibold))
                            .accentColor(buttonColor())
                    }
                }
            }
        }
        
        @ViewBuilder
        private func rightButtons() -> some View {
            
            if let currentIndex = currentIndex() {
                
                let textField = textFields[currentIndex]
                
                HStack {
                    ForEach(textField.rightButtons) {
                        FWImageButton($0)
                            .font(Font.title.weight(.semibold))
                            .accentColor(buttonColor())
                    }
                }
            }
        }
    }
}


fileprivate extension InputAccessory.ToolBar {
    
    private static let fontSizes: [Font.TextStyle: CGFloat] = [
        .largeTitle: 34,
        .title: 28,
        .title2: 22,
        .title3: 20,
        .headline: 17,
        .body: 17,
        .callout: 16,
        .subheadline: 15,
        .footnote: 13,
        .caption: 12,
        .caption2: 11
    ]
    
    static func fontSize(for style: Font.TextStyle) -> CGFloat {
        guard let size = fontSizes[style] else {
            return 12
        }
        let scale = UIFontMetrics.default.scaledValue(for: size)
        return size * scale / size
    }
}
