//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import XCTest

class SkyFloatingLabelTextFieldTests: XCTestCase {
    
    var floatingLabelTextField: SkyFloatingLabelTextField!
    let customColor = UIColor(red: 125/255, green: 120/255, blue: 50/255, alpha: 1.0)
    
    override func setUp() {
        super.setUp()
        self.floatingLabelTextField = SkyFloatingLabelTextField(frame: CGRectMake(0, 0, 200, 50))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_whenSettingTextColor_thenTextFieldColorIsChangedToThisColor() {
        // when
        self.floatingLabelTextField.textColor = self.customColor
        
        // them
        XCTAssertEqual(self.floatingLabelTextField.textField.textColor, self.customColor)
    }
}
