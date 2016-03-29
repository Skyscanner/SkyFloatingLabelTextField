//
//  SkyFloatingLabelTextFieldWithIconTests.swift
//  SkyFloatingLabelTextField
//
//  Created by Gergely Orosz on 15/02/2016.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

import XCTest
@testable import SkyFloatingLabelTextField

class SkyFloatingLabelTextFieldWithIconTests: XCTestCase {

    var floatingLabelTextFieldWithIcon: SkyFloatingLabelTextFieldWithIcon!
    let customColor = UIColor(red: 125/255, green: 120/255, blue: 50/255, alpha: 1.0)
    
    override func setUp() {
        super.setUp()
        floatingLabelTextFieldWithIcon = SkyFloatingLabelTextFieldWithIcon(frame: CGRectMake(0, 0, 200, 50))
    }
    
    // MARK: - Icons properties
    
    func test_whenSettingIconFont_thenFontAppliedToIconLabel() {
        // given
        let customFont = UIFont()
        
        // when
        floatingLabelTextFieldWithIcon.iconFont = customFont
        
        // then
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.font, customFont)
    }
    
    func test_whenSettingIconText_thenTextAppliedToIconLabel() {
        // when
        floatingLabelTextFieldWithIcon.iconText = "customIconText"
        
        // then
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.text, "customIconText")
    }

    func test_whenSettingIconColor_thenColorAppliedToIconLabel() {
        // when
        floatingLabelTextFieldWithIcon.iconColor = customColor
        
        // then
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.textColor, customColor)
    }
    
    func test_whenSettingErrorColor_withErrorMessagePresent_thenErrorColorAppliedToIconLabel() {
        // when
        floatingLabelTextFieldWithIcon.errorColor = customColor
        floatingLabelTextFieldWithIcon.errorMessage = "error"
        
        // then
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.textColor, customColor)
    }
    
    func test_whenSettingSelectedIconColor_withTextFieldBeingSelected_thenColorAppliedToIconLabel() {
        // when
        floatingLabelTextFieldWithIcon.selectedIconColor = customColor
        floatingLabelTextFieldWithIcon.selected = true
        
        // then
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.textColor, customColor)
    }
    
    func test_whenSettingIconMarginBottom_thenYPositionDecreasedByIconMarginBottom() {
        // when
        floatingLabelTextFieldWithIcon.iconMarginBottom = 5
        
        // then
        let expectedHeight = floatingLabelTextFieldWithIcon.bounds.size.height - floatingLabelTextFieldWithIcon.textHeight() - 5
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.frame.origin.y, expectedHeight)
    }
    
    func test_whenSettingIconRotationDegrees_thenRotationAppliedToIconLabel() {
        // when
        floatingLabelTextFieldWithIcon.iconRotationDegrees = 45
        
        // then
        let expectedTransform = CGAffineTransformMakeRotation(CGFloat(45.0 * M_PI / 180.0))
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.transform.a, expectedTransform.a)
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.transform.b, expectedTransform.b)
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.transform.c, expectedTransform.c)
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.transform.d, expectedTransform.d)
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.transform.tx, expectedTransform.tx)
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.transform.ty, expectedTransform.ty)
    }
    
    // MARK: - Init
    
    func test_whenIntiializingWithCoder_thenIconLabelIsCreated() {
        // given
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.finishEncoding()
        let coder = NSKeyedUnarchiver(forReadingWithData: data)
        
        // when
        floatingLabelTextFieldWithIcon = SkyFloatingLabelTextFieldWithIcon(coder: coder)
        
        // then
        XCTAssertNotNil(floatingLabelTextFieldWithIcon.iconLabel)
    }
    
    // MARK: - Layout overrides
    
    func test_whenInvokingTextRectForBounds_thenReturnsValueWithIconWidthAndMarginSubtracted() {
        // given
        let iconWidth:Double = 10
        let iconMarginLeft:Double = 5
        floatingLabelTextFieldWithIcon.iconWidth = iconWidth
        floatingLabelTextFieldWithIcon.iconMarginLeft = iconMarginLeft
        
        // when
        let rect = floatingLabelTextFieldWithIcon.textRectForBounds(CGRectMake(0, 0, 40, 30))
        
        // then
        XCTAssertEqual(Double(rect.origin.x), iconWidth + iconMarginLeft)
        XCTAssertEqual(Double(rect.size.width), 40 - iconWidth - iconMarginLeft)

    }
    
    func test_whenInvokingEditingRectForBounds_thenReturnsRectThatSubtractsIconWidthAndIconMarginLeft() {
        // given
        let iconWidth:Double = 10
        let iconMarginLeft:Double = 5
        floatingLabelTextFieldWithIcon.iconWidth = iconWidth
        floatingLabelTextFieldWithIcon.iconMarginLeft = iconMarginLeft
        
        // when
        let rect = floatingLabelTextFieldWithIcon.editingRectForBounds(CGRectMake(0, 0, 50, 30))
        
        // then
        XCTAssertEqual(Double(rect.origin.x), iconWidth + iconMarginLeft)
        XCTAssertEqual(Double(rect.size.width), 50 - iconWidth - iconMarginLeft)
    }
    
    func test_whenInvokingPlaceholderRectForBounds_thenReturnsValueWithIconWidthAndMarginSubtracted() {
        // given
        let iconWidth:Double = 10
        let iconMarginLeft:Double = 5
        floatingLabelTextFieldWithIcon.iconWidth = iconWidth
        floatingLabelTextFieldWithIcon.iconMarginLeft = iconMarginLeft
        
        // when
        let rect = floatingLabelTextFieldWithIcon.placeholderRectForBounds(CGRectMake(0, 0, 60, 30))
        
        // then
        XCTAssertEqual(Double(rect.origin.x), iconWidth + iconMarginLeft)
        XCTAssertEqual(Double(rect.size.width), 60 - iconWidth - iconMarginLeft)
    }
    
    func test_whenInvokingLayoutSubviews_thenUpdatesIconLabelFrame() {
        // given
        floatingLabelTextFieldWithIcon.iconLabel.frame = CGRectMake(0, 0, 0, 0)
        XCTAssertEqual(floatingLabelTextFieldWithIcon.iconLabel.frame.height, 0)
        
        // when
        floatingLabelTextFieldWithIcon.layoutSubviews()
        
        // then
        XCTAssertNotEqual(floatingLabelTextFieldWithIcon.iconLabel.frame.height, 0)
    }
}
