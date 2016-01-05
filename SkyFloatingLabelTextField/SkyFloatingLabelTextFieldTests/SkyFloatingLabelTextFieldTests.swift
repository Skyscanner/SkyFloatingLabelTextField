//
//  SkyFloatingLabelTextFieldTests.swift
//  SkyFloatingLabelTextFieldTests
//
//  Created by Gergely Orosz on 05/01/2016.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

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
