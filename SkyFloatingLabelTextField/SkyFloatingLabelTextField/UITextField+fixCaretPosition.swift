//
//  UITextField+fixCaretPosition.swift
//  SkyFloatingLabelTextField
//
//  Created by Gergely Orosz on 05/01/2016.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

// MARK: - UITextField extension

import UIKit

extension UITextField {
    func fixCaretPosition() {
        // Moving the caret to the correct position by removing the trailing whitespace
        // http://stackoverflow.com/questions/14220187/uitextfield-has-trailing-whitespace-after-securetextentry-toggle
        
        let beginning = self.beginningOfDocument
        self.selectedTextRange = self.textRangeFromPosition(beginning, toPosition: beginning)
        let end = self.endOfDocument
        self.selectedTextRange = self.textRangeFromPosition(end, toPosition: end)
    }
}
