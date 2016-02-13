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
    
    override func setUp() {
        super.setUp()
        self.floatingLabelTextField = SkyFloatingLabelTextField(frame: CGRectMake(0, 0, 200, 50))
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK:  - Colors
    
    func test_whenSettingTextColor_thenTextFieldTextColorIsChangedToThisColor() {
        // when
        self.floatingLabelTextField.textColor = self.customColor
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.textField.textColor, self.customColor)
    }
    
    func test_whenSettingPlaceholderColor_thenPlaceholderLabelTextColorIsChangedToThisColor() {
        // when
        self.floatingLabelTextField.placeholderColor = self.customColor
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.placeholderLabel.textColor, self.customColor)
    }
    
    func test_whenSettingTitleColor_thenTitleLabelTextColorIsChangedToThisColor() {
        // when
        self.floatingLabelTextField.titleColor = self.customColor
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.titleLabel.textColor, self.customColor)
    }
    
    func test_whenSettingLineColor_thenLineViewBackgroundColorIsChangedToThisColor() {
        // when
        self.floatingLabelTextField.lineColor = self.customColor
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.lineView.backgroundColor, self.customColor)
    }
    
    func test_whenSettingErrorColor_withErrorMessageBeingSet_thenTitleLabelTextColorIsChangedToThisColor() {
        // given
        self.floatingLabelTextField.errorMessage = "test"
        
        // when
        self.floatingLabelTextField.errorColor = self.customColor
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.titleLabel.textColor, self.customColor)
    }
    
    func test_whenSettingErrorColor_withErrorMessageBeingSet_thenLineViewBackgroundColorIsChangedToThisColor() {
        // given
        self.floatingLabelTextField.errorMessage = "test"
        
        // when
        self.floatingLabelTextField.errorColor = self.customColor
        
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.lineView.backgroundColor, self.customColor)
    }
    
    func test_whenSettingSelectedTitleColor_withTextfieldBeingSelected_thenTitleLabelTextColorIsChangedToThisColor() {
        // given
        self.floatingLabelTextField.selected = true
        
        // when
        self.floatingLabelTextField.selectedTitleColor = self.customColor
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.titleLabel.textColor, self.customColor)
    }
    
    func test_whenSettingSelectedLineColor_withTextfieldBeingSelected_thenLineViewBackgroundColorIsChangedToThisColor() {
        // given
        self.floatingLabelTextField.selected = true
        
        // when
        self.floatingLabelTextField.selectedLineColor = self.customColor
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.lineView.backgroundColor, self.customColor)
    }
    
    
    // MARK:  - Line height
    
    func test_whenSettingLineHeight_thenLineViewHeightIsChangedToThisValue() {
        // when
        self.floatingLabelTextField.lineHeight = 3
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.lineView.frame.size.height, 3)
    }
    
    func test_whenSettingSelectedLineHeight__withTextFieldBeingSelected_thenLineViewHeightIsChangedToThisValue() {
        // given
        self.floatingLabelTextField.selected = true
        
        // when
        self.floatingLabelTextField.selectedLineHeight = 4
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.lineView.frame.size.height, 4)
    }
    
    // MARK:  - hasText
    
    func test_hasText_whenTextPropertyIsNotEmpty_thenReturnsTrue() {
        // given
        self.floatingLabelTextField.text = "hello";
        
        // then
        XCTAssertTrue(self.floatingLabelTextField.hasText)
    }
    
    func test_hasText_whenTextPropertyIsEmpty_thenReturnsFalse() {
        // given
        self.floatingLabelTextField.text = "";
        
        // then
        XCTAssertFalse(self.floatingLabelTextField.hasText)
    }
    
    // MARK:  - highlighted
    
    func test_whenSettingHighighted_toTrue_thenTitleAlphaIsOne() {
        // given
        self.floatingLabelTextField.highlighted = true;
        
        // then
        XCTAssertEqual(self.floatingLabelTextField.titleLabel.alpha, 1.0)
    }
    
    func test_whenSettingHighighted_toFalse_then_afterOneSecond_titleAlphaIsZero() {
        // given
        let expectation = self.expectationWithDescription("")
        
        // when
        self.floatingLabelTextField.highlighted = false;
        
        self.delay(1.0, callback: { () -> Void in
            // then
            XCTAssertEqual(self.floatingLabelTextField.titleLabel.alpha, 0.0)
            expectation.fulfill()
        })

        self.failOnTimeoutAfterSeconds(5)
    }
    
    // MARK:  - textField properties
    
    func test_whenSettingSecureTextEntry_thenTextFieldSecureTextEntryPropertyIsChangedToThisValue() {
        // given
        XCTAssertFalse(self.floatingLabelTextField.textField.secureTextEntry)
        
        // when
        self.floatingLabelTextField.secureTextEntry = true
        
        // then
        XCTAssertTrue(self.floatingLabelTextField.textField.secureTextEntry)
    }
    
    func test_whenGettingEnabledValue_thenReturnsPreviouslySetValue() {
        // given
        XCTAssertTrue(self.floatingLabelTextField.enabled)
        
        // when
        self.floatingLabelTextField.enabled = false
        
        // then
        XCTAssertFalse(self.floatingLabelTextField.enabled)
    }
    
    func test_whenSettingEnabled_thenTextFieldEnabledPropertyIsChangedToThisValue() {
        // given
        XCTAssertTrue(self.floatingLabelTextField.textField.enabled)
        
        // when
        self.floatingLabelTextField.enabled = false
        
        // then
        XCTAssertFalse(self.floatingLabelTextField.textField.enabled)
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
}
