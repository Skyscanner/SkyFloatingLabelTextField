//  Copyright 2016 Skyscanner Ltd
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

import UIKit

class AppearanceViewController: UIViewController {

    @IBOutlet weak var label: SkyFloatingLabelTextField!
    @IBOutlet weak var iconLabel: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var addErrorButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        iconLabel.iconText = "\u{f072}"
    }

    @IBAction func resignFirstResponder(_ sender: UIButton) {
        label.resignFirstResponder()
    }

    @IBAction func addError(_ sender: UIButton) {
        let localizedAddError = NSLocalizedString(
            "Add error",
            tableName: "SkyFloatingLabelTextField",
            comment: "add error button title"
        )
        if addErrorButton?.title(for: .normal) == localizedAddError {
            label.errorMessage = NSLocalizedString(
                "error message",
                tableName: "SkyFloatingLabelTextField",
                comment: "error message"
            )
            addErrorButton.setTitle(
                NSLocalizedString(
                    "Clear error",
                    tableName: "SkyFloatingLabelTextField",
                    comment: "clear errors button title"
                ),
                for: .normal
            )
        } else {
            label.errorMessage = ""
            addErrorButton?.setTitle(
                NSLocalizedString(
                    "Add error",
                    tableName: "SkyFloatingLabelTextField",
                    comment: "add error button title"
                ),
                for: .normal
            )
        }
    }
}
