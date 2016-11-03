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
        if(self.addErrorButton?.title(for: .normal) == NSLocalizedString("Add error", tableName: "SkyFloatingLabelTextField", comment: "add error button title")) {
            self.textField?.errorMessage = NSLocalizedString("error message", tableName: "SkyFloatingLabelTextField", comment: "error message")
            self.addErrorButton?.setTitle(NSLocalizedString("Clear error", tableName: "SkyFloatingLabelTextField", comment: "clear errors button title"), for: .normal)
        } else {
            self.textField?.errorMessage = ""
            self.addErrorButton?.setTitle(NSLocalizedString("Add error", tableName: "SkyFloatingLabelTextField", comment: "add error button title"), for: .normal)
        }
    }
    
    @IBAction func resignTextField() {
        let _ = self.textField?.resignFirstResponder()
    }
    
    @IBAction func titleColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.titleColor = self.colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    @IBAction func selectedTitleColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.selectedTitleColor = self.colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    @IBAction func placeholderColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.placeholderColor = self.colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    @IBAction func textColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.textColor = self.colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    @IBAction func errorColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.errorColor = self.colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    @IBAction func tintColorChanged(segmentedControl:UISegmentedControl) {
        self.textField?.tintColor = self.colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    // MARK: helper
    
    func colorForSegmentIndex(segmentIndex:Int) -> UIColor {
        switch segmentIndex {
        case 0: return UIColor.white
        case 1: return UIColor.red
        case 2: return UIColor.blue
        default: return UIColor.black
        }
    }
}
