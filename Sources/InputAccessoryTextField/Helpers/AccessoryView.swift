//
//  AccessoryView.swift
//  
//
//  Created by Franklyn Weber on 03/02/2021.
//

import SwiftUI


internal struct AccessoryView: View {
    
    var textFields = [TextFieldWithAction]() {
        didSet {
            textFields.sort(by: {$0.tag < $1.tag})
        }
    }
    
    var currentTextFieldTag = 0
    
    var body: some View {
        
        HStack {
            
            Button(action: previousTextField, label: {
                Image(.chevronLeft)
                    .resizable()
                    .frame(width: 18, height: 27)
                    .font(Font.title.weight(.semibold))
                    .accentColor(Color(.lightGray))
            })
            .opacity(previousButtonOpacity())
            .disabled(currentIndex() == 0)
            .padding()
            
            Button(action: nextTextField, label: {
                Image(.chevronRight)
                    .resizable()
                    .frame(width: 18, height: 27)
                    .font(Font.title.weight(.semibold))
                    .accentColor(Color(.lightGray))
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
            imageName = textField.doneButtonImageName ?? Image.SystemName.keyboardDismiss.imageName
        } else {
            imageName = Image.SystemName.keyboardDismiss.imageName
        }
        
        // because the system images have varying aspect ratios, if we put it in an HStack with some space
        // & contentMode .fit it'll be the size we want with its original aspect ratio
        
        let image = HStack {
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .font(Font.title.weight(.semibold))
                .accentColor(Color(.lightGray))
                .aspectRatio(contentMode: .fit)
                .frame(alignment: .trailing)
        }
        .frame(width: 100, height: 26)
        
        return AnyView(image)
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
