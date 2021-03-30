# InputAccessoryTextField

A (almost) drop-in replacement for SwiftUI's TextField, but with a customisable input accessory view.
A significant part of this is based on work by Swift Student - [SwiftUI InputAccessoryView](https://swiftstudent.com/2020-01-15-swiftui-inputaccessoryview/) - but I've removed the need for an accessoryViewController instance in the containing view, and added quite a bit in the way of customisation options for the consumer.

<img src="Resources//Example1.png" alt="Example 1"/>

## Installation

### Swift Package Manager

In Xcode:
* File ⭢ Swift Packages ⭢ Add Package Dependency...
* Use the URL https://github.com/franklynw/InputAccessoryTextField.git


## Example

> **NB:** All examples require `import InputAccessoryTextField` at the top of the source file

The only additional requirement for using an InputAccessoryTextField instead of a TextField is that the containing view conforms to Identifiable, with a String id.

```swift
var body: some View {

    InputAccessoryTextField(parentView: self, tag: 1, text: viewModel.searchTerm)
        .returnKey(type: .search) {
            viewModel.beginSearch()
        }
        .foregroundColor(Color(viewModel.titleColor))
        .disableAutocorrection(!viewModel.autocorrect)
        .autocapitalization(viewModel.itemCapitalizationPolicy)
        .startInput()
}
```

To use with the "previous" and "next" buttons on the accessory view, each textField in the view needs to have a unique tag. Pressing "next" will show the field with the next-highest tag, pressing "previous" will show the field with the next lowest. If there is only one textField, these buttons will be hidden.

There are some additional features apart from the input accessory view -

### Placeholder

You can set the textField's placeholder text. The placeholder is an Enum case, "PlaceHolder", which allows for a normal String - .text("My placeholder") - or an attributed string - .attributed(myNSAttributedString), which lets you specify colour, etc

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .placeholder(.text("Enter search text"))
```

or 

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .placeholder(.attributed(viewModel.attributedPlaceholder))
```

### Font

You can set the textField's font using either a UIFont, or with Font.TextStyle & Font.Weight

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .font(UIFont.systemFont(ofSize: 18, weight: .semibold))
```

or

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .font(.title, weight: .semibold)
```

### Text colour

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .foregroundColor(.red)
```

### Background colour

Set the background colour of the textField

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .backgroundColor(.lightGray)
```

### ToolBar background colour

Set the background colour of the textField's input accessory view ToolBar

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .toolBarColor(.lightGray)
```

or using the static var (once per view rather than for each textField) - 

```swift
InputAccessory.barColor = .purple
```

### ToolBar tint colour

Set the colour of the textField's input accessory view buttons

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .toolBarTintColor(.darkGray)
```

or using the static var (once per view rather than for each textField) - 

```swift
InputAccessory.barTintColor = .green
```

###  Keyboard Type

You can set the keyboard type -

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .keyboardType(.numberPad)
```

### Return Key Type

You can set the return key type and its action -

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .returnKey(type: .search) {
        viewModel.beginSearch()
    }
```

### Show the "Clear" button (while editing)

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .showsClearButton
```

### Autocorrection

Autocorrection can be switched on or off -

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .disableAutocorrection(!viewModel.autocorrect)
```

### Autocapitalisation

The autocapitalisation policy can be set -

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .autocapitalization(viewModel.autocapitalizationPolicy)
```

### Set the insets (the padding around the text within the textField)

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .insets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
```

### Become first responder

You can make the textField automatically become the first resonder (ie, it brings up the keyboard as soon as it appears) -

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .startInput($viewModel.startEditing)
```

This modifier can also take a Bool binding to become first responder on demand.

or -

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .startInput
```

This version of the modifier will simply make the textField become the first responder when it appears.


### Resign first responder

Adding this modifier & passing in true will resign the first responder from the tagged InputAccessoryTextField which is currently the first responder

```swift
InputAccessoryTextField(parentView: self, tag: 1, text: viewModel.searchTerm)
    .endInput(shouldEndInput)
```

### Customise the "Done" button on the input accessory view

Pass in a system image name to use that for the button. You can also set the action to be invoked when the button is pressed, in addition to it dismissing the keyboard. If no image is specified, it will default to "keyboard.chevron.compact.down"

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .toolBarDoneButton("rectangle.and.pencil.and.ellipsis") {
        // do something
    }
```

You can also use the static var (once per view rather than for each textField) to set the done button image - 

```swift
InputAccessory.dismissKeyboardButtonSystemImageName = "checkmark"
```

### Put additional buttons on the toolBar

You can add a button towards the left and/or the right of the toolBar

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .additionalLeftButton(buttonConfig)
    .additionalRightButton(otherButtonConfig)
```

### Hide the accessory view

Sometimes you may want to hide the accessory view, while still keeping all the other features of the InputAccessoryTextField -

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .hideToolBar
```

### Respond to editing ended

Perform an action when the textField ends editing

```swift
InputAccessoryTextField(parentView: self, text: viewModel.searchTerm)
    .editingEnded { text in
        // do stuff
    }
```

## Dependencies

Requires FWCommonProtocols, which is linked. GitHub page is [here](https://github.com/franklynw/FWCommonProtocols)


## Licence  

`InputAccessoryTextField` is available under the MIT licence
