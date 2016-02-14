//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import XCTest
@testable import SkyFloatingLabelTextField

class SkyFloatingLabelTextFieldTests: XCTestCase {
    
    var floatingLabelTextField: SkyFloatingLabelTextField!
    let customColor = UIColor(red: 125/255, green: 120/255, blue: 50/255, alpha: 1.0)
    let textFieldDelegateMock = TextFieldDelegateMock()
    
    override func setUp() {
        super.setUp()
        floatingLabelTextField = SkyFloatingLabelTextField(frame: CGRectMake(0, 0, 200, 50))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK:  - Colors
    
    func test_whenSettingTextColor_thenTextFieldTextColorIsChangedToThisColor() {
        // when
        floatingLabelTextField.textColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.textField.textColor, self.customColor)
    }
    
    func test_whenSettingPlaceholderColor_thenPlaceholderLabelTextColorIsChangedToThisColor() {
        // when
        floatingLabelTextField.placeholderColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.placeholderLabel.textColor, self.customColor)
    }
    
    func test_whenSettingTitleColor_thenTitleLabelTextColorIsChangedToThisColor() {
        // when
        floatingLabelTextField.titleColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.textColor, self.customColor)
    }
    
    func test_whenSettingLineColor_thenLineViewBackgroundColorIsChangedToThisColor() {
        // when
        floatingLabelTextField.lineColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.backgroundColor, self.customColor)
    }
    
    func test_whenSettingErrorColor_withErrorMessageBeingSet_thenTitleLabelTextColorIsChangedToThisColor() {
        // given
        floatingLabelTextField.errorMessage = "test"
        
        // when
        floatingLabelTextField.errorColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.textColor, self.customColor)
    }
    
    func test_whenSettingErrorColor_withErrorMessageBeingSet_thenLineViewBackgroundColorIsChangedToThisColor() {
        // given
        floatingLabelTextField.errorMessage = "test"
        
        // when
        floatingLabelTextField.errorColor = self.customColor
        
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.backgroundColor, self.customColor)
    }
    
    func test_whenSettingSelectedTitleColor_withTextfieldBeingSelected_thenTitleLabelTextColorIsChangedToThisColor() {
        // given
        floatingLabelTextField.selected = true
        
        // when
        floatingLabelTextField.selectedTitleColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.textColor, self.customColor)
    }
    
    func test_whenSettingSelectedLineColor_withTextfieldBeingSelected_thenLineViewBackgroundColorIsChangedToThisColor() {
        // given
        floatingLabelTextField.selected = true
        
        // when
        floatingLabelTextField.selectedLineColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.backgroundColor, self.customColor)
    }
    
    
    // MARK:  - Line height
    
    func test_whenSettingLineHeight_thenLineViewHeightIsChangedToThisValue() {
        // when
        floatingLabelTextField.lineHeight = 3
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.frame.size.height, 3)
    }
    
    func test_whenSettingSelectedLineHeight__withTextFieldBeingSelected_thenLineViewHeightIsChangedToThisValue() {
        // given
        floatingLabelTextField.selected = true
        
        // when
        floatingLabelTextField.selectedLineHeight = 4
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.frame.size.height, 4)
    }
    
    // MARK:  - hasText
    
    func test_hasText_whenTextPropertyIsNotEmpty_thenReturnsTrue() {
        // given
        floatingLabelTextField.text = "hello";
        
        // then
        XCTAssertTrue(floatingLabelTextField.hasText)
    }
    
    func test_hasText_whenTextPropertyIsEmpty_thenReturnsFalse() {
        // given
        floatingLabelTextField.text = "";
        
        // then
        XCTAssertFalse(floatingLabelTextField.hasText)
    }
    
    // MARK:  - highlighted
    
    func test_whenSettingHighighted_toTrue_thenTitleAlphaIsOne() {
        // given
        floatingLabelTextField.highlighted = true;
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 1.0)
    }
    
    func test_whenSettingHighighted_toTrue_thenTitleAlphaIsVisible() {
        // given
        floatingLabelTextField.highlighted = true;
        
        // then
        XCTAssertTrue(floatingLabelTextField.titleVisible)
    }
    
    func test_whenSettingHighighted_toFalse_then_afterOneSecond_titleAlphaIsZero() {
        // given
        let expectation = self.expectationWithDescription("")
        
        // when
        floatingLabelTextField.highlighted = false;
        
        self.delay(1.0, callback: { () -> Void in
            // then
            XCTAssertEqual(self.floatingLabelTextField.titleLabel.alpha, 0.0)
            expectation.fulfill()
        })

        self.failOnTimeoutAfterSeconds(5)
    }
    
    func test_whenSettingHighighted_toFalse_then_afterOneSecond_titleIsNotVisible() {
        // given
        let expectation = self.expectationWithDescription("")
        
        // when
        floatingLabelTextField.highlighted = false;
        
        self.delay(1.0, callback: { () -> Void in
            // then
            XCTAssertFalse(self.floatingLabelTextField.titleVisible)
            expectation.fulfill()
        })
        
        self.failOnTimeoutAfterSeconds(5)
    }
    
    // MARK:  - placeholder
    
    func test_whenSettingPlaceholder_thenPalceholderLabelTextIsUpdated() {
        // when
        floatingLabelTextField.placeholder = "testPlaceHolder"
        
        // then
        XCTAssertEqual(floatingLabelTextField.placeholderLabel.text, "testPlaceHolder")
    }
    
    // MARK:  - selectedTitle
    
    func test_whenTitleAndSelectedTitleAreSet_withControlNotBeingSelected_thenTitleLabelDisplaysUppercaseTitle() {
        // given
        floatingLabelTextField.selected = false
        
        // when
        floatingLabelTextField.title = "title"
        floatingLabelTextField.selectedTitle = "selectedTitle"
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "TITLE")
    }
    
    func test_whenTitleAndSelectedTitleAreSet_withControlBeingSelected_thenTitleLabelDisplaysUppercaseSelectedTitle() {
        // given
        floatingLabelTextField.selected = true
        
        // when
        floatingLabelTextField.title = "title"
        floatingLabelTextField.selectedTitle = "selectedTitle"
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "SELECTEDTITLE")
    }
    
    // MARK:  - textField properties
    
    func test_whenSettingSecureTextEntry_thenTextFieldSecureTextEntryPropertyIsChangedToThisValue() {
        // given
        XCTAssertFalse(floatingLabelTextField.textField.secureTextEntry)
        
        // when
        floatingLabelTextField.secureTextEntry = true
        
        // then
        XCTAssertTrue(floatingLabelTextField.textField.secureTextEntry)
    }
    
    func test_whenGettingEnabledValue_thenReturnsPreviouslySetValue() {
        // given
        XCTAssertTrue(floatingLabelTextField.enabled)
        
        // when
        floatingLabelTextField.enabled = false
        
        // then
        XCTAssertFalse(floatingLabelTextField.enabled)
    }
    
    func test_whenSettingEnabled_thenTextFieldEnabledPropertyIsChangedToThisValue() {
        // given
        XCTAssertTrue(floatingLabelTextField.textField.enabled)
        
        // when
        floatingLabelTextField.enabled = false
        
        // then
        XCTAssertFalse(floatingLabelTextField.textField.enabled)
    }
    
    // MARK:  - init
    
    func test_whenIntiializingWithCoder_thenTextfieldUIElementsAreCreated() {
        // given
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.finishEncoding()
        let coder = NSKeyedUnarchiver(forReadingWithData: data)
        
        // when
        floatingLabelTextField = SkyFloatingLabelTextField(coder: coder)
        
        // then
        XCTAssertNotNil(floatingLabelTextField.titleLabel)
        XCTAssertNotNil(floatingLabelTextField.textField)
        XCTAssertNotNil(floatingLabelTextField.placeholderLabel)
        XCTAssertNotNil(floatingLabelTextField.lineView)
    }
    
    // MARK: - Textfield delegate methods
    
    // MARK: textFieldShouldBeginEditing
    
    func test_whenTextFieldShouldBeginEditingInvoked_withNilDelegate_thenReturnsTrue() {
        // given
        floatingLabelTextField.delegate = nil
        
        // when
        let result = floatingLabelTextField.textFieldShouldBeginEditing(floatingLabelTextField.textField)
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_whenTextFieldShouldBeginEditingInvoked_withDelegateThatDoesNotImplementTextFieldShouldBeginEditing_thenReturnsTrue() {
        // given
        floatingLabelTextField.delegate = EmptyTextFieldDelegate()
        
        // when
        let result = floatingLabelTextField.textFieldShouldBeginEditing(floatingLabelTextField.textField)
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_whenTextFieldShouldBeginEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.textFieldShouldBeginEditing(floatingLabelTextField.textField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldBeginEditingInvoked)
    }
    
    // MARK: textFieldDidBeginEditing
    
    func test_whenTextFieldDidBeginEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        floatingLabelTextField.textFieldDidBeginEditing(floatingLabelTextField.textField)
        
        // then
        XCTAssertTrue(textFieldDelegateMock.textFieldDidBeginEditingInvoked)
    }
    
    // MARK: textFieldShouldEndEditing
    
    func test_whenTextFieldShouldEndEditingInvoked_withNilDelegate_thenReturnsTrue() {
        // given
        floatingLabelTextField.delegate = nil
        
        // when
        let result = floatingLabelTextField.textFieldShouldEndEditing(floatingLabelTextField.textField)
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_whenTextFieldShouldEndEditing_withDelegateThatDoesNotImplementTextFieldShouldBeginEditing_thenReturnsTrue() {
        // given
        floatingLabelTextField.delegate = EmptyTextFieldDelegate()
        
        // when
        let result = floatingLabelTextField.textFieldShouldEndEditing(floatingLabelTextField.textField)
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_whenTextFieldShouldEndEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.textFieldShouldEndEditing(floatingLabelTextField.textField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldEndEditingInvoked)
    }
    
    // MARK: textFieldDidEndEditing
    
    func test_whenTextFieldDidEndEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        floatingLabelTextField.textFieldDidEndEditing(floatingLabelTextField.textField)
        
        // then
        XCTAssertTrue(textFieldDelegateMock.textFieldDidEndEditingInvoked)
    }
    
    // MARK: textFieldShouldReturn
    
    func test_whenTextFieldShouldReturnInvoked_withNilDelegate_thenReturnsTrue() {
        // given
        floatingLabelTextField.delegate = nil
        
        // when
        let result = floatingLabelTextField.textFieldShouldReturn(floatingLabelTextField.textField)
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_whenTextFieldShouldReturnInvoked_withDelegateThatDoesNotImplementTextFieldShouldBeginEditing_thenReturnsTrue() {
        // given
        floatingLabelTextField.delegate = EmptyTextFieldDelegate()
        
        // when
        let result = floatingLabelTextField.textFieldShouldReturn(floatingLabelTextField.textField)
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_whenTextFieldShouldReturnInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.textFieldShouldReturn(floatingLabelTextField.textField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldReturnInvoked)
    }
    
    // MARK: textFieldShouldClear
    
    func test_whenTextFieldShouldClearInvoked_withNilDelegate_thenReturnsTrue() {
        // given
        floatingLabelTextField.delegate = nil
        
        // when
        let result = floatingLabelTextField.textFieldShouldClear(floatingLabelTextField.textField)
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_whenTextFieldShouldClearInvoked_withDelegateThatDoesNotImplementTextFieldShouldBeginEditing_thenReturnsTrue() {
        // given
        floatingLabelTextField.delegate = EmptyTextFieldDelegate()
        
        // when
        let result = floatingLabelTextField.textFieldShouldClear(floatingLabelTextField.textField)
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_whenTextFieldShouldClearInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.textFieldShouldClear(floatingLabelTextField.textField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldClearInvoked)
    }
    
    // MARK: shouldChangeCharactersInRange
    
    func test_whenShouldChangeCharactersInRangeInvoked_withNilDelegate_thenReturnsTrue() {
        // given
        floatingLabelTextField.delegate = nil
        
        // when
        let result = floatingLabelTextField.textField(floatingLabelTextField.textField, shouldChangeCharactersInRange: NSRange(), replacementString:"")
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_whenShouldChangeCharactersInRangeInvoked_withDelegateThatDoesNotImplementTextFieldShouldBeginEditing_thenReturnsTrue() {
        // given
        floatingLabelTextField.delegate = EmptyTextFieldDelegate()
        
        // when
        let result = floatingLabelTextField.textField(floatingLabelTextField.textField, shouldChangeCharactersInRange: NSRange(), replacementString:"")
        
        // then
        XCTAssertTrue(result)
    }
    
    func test_whenShouldChangeCharactersInRangeInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.textField(floatingLabelTextField.textField, shouldChangeCharactersInRange: NSRange(), replacementString:"")
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.shouldChangeCharactersInRangeInvoked)
    }
    
    // MARK: - TextField target actions
    
    func test_whenTextFieldEditingChanged_thenUpdatesText() {
        // give
        let textField = UITextField()
        textField.text = "textField1Text"
        
        // when
        floatingLabelTextField.textFieldChanged(textField)
        
        // then
        XCTAssertEqual(floatingLabelTextField.textField.text, "textField1Text")
    }
    
    // MARK:  - control lifecycle events
    
    func test_whenLayoutSubviewsInvoked_thenTitleLabelFrameIsUpdated() {
        // given
        floatingLabelTextField.titleLabel.frame = CGRectMake(0, 0, 0, 0)
        XCTAssertEqual(floatingLabelTextField.titleLabel.frame.height, 0.0)
        
        // when
        floatingLabelTextField.layoutSubviews()
        
        // then
        XCTAssertNotEqual(floatingLabelTextField.titleLabel.frame.height, 0.0)
    }
    
    func test_whenLayoutSubviewsInvoked_thenPlacholderFrameIsUpdated() {
        // given
        floatingLabelTextField.placeholderLabel.frame = CGRectMake(0, 0, 0, 0)
        XCTAssertEqual(floatingLabelTextField.placeholderLabel.frame.height, 0.0)
        
        // when
        floatingLabelTextField.layoutSubviews()
        
        // then
        XCTAssertNotEqual(floatingLabelTextField.placeholderLabel.frame.height, 0.0)
    }
    
    func test_whenLayoutSubviewsInvoked_thenTextFieldFrameIsUpdated() {
        // given
        floatingLabelTextField.textField.frame = CGRectMake(0, 0, 0, 0)
        XCTAssertEqual(floatingLabelTextField.textField.frame.height, 0.0)
        
        // when
        floatingLabelTextField.layoutSubviews()
        
        // then
        XCTAssertNotEqual(floatingLabelTextField.textField.frame.height, 0.0)
    }
    
    func test_whenLayoutSubviewsInvoked_thenLineViewFrameIsUpdated() {
        // given
        floatingLabelTextField.lineHeight = 2.0
        floatingLabelTextField.lineView.frame = CGRectMake(0, 0, 0, 0)
        XCTAssertNotEqual(floatingLabelTextField.lineView.frame.height, 2.0)
        
        // when
        floatingLabelTextField.layoutSubviews()
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.frame.height, 2.0)
    }
    
    // MARK: titleHeight()
    
    func test_whenTitleLabelHasFontSet_thenTitleHeightReturnsFontHeight() {
        // given
        let font = UIFont(name: "Arial", size: 16)
        floatingLabelTextField.titleLabel.font = font
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleHeight(), font!.lineHeight)
    }
    
    func test_whenTitleLabelHasFontSetToNil_thenFontSetToDefault() {
        // when
        floatingLabelTextField.titleLabel.font = nil
        
        // then
        XCTAssertNotNil(floatingLabelTextField.titleLabel.font)
    }
    
    // MARK: textHeight()
    
    func test_whenTextFieldHasFontSet_thenTextHeightReturnsFontHeightPlusSeven() {
        // given
        let font = UIFont(name: "Arial", size: 16)
        floatingLabelTextField.textField.font = font
        
        // then
        XCTAssertEqual(floatingLabelTextField.textHeight(), font!.lineHeight + 7)
    }
    
    func test_whenTextFieldHasFontSetToNil_thenFontSetToDefault() {
        // when
        floatingLabelTextField.textField.font = nil
        
        // then
        XCTAssertNotNil(floatingLabelTextField.textField.font)
    }
    
    // MARK: prepareForInterfaceBuilder()
    
    func test_whenPrtepareForInterfaceBuilderInvoked_thenSelectedSetToTrue() {
        // given
        XCTAssertFalse(floatingLabelTextField.selected)
        
        // when
        floatingLabelTextField.prepareForInterfaceBuilder()
        
        // then
        XCTAssertTrue(floatingLabelTextField.selected)
    }
    
    // MARK: - Helpers
    
    func failOnTimeoutAfterSeconds(timeout: NSTimeInterval) {
        self.waitForExpectationsWithTimeout(timeout, handler: {(error: NSError?) -> Void in
            if let error = error {
                XCTFail("Call timed out %@", file: error.localizedDescription)
            }
        })
    }
    
    func delay(delay:Double, callback:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), callback)
    }
    
    class EmptyTextFieldDelegate: SkyFloatingLabelTextFieldDelegate {
        
    }
    
    class TextFieldDelegateMock: SkyFloatingLabelTextFieldDelegate {
        var textFieldShouldBeginEditing = false
        var textFieldShouldEndEditing = false
        var textFieldShouldReturn = false
        var textFieldShouldClear = false
        var shouldChangeCharactersInRange = false
        
        var textFieldShouldBeginEditingInvoked = false
        var textFieldShouldEndEditingInvoked = false
        var textFieldDidBeginEditingInvoked = false
        var textFieldDidEndEditingInvoked = false
        var textFieldShouldReturnInvoked = false
        var textFieldShouldClearInvoked = false
        var shouldChangeCharactersInRangeInvoked = false
        
        @objc func textFieldDidBeginEditing(textField: SkyFloatingLabelTextField) {
            textFieldDidBeginEditingInvoked = true
        }
        
        @objc func textFieldDidEndEditing(textField: SkyFloatingLabelTextField) {
            textFieldDidEndEditingInvoked = true
        }
        
        @objc func textFieldShouldBeginEditing(textField: SkyFloatingLabelTextField) -> Bool {
            textFieldShouldBeginEditingInvoked = true
            return textFieldShouldBeginEditing
        }
        
        @objc func textFieldShouldEndEditing(textField: SkyFloatingLabelTextField) -> Bool {
            textFieldShouldEndEditingInvoked = true
            return textFieldShouldEndEditing
        }
        
        @objc func textFieldShouldReturn(textField: SkyFloatingLabelTextField) -> Bool {
            textFieldShouldReturnInvoked = true
            return textFieldShouldReturn
        }
        
        @objc func textFieldShouldClear(textField: SkyFloatingLabelTextField) -> Bool {
            textFieldShouldClearInvoked = true
            return textFieldShouldClear
        }
        
        @objc func textField(textField: SkyFloatingLabelTextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
            shouldChangeCharactersInRangeInvoked = true
            return shouldChangeCharactersInRange
        }
        
    }
}
