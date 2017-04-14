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

class DelegateMethodsViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: SkyFloatingLabelTextField?
    @IBOutlet var logTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        textField?.delegate = self
        logTextView?.text = ""
    }

    @IBOutlet var addErrorButton: UIButton?

    @IBAction func addError() {
        let localizedAddError = NSLocalizedString(
            "Add error",
            tableName: "SkyFloatingLabelTextField",
            comment: "add error button title"
        )
        if addErrorButton?.title(for: .normal) == localizedAddError {
            textField?.errorMessage = NSLocalizedString(
                "error message",
                tableName: "SkyFloatingLabelTextField",
                comment: "error message"
            )
            addErrorButton?.setTitle(
                NSLocalizedString(
                    "Clear error",
                    tableName: "SkyFloatingLabelTextField",
                    comment: "clear errors button title"
                ),
                for: .normal
            )
        } else {
            textField?.errorMessage = ""
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

    @IBAction func resignTextField() {
        self.textField?.resignFirstResponder()
    }

    func log(text: String) {
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let row = "\(formatter.string(from: date as Date)) : \(text)"
        logTextView.text = "\(row)\n" + logTextView.text!
    }

    // MARK: - SkyFloatingLabelTextField delegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        log(text: "textFieldDidBeginEditing:")
    }

    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        log(text: "textField:shouldChangeCharactersInRange:replacementString:")
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        log(text: "textFieldDidEndEditing:")
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        log(text: "textFieldShouldBeginEditing:")
        return true
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        log(text: "textFieldShouldClear:")
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        log(text: "textFieldShouldEndEditing:")
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        log(text: "textFieldShouldReturn")
        return true
    }
}
