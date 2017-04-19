Master
------

### Improvements

* Made `isLTRLanguage` `open` so it can actually be set by users [#121](https://github.com/Skyscanner/SkyFloatingLabelTextField/pull/121).
* Silence warnings due to `M_PI` being deprecated in Xcode 8.3 [#116](https://github.com/Skyscanner/SkyFloatingLabelTextField/pull/116). Thanks to [@z3bi](https://github.com/z3bi).
* Adds UIAppearance support [#118](https://github.com/Skyscanner/SkyFloatingLabelTextField/pull/118). Thanks to [mwfire](https://github.com/mwfire).
* Fix for RTL issue while editing texts [#126](https://github.com/Skyscanner/SkyFloatingLabelTextField/pull/126). Thanks to [@mehrdadmaskull](https://github.com/Mehrdadmaskull)

### No Functional Change

* Added swiftlint and cleaned up the source code to conform with it [#125](https://github.com/Skyscanner/SkyFloatingLabelTextField/pull/125). Thanks to [@moogle19](https://github.com/moogle19)

v3.0.0
-----------------

### Breaking

Change implementation of amimation callbacks to include boolean completed flag.

#### Before
```swift
textfield.setTitleVisible(false, animated: true) {
	// Perform callback actions
}
```

#### Now

```swift
textfield.setTitleVisible(false, animated: true) { completed in
	// Perform callback actions using completed flag
}
```

See [#112](https://github.com/Skyscanner/SkyFloatingLabelTextField/pull/112)

v2.0.1
------

* Added `@discardableResult` to `becomeFirstResponder` and `resignFirstResponder`. This silences Xcode warnings about unused results of those functions and brings the implementation closer to the iOS API [#98](https://github.com/Skyscanner/SkyFloatingLabelTextField/pull/98). Thanks to [bennokress](https://github.com/bennokress)
* Disable `GCC_GENERATE_TEST_COVERAGE_FILES` and `GCC_INSTRUMENT_PROGRAM_FLOW_ARCS` in release configs. This was causing rejections when submitting to Apple when the library is integrated manually or with Carthage [#97](https://github.com/Skyscanner/SkyFloatingLabelTextField/pull/97). Thanks to [vytautasgimbutas](https://github.com/vytautasgimbutas)

v2.0
----

+ Adds swift 3 support. Thanks to [@DenHeadless](https://github.com/DenHeadless). See [#67](https://github.com/Skyscanner/SkyFloatingLabelTextField/pull/67)

v1.2.1
-----

* Bugfix: title was blinking when tapping the textfield.

v1.2.0
------

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
