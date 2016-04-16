//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import UIKit

class SettingTextsViewController: UIViewController {

    @IBOutlet var textField:SkyFloatingLabelTextField?
    
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

    @IBAction func titleChanged(segmentedControl:UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.textField?.title = nil
        case 1:
            self.textField?.title = "Deselected title"
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

