//
//  ViewController.swift
//  Demo
//
//  Created by Daniel Langh on 21/12/15.
//  Copyright © 2015 Skyscanner. All rights reserved.
//

import UIKit

class SettingTextsViewController: UIViewController {

    @IBOutlet var textField:WatermarkedTextField?
    
    @IBAction func addError() {
        self.textField?.errorMessage = "error message"
    }
    
    @IBAction func resignTextField() {
        self.textField?.resignFirstResponder()
    }
    
    @IBAction func selectedTitleChanged(segmentedControl:UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                self.textField?.selectedTitle = nil
            case 1:
                self.textField?.selectedTitle = "Selected title"
            default:
                break
        }
    }

    @IBAction func deselectedTitleChanged(segmentedControl:UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.textField?.deselectedTitle = nil
        case 1:
            self.textField?.deselectedTitle = "Deselected title"
        default:
            break
        }
    }
    
    @IBAction func placeholderChanged(segmentedControl:UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.textField?.placeholder = nil
        case 1:
            self.textField?.placeholder = "Placeholder"
        default:
            break
        }
    }
}

