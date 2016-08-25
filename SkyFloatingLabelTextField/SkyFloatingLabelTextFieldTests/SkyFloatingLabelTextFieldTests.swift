//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import UIKit
import XCTest
@testable import SkyFloatingLabelTextField

class SkyFloatingLabelTextFieldTests: XCTestCase {
    
    var floatingLabelTextField: SkyFloatingLabelTextField!
    let customColor = UIColor(red: 125/255, green: 120/255, blue: 50/255, alpha: 1.0)
    let textFieldDelegateMock = TextFieldDelegateMock()
    
    override func setUp() {
        super.setUp()
        floatingLabelTextField = SkyFloatingLabelTextField(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK:  - colors
    
    func test_whenSettingTextColor_thenTextFieldTextColorIsChangedToThisColor() {
        // when
        floatingLabelTextField.textColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.textColor, self.customColor)
    }
    
    func test_whenSettingPlaceholderColor_thenPlaceholderColorIsChangedToThisColor() {
        // when
        floatingLabelTextField.placeholderColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.placeholderColor, self.customColor)
    }
    
    func test_whenSettingPlaceholderColor_thenAttributedPlaceholderTextIsSet_withColor() {
        // given
        let customColor = UIColor.red
        floatingLabelTextField.placeholder = "test"
        var fullRange:NSRange = NSMakeRange(0, floatingLabelTextField.placeholder!.characters.count)
        
        // when
        floatingLabelTextField.placeholderColor = customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.attributedPlaceholder!.attribute(NSForegroundColorAttributeName, at: 0, effectiveRange: &fullRange) as? UIColor, customColor)
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
    
    func test_whenSettingErrorColor_withErrorMessageBeingEmpty_thenTitleLabelTextColorIsNotChangedToThisColor() {
        // given
        floatingLabelTextField.errorMessage = ""
        
        // when
        floatingLabelTextField.errorColor = self.customColor
        
        // then
        XCTAssertNotEqual(floatingLabelTextField.titleLabel.textColor, self.customColor)
    }
    
    func test_whenSettingErrorColor_withErrorMessageBeingNil_thenTitleLabelTextColorIsNotChangedToThisColor() {
        // given
        floatingLabelTextField.errorMessage = nil
        
        // when
        floatingLabelTextField.errorColor = self.customColor
        
        // then
        XCTAssertNotEqual(floatingLabelTextField.titleLabel.textColor, self.customColor)
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
        floatingLabelTextField.isSelected = true
        
        // when
        floatingLabelTextField.selectedTitleColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.textColor, self.customColor)
    }
    
    // MARK: - fonts
    
    func test_whenSettingPlaceholderFont_thenAttributedPlaceholderTextIsSet_withFont() {
        // given
        let customFont = UIFont()
        floatingLabelTextField.placeholder = "test"
        var fullRange:NSRange = NSMakeRange(0, floatingLabelTextField.placeholder!.characters.count)
        
        // when
        floatingLabelTextField.placeholderFont = customFont
        
        // then
        XCTAssertEqual(floatingLabelTextField.attributedPlaceholder!.attribute(NSFontAttributeName, at: 0, effectiveRange: &fullRange) as? UIFont, customFont)
    }
    
    func test_whenSettingSelectedLineColor_withTextfieldBeingSelected_thenLineViewBackgroundColorIsChangedToThisColor() {
        // given
        floatingLabelTextField.isSelected = true
        
        // when
        floatingLabelTextField.selectedLineColor = self.customColor
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.backgroundColor, self.customColor)
    }
    
    
    // MARK:  - line height
    
    func test_whenInitializingControl_thenLineHeightIsTwoPixelsOnScreen() {
        // given
        let onePixel = 1.0 / Double(UIScreen.main.scale)
        
        // then
        XCTAssertEqual(Double(floatingLabelTextField.lineHeight), 2.0 * onePixel)
    }
    
    func test_whenSettingLineHeight_thenLineViewHeightIsChangedToThisValue() {
        // when
        floatingLabelTextField.lineHeight = 3
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.frame.size.height, 3)
    }
    
    func test_whenInitializingControl_thenSelectedLineHeightIsFourPixelsOnScreen() {
        // given
        let onePixel = 1.0 / Double(UIScreen.main.scale)
        
        // then
        XCTAssertEqual(Double(floatingLabelTextField.selectedLineHeight), 4.0 * onePixel)
    }
    
    func test_whenSettingSelectedLineHeight__withTextFieldBeingSelected_thenLineViewHeightIsChangedToThisValue() {
        // given
        floatingLabelTextField.isSelected = true
        
        // when
        floatingLabelTextField.selectedLineHeight = 4
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.frame.size.height, 4)
    }
    
    // MARK:  - text

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
    
    func test_whenSettingText_withErrorMessagePresent_thenErrorMessageIsNotChanged() {
        // given
        floatingLabelTextField.errorMessage = "error"
        floatingLabelTextField.title = "title"
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "ERROR")
        
        // when
        floatingLabelTextField.text = "hello!"
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "ERROR")
        XCTAssertEqual(floatingLabelTextField.errorMessage, "error")
    }
    
    func test_whenBecomeFirstResponder_thenErrorMessageIsNotCleared() {
        // given
        floatingLabelTextField.errorMessage = "Error"
        
        // when
        floatingLabelTextField.becomeFirstResponder()
        
        // then
        XCTAssertEqual(floatingLabelTextField.errorMessage, "Error")
    }
    
    func test_whenEditingChangedInvoked_thenErrorMessageIsNotCleared() {
        // given
        floatingLabelTextField.errorMessage = "Error"
        
        // when
        floatingLabelTextField.editingChanged()
        
        // then
        XCTAssertEqual(floatingLabelTextField.errorMessage, "Error")
    }
    
    func test_whenEditingChangedInvoked_thenDelegateShouldChangeCharactersInRangeIsNotInvoked() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        floatingLabelTextField.text = "aa"
        
        // when
        floatingLabelTextField.editingChanged()
        
        // then
        XCTAssertFalse(textFieldDelegateMock.shouldChangeCharactersInRangeInvoked)
    }
    
    // MARK:  - editingOrSelected
    
    func test_whenSettingSelected_toTrue_thenEditingOrSelectedIsTrue() {
        // given
        XCTAssertFalse(floatingLabelTextField.isEditing)
        
        // when
        floatingLabelTextField.isSelected = true
        
        // then
        XCTAssertTrue(floatingLabelTextField.editingOrSelected)
    }
    
    // MARK:  - highlighted
    
    func test_whenSettingHighightedFromFalseToTrue_thenHighlightedIsTrue() {
        // given
        XCTAssertFalse(floatingLabelTextField.isHighlighted)
        
        // when
        floatingLabelTextField.isHighlighted = true
        
        // then
        XCTAssertTrue(floatingLabelTextField.isHighlighted)
    }
    
    // MARK:  - setTitleVisible()
    
    func test_whenSettingTitleVisible_toTrue_withoutAnimation_thenTitleAlphaSetToOne() {
        // given
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 0.0)
        
        // when
        floatingLabelTextField.setTitleVisible(true, animated: false)
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 1.0)
    }
    
    func test_whenSettingTitleVisible_fromTrueToTrue_withoutAnimation_thenTitleAlphaIsNotChanged() {
        // given
        floatingLabelTextField.setTitleVisible(true, animated: false)
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 1.0)
        
        // when
        floatingLabelTextField.setTitleVisible(true, animated: false)
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 1.0)
    }
    
    func test_whenSettingTitleVisible_toTrue_withAnimation_thenTitleAlphaIsNotChangedImmediately() {
        // given
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 0.0)
        
        // when
        floatingLabelTextField.setTitleVisible(true, animated: false)
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 1.0)
    }
    
    func test_whenSettingTitleVisible_toTrue_withAnimation_thenTitleAlphaIsSetToOne_whenCallbackIsInvoked() {
        // given
        let expectation = self.expectation(description: "")
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 0.0)
        
        // when
        floatingLabelTextField.setTitleVisible(true, animated: false, animationCompletion: { _ in
            // then
            XCTAssertEqual(self.floatingLabelTextField.titleLabel.alpha, 1.0)
            expectation.fulfill()
        })
        
        self.failOnTimeoutAfterSeconds(5)
    }
    
    func test_whenSettingTitleVisible_toTrue_withoutAnimation_thenTitleAlphaIsOne() {
        // given
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 0.0)
        
        // when
        floatingLabelTextField.setTitleVisible(true, animated: false)
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.alpha, 1.0)
    }
    
    func test_whenSettingTitleVisible_toFalse_then_whenAnimationCallbackInvoked_titleIsNotVisible() {
        // given
        floatingLabelTextField.setTitleVisible(true, animated: false)
        let expectation = self.expectation(description: "")
        
        // when
        floatingLabelTextField.setTitleVisible(false, animated: true, animationCompletion: { _ in
            // then
            XCTAssertEqual(self.floatingLabelTextField.titleLabel.alpha, 0.0)
            expectation.fulfill()
        })
        
        self.failOnTimeoutAfterSeconds(5)
    }
    
    func test_whenSettingTitleVisibleToFalse_withoutAnimation_thenTitleAlphaIsZeroImmediately() {
        // given
        floatingLabelTextField.setTitleVisible(true, animated: false)
        XCTAssertEqual(self.floatingLabelTextField.titleLabel.alpha, 1.0)
        
        // when
        floatingLabelTextField.setTitleVisible(false, animated: false)
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.titleLabel.alpha, 0.0)
    }
    
    // MARK:  - placeholder
    
    func test_whenPlaceholderIsSet_withSelected_andNoTitleSet_thenTitleLabelTextIsUppercasePlaceholderText() {
        // given
        floatingLabelTextField.title = nil
        floatingLabelTextField.selectedTitle = nil
        floatingLabelTextField.isSelected = true
        
        // when
        floatingLabelTextField.placeholder = "placeholderText"
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "PLACEHOLDERTEXT")
    }
    
    // MARK:  - selectedTitle
    
    func test_whenTitleAndSelectedTitleAreSet_withControlNotBeingSelected_thenTitleLabelDisplaysUppercaseTitle() {
        // given
        floatingLabelTextField.isSelected = false
        
        // when
        floatingLabelTextField.title = "title"
        floatingLabelTextField.selectedTitle = "selectedTitle"
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "TITLE")
    }
    
    func test_whenTitleIsSetAndSelectedTitleIsNotSet_withControlBeingSelected_thenTitleLabelDisplaysUppercaseTitle() {
        // given
        floatingLabelTextField.isSelected = true
        
        // when
        floatingLabelTextField.title = "title"
        floatingLabelTextField.selectedTitle = nil
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "TITLE")
    }
    
    func test_whenTitleAndSelectedTitleAreSet_withControlBeingSelected_thenTitleLabelDisplaysUppercaseSelectedTitle() {
        // given
        floatingLabelTextField.isSelected = true
        
        // when
        floatingLabelTextField.title = "title"
        floatingLabelTextField.selectedTitle = "selectedTitle"
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleLabel.text, "SELECTEDTITLE")
    }
    
    // MARK: - Responder handling
    
    func test_whenBecomeFirstResponderInvoked_thenUpdateColorsInvoked() {
        // given
        let floatingLabelTextFieldSpy = SkyFloatingLabelTextFieldSpy()
        
        // when
        floatingLabelTextFieldSpy.becomeFirstResponder()
        
        // then
        XCTAssertTrue(floatingLabelTextFieldSpy.updateColorsInvoked)
    }
    
    func test_whenResignFirstResponderInvoked_thenUpdateColorsInvoked() {
        // given
        let floatingLabelTextFieldSpy = SkyFloatingLabelTextFieldSpy()
        
        // when
        floatingLabelTextFieldSpy.resignFirstResponder()
        
        // then
        XCTAssertTrue(floatingLabelTextFieldSpy.updateColorsInvoked)
    }
    
    // MARK:  - init
    
    func test_whenIntiializingWithCoder_thenTextfieldUIElementsAreCreated() {
        // given
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.finishEncoding()
        let coder = NSKeyedUnarchiver(forReadingWith: data as Data)
        
        // when
        floatingLabelTextField = SkyFloatingLabelTextField(coder: coder)
        
        // then
        XCTAssertNotNil(floatingLabelTextField.titleLabel)
        XCTAssertNotNil(floatingLabelTextField.lineView)
    }
    
    // MARK: - Textfield delegate methods
    
    // MARK: textFieldShouldBeginEditing
    
    func test_whenTextFieldShouldBeginEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.delegate!.textFieldShouldBeginEditing!(floatingLabelTextField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldBeginEditingInvoked)
    }

    // MARK: textFieldDidBeginEditing
    
    func test_whenTextFieldDidBeginEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        floatingLabelTextField.delegate!.textFieldDidBeginEditing!(floatingLabelTextField)
        
        // then
        XCTAssertTrue(textFieldDelegateMock.textFieldDidBeginEditingInvoked)
    }
    
    // MARK: textFieldShouldEndEditing
    
    func test_whenTextFieldShouldEndEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.delegate!.textFieldShouldEndEditing!(floatingLabelTextField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldEndEditingInvoked)
    }
    
    // MARK: textFieldDidEndEditing
    
    func test_whenTextFieldDidEndEditingInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        floatingLabelTextField.delegate!.textFieldDidEndEditing!(floatingLabelTextField)
        
        // then
        XCTAssertTrue(textFieldDelegateMock.textFieldDidEndEditingInvoked)
    }
    
    // MARK: textFieldShouldReturn
    
    func test_whenTextFieldShouldReturnInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.delegate!.textFieldShouldReturn!(floatingLabelTextField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldReturnInvoked)
    }
    
    // MARK: textFieldShouldClear
    
    func test_whenTextFieldShouldClearInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.delegate!.textFieldShouldClear!(floatingLabelTextField)
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.textFieldShouldClearInvoked)
    }
    
    // MARK: shouldChangeCharactersInRange
    
    func test_whenShouldChangeCharactersInRangeInvoked_withNonNilDelegate_thenInvokesDelegate() {
        // given
        floatingLabelTextField.delegate = textFieldDelegateMock
        
        // when
        let result = floatingLabelTextField.delegate!.textField!(floatingLabelTextField, shouldChangeCharactersIn: NSRange(), replacementString:"")
        
        // then
        XCTAssertFalse(result)
        XCTAssertTrue(textFieldDelegateMock.shouldChangeCharactersInRangeInvoked)
    }
    
    // MARK:  - UITextField positioning overrides
    
    func test_whenInvokingEditingRectForBounds_thenReturnsRectThatSubtractsTitleHeightAndSelectedLineHeight() {
        // given
        floatingLabelTextField.selectedLineHeight = 4
        let boundsHeight:CGFloat = 60
        let bounds = CGRect(x: 0, y: 0, width: 200, height: boundsHeight)
        
        // when
        let rect = floatingLabelTextField.editingRect(forBounds: bounds)
        
        // then
        XCTAssertEqual(rect.height, boundsHeight - 4 - floatingLabelTextField.titleHeight())
    }
    
    // MARK:  - control lifecycle events
    
    func test_whenLayoutSubviewsInvoked_thenTitleLabelFrameIsUpdated() {
        // given
        floatingLabelTextField.titleLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        XCTAssertEqual(floatingLabelTextField.titleLabel.frame.height, 0.0)
        
        // when
        floatingLabelTextField.layoutSubviews()
        
        // then
        XCTAssertNotEqual(floatingLabelTextField.titleLabel.frame.height, 0.0)
    }
    
    func test_whenLayoutSubviewsInvoked_thenLineViewFrameIsUpdated() {
        // given
        floatingLabelTextField.lineHeight = 2.0
        floatingLabelTextField.lineView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        XCTAssertNotEqual(floatingLabelTextField.lineView.frame.height, 2.0)
        
        // when
        floatingLabelTextField.layoutSubviews()
        
        // then
        XCTAssertEqual(floatingLabelTextField.lineView.frame.height, 2.0)
    }
    
    // MARK: titleHeight()
    
    func test_whenTitleLabelIsNil_thenTitleHeightReturnsFifteen() {
        // given
        floatingLabelTextField.titleLabel = nil
        
        // then
        XCTAssertEqual(floatingLabelTextField.titleHeight(), 15)
    }
    
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
        floatingLabelTextField.font = font
        
        // then
        XCTAssertEqual(floatingLabelTextField.textHeight(), font!.lineHeight + 7)
    }
    
    func test_whenTextFieldHasFontSetToNil_thenFontSetToDefault() {
        // when
        floatingLabelTextField.font = nil
        
        // then
        XCTAssertNotNil(floatingLabelTextField.font)
    }
    
    // MARK: prepareForInterfaceBuilder()
    
    func test_whenPrepareForInterfaceBuilderInvoked_thenSelectedSetToTrue() {
        // given
        XCTAssertFalse(floatingLabelTextField.isSelected)
        
        // when
        floatingLabelTextField.prepareForInterfaceBuilder()
        
        // then
        XCTAssertTrue(floatingLabelTextField.isSelected)
    }
    
    // MARK: intrinsicContentSize()
    
    func test_whenIntristicContentSizeInvoked_thenHeightIsTitleHeightAndContentHeightSize() {
        // given
        XCTAssertNotEqual(floatingLabelTextField.titleHeight(), 0)
        XCTAssertNotEqual(floatingLabelTextField.textHeight(), 0)
        
        // when
        let size = floatingLabelTextField.intrinsicContentSize
        
        // then
        XCTAssertEqual(size.height, floatingLabelTextField.titleHeight() + floatingLabelTextField.textHeight())
    }
    
    // MARK: - Helpers
    
    func failOnTimeoutAfterSeconds(_ timeout: TimeInterval) {
        self.waitForExpectations(timeout: timeout, handler: {(error: Error?) -> Void in
            if let error = error {
                XCTFail("Call timed out \(error.localizedDescription)")
            }
        })
    }
    
    func delay(_ delay:Double, callback:()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: callback)
    }
    
    class TextFieldDelegateMock:NSObject, UITextFieldDelegate {
        var textFieldShouldBeginEditing = false
        var textFieldShouldEndEditing = false
        var textFieldShouldReturn = false
        var textFieldShouldClear = false
        var shouldChangeCharactersInRange = false
        
        var textFieldChangedInvoked = false
        var textFieldShouldBeginEditingInvoked = false
        var textFieldShouldEndEditingInvoked = false
        var textFieldDidBeginEditingInvoked = false
        var textFieldDidEndEditingInvoked = false
        var textFieldShouldReturnInvoked = false
        var textFieldShouldClearInvoked = false
        var shouldChangeCharactersInRangeInvoked = false
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            textFieldDidBeginEditingInvoked = true
        }
        
        func textFieldChanged(_ textField: UITextField) {
            textFieldChangedInvoked = true
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            textFieldDidEndEditingInvoked = true
        }
        
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            textFieldShouldBeginEditingInvoked = true
            return textFieldShouldBeginEditing
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            textFieldShouldEndEditingInvoked = true
            return textFieldShouldEndEditing
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textFieldShouldReturnInvoked = true
            return textFieldShouldReturn
        }
        
        func textFieldShouldClear(_ textField: UITextField) -> Bool {
            textFieldShouldClearInvoked = true
            return textFieldShouldClear
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            shouldChangeCharactersInRangeInvoked = true
            return shouldChangeCharactersInRange
        }
    }
    
    class SkyFloatingLabelTextFieldSpy: SkyFloatingLabelTextField {
        var updateColorsInvoked = false
        
        override func updateColors() {
            updateColorsInvoked = true
            super.updateColors()
        }
    }
}
