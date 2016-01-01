//
//  ThemedTextField.swift
//  Demo
//
//  Created by Daniel Langh on 01/01/16.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

import UIKit

public class ThemedTextField: WatermarkedTextField {

    public override init(frame: CGRect, textField: UITextField?, lineView: UIView?) {
        super.init(frame: frame, textField: textField, lineView: lineView)
        self.setupTheme()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupTheme()
    }
    
    private func setupTheme() {
        
        let blueColor = UIColor(red: 0.0, green: 221.0/256.0, blue: 238.0/256.0, alpha: 1.0)
        let whiteColor = UIColor.whiteColor()
        let errorColor = UIColor.redColor()
        
        self.errorColor = errorColor
        self.textColor = whiteColor
        self.selectedLineColor = blueColor
        self.lineColor = whiteColor
        self.titleColor = whiteColor
        self.selectedTitleColor = blueColor
    }
}
