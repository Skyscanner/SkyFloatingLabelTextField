//
//  CustomizingColorsViewController.swift
//  Demo
//
//  Created by Daniel Langh on 31/12/15.
//  Copyright © 2015 Skyscanner. All rights reserved.
//

import UIKit

class CustomizingColorsViewController: UIViewController {

    @IBOutlet weak var textField:SkyFloatingLabelTextField?
    
    @IBAction func addError() {
        self.textField?.errorMessage = "error message"
    }
    
    @IBAction func resignTextField() {
        self.textField?.resignFirstResponder()
    }
    
    @IBAction func titleColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.titleColor = self.colorForSegmentIndex(segmentedControl.selectedSegmentIndex)
    }

    @IBAction func selectedTitleColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.selectedTitleColor = self.colorForSegmentIndex(segmentedControl.selectedSegmentIndex)
    }

    @IBAction func placeholderColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.placeholderColor = self.colorForSegmentIndex(segmentedControl.selectedSegmentIndex)
    }

    @IBAction func textColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.textColor = self.colorForSegmentIndex(segmentedControl.selectedSegmentIndex)
    }

    @IBAction func errorColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.errorColor = self.colorForSegmentIndex(segmentedControl.selectedSegmentIndex)
    }

    @IBAction func tintColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.tintColor = self.colorForSegmentIndex(segmentedControl.selectedSegmentIndex)
    }

    // MARK: helper
    
    func colorForSegmentIndex(segmentIndex:Int) -> UIColor {
        switch segmentIndex {
        case 0: return UIColor.whiteColor()
        case 1: return UIColor.redColor()
        case 2: return UIColor.blueColor()
        default: return UIColor.blackColor()
        }
    }
}
