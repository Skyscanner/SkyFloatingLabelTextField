v1.2.0

* Added RTL language support
* Changed the behaviour of `errorMessage`, removing unnecessary business logic.
  * Before this change there was some "hidden" business logic around the resetting of errorMessage, namely:
    * Whenever the control was selected by a user, it got cleared (becomeFirstResponder invoked)
    * Whenever the text changed, it also got reset (when `textField(textField:,range:string:)` was invoked)
  * After this change what's different:
    * The errorMessage is no longer reset by any text or focus changes. If a developer sets this message, the error will be displayed, until this property is cleared. To implement the previous functionality, just subscribe to the `textField(textField:,range:string:)` event on the delegate
    * As a side effect of this, the workaround of double-invoking `textField(textField:,range:string:)` has been removed, fixing the bug raised by [this Issue](https://github.com/Skyscanner/SkyFloatingLabelTextField/issues/27)

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
