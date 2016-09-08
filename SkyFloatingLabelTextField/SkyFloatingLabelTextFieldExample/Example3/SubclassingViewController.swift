//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import UIKit

class SubclassingViewController: UIViewController {

    @IBOutlet var textField:ThemedTextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SkyFloatingLabelTextField will inherit it's superview's `tintColor`.
        self.view.tintColor = UIColor(red: 0.0, green: 221.0/256.0, blue: 238.0/256.0, alpha: 1.0)
        self.textField?.placeholder = NSLocalizedString("Placeholder", tableName: "SkyFloatingLabelTextField", comment: "")
    }
    
    @IBOutlet var addErrorButton:UIButton?
    
    @IBAction func addError() {
        if(self.addErrorButton?.title(for: .normal) == NSLocalizedString("Add error", tableName: "SkyFloatingLabelTextField", comment: "add error button title")) {
            self.textField?.errorMessage = NSLocalizedString("error message", tableName: "SkyFloatingLabelTextField", comment: "")
            self.addErrorButton?.setTitle(NSLocalizedString("Clear error", tableName: "SkyFloatingLabelTextField", comment: "clear errors button title"), for: .normal)
        } else {
            self.textField?.errorMessage = ""
            self.addErrorButton?.setTitle(NSLocalizedString("Add error", tableName: "SkyFloatingLabelTextField", comment: "add error button title"), for: .normal)
        }
    }
    
    @IBAction func resignTextField() {
        self.textField?.resignFirstResponder()
    }
}
