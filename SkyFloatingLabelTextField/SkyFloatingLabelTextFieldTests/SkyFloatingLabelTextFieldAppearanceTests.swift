//  Copyright 2016-2017 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the
//  License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
//  either express or implied. See the License for the specific language governing permissions
//  and limitations under the License.

import XCTest
@testable import SkyFloatingLabelTextField

class SkyFloatingLabelTextFieldAppearanceTests: XCTestCase {

    override func setUp() {
        super.setUp()

        let styles = SkyFloatingLabelTextField.appearance()

        // Text-, placeholder- and tintcolor
        styles.textColor = UIColor.brown
        styles.tintColor = UIColor.brown
        styles.placeholderColor = UIColor.darkGray
        styles.selectedTitleColor = UIColor.orange
        styles.errorColor = UIColor.purple

        // Fonts
        styles.font = UIFont(name: "HelveticaNeue-Bold", size: 14)!
        styles.placeholderFont = UIFont(name: "HelveticaNeue-Medium", size: 14)!

        // Line
        styles.lineHeight = 2
        styles.lineColor = UIColor.brown

        // Selected line
        styles.selectedLineHeight = 3
        styles.selectedLineColor = UIColor.orange

        // Apply icon styles
        let iconStyles = SkyFloatingLabelTextFieldWithIcon.appearance()

        // Icon colors
        iconStyles.iconColor = UIColor.brown
        iconStyles.selectedIconColor = UIColor.orange

        // Icon font
        iconStyles.iconFont = UIFont(name: "FontAwesome", size: 15)

        // Icon margins
        iconStyles.iconMarginLeft = 5
        iconStyles.iconMarginBottom = 5
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_ColorAppearances() {
        let styles = SkyFloatingLabelTextField.appearance()
        XCTAssertEqual(styles.textColor, UIColor.brown)
        XCTAssertEqual(styles.tintColor, UIColor.brown)
        XCTAssertEqual(styles.placeholderColor, UIColor.darkGray)
        XCTAssertEqual(styles.selectedTitleColor, UIColor.orange)
        XCTAssertEqual(styles.errorColor, UIColor.purple)
    }

    func test_FontAppearances() {
        let styles = SkyFloatingLabelTextField.appearance()
        XCTAssertEqual(styles.font, UIFont(name: "HelveticaNeue-Bold", size: 14)!)
        XCTAssertEqual(styles.placeholderFont, UIFont(name: "HelveticaNeue-Medium", size: 14)!)
    }

    func test_LineAppearances() {
        let styles = SkyFloatingLabelTextField.appearance()
        XCTAssertEqual(styles.lineHeight, 2)
        XCTAssertEqual(styles.lineColor, UIColor.brown)
        XCTAssertEqual(styles.selectedLineHeight, 3)
        XCTAssertEqual(styles.selectedLineColor, UIColor.orange)
    }

    func test_iconColorAppearances() {
        let iconStyles = SkyFloatingLabelTextFieldWithIcon.appearance()
        XCTAssertEqual(iconStyles.iconColor, UIColor.brown)
        XCTAssertEqual(iconStyles.selectedIconColor, UIColor.orange)
    }

    func test_iconFontAppearance() {
        let iconStyles = SkyFloatingLabelTextFieldWithIcon.appearance()
        XCTAssertEqual(iconStyles.iconFont, UIFont(name: "FontAwesome", size: 15))
    }

    func test_iconMarginAppearance() {
        let iconStyles = SkyFloatingLabelTextFieldWithIcon.appearance()
        XCTAssertEqual(iconStyles.iconMarginLeft, 5)
        XCTAssertEqual(iconStyles.iconMarginBottom, 5)
    }
}
