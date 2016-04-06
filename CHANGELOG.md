v1.1.1
----------
* Bugfix: setting the error message via the `textField?(shouldChangeCharactersInRange:replacementString:)` method is now possible
* Added example on how to use the control from Objective C

v1.1
----------
* Changed the control to inherit from the `UITextField` class (previously the control inherited from `UIControl`)
* The delegate to use with the textfield is now the `UITextFieldDelegate` (removed the `delegate:SkyFloatingLabelTextFieldDelegate` class)
* Removed `placeHolderLabel`, `textField` and `hasText` properties from `SkyFloatingLabelTextField` class
* Removed `textRectForBounds(bounds: CGRect)` and `placeholderLabelRectForBounds(bounds:CGRect)` methods from `SkyFloatingLabelTextField`
* The above methods have been replaced with the `UITextfield` methods `editingRectForBounds(bounds: CGRect)` and `placeholderRectForBounds(bounds: CGRect)` on `SkyFloatingLabelTextField`
* Added `placeholderFont`, `editingOrSelected` properties to `SkyFloatingLabelTextField` class

v1.0.6
----------
* Removed the hideKeyboardWhenSelected property. This property seemed too specific. To hide the keyboard when selecting a field, an alternative workaround is to set the textField.inputView property to an empty view.

v1.0.5
----------
* Added the hideKeyboardWhenSelected property
* Bugfix: When invoking becomeFirstResponder on a textField that was not yet visible, the keyboard did not show up.

v1.0.4
----------
* Updated the description of the pod

v1.0.1
----------
* Added support for Swift package manager

v1.0.0
----------
* Initial release
