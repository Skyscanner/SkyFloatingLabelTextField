//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import UIKit

class CustomizingColorsViewController: UIViewController {

    @IBOutlet weak var textField:SkyFloatingLabelTextField?
    
    @IBOutlet var addErrorButton:UIButton?
    
    @IBAction func addError() {
        if(self.addErrorButton?.titleForState(.Normal) == "Add error") {
            self.textField?.errorMessage = "error message"
            self.addErrorButton?.setTitle("Clear error", forState: .Normal)
        } else {
            self.textField?.errorMessage = ""
            self.addErrorButton?.setTitle("Add error", forState: .Normal)
        }
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
