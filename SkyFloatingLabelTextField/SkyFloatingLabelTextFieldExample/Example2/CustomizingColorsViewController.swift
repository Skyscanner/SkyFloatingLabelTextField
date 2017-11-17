//  Copyright 2016-2017 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); 
//  you may not use this file except in compliance with the License. 
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under
//  the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
//  either express or implied. See the License for the specific language governing permissions and
//  limitations under the License.

import UIKit

class CustomizingColorsViewController: UIViewController {

    @IBOutlet weak var textField: SkyFloatingLabelTextField?

    @IBOutlet weak var selectedTitleColorControl: UISegmentedControl?
    @IBOutlet weak var titleColorControl: UISegmentedControl?
    @IBOutlet weak var placeholderColorControl: UISegmentedControl?
    @IBOutlet weak var tintColorControl: UISegmentedControl?
    @IBOutlet weak var textColorControl: UISegmentedControl?
    @IBOutlet weak var errorColorControl: UISegmentedControl?

    @IBOutlet var addErrorButton: UIButton?
    @IBOutlet var enableButton: UIButton?
    
    // MARK: - view lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // NOTE: For emojis to appear properly we need to set the color to white
        // http://stackoverflow.com/a/38195951

        var attributes: [String: Any] = [:]

        #if swift(>=4.0)
            attributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
        #else
            attributes = [NSForegroundColorAttributeName: UIColor.white]
        #endif

        selectedTitleColorControl?.setTitleTextAttributes(attributes, for: .selected)
        titleColorControl?.setTitleTextAttributes(attributes, for: .selected)
        textColorControl?.setTitleTextAttributes(attributes, for: .selected)
        errorColorControl?.setTitleTextAttributes(attributes, for: .selected)
        tintColorControl?.setTitleTextAttributes(attributes, for: .selected)
    }

    // MARK: - user actions

    @IBAction func addError() {
        let localizedAddError = NSLocalizedString(
            "Add error",
            tableName: "SkyFloatingLabelTextField",
            comment: "add error button title"
        )

        if self.addErrorButton?.title(for: .normal) == localizedAddError {
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
            self.textField?.errorMessage = ""
            self.addErrorButton?.setTitle(
                NSLocalizedString(
                    "Add error",
                    tableName: "SkyFloatingLabelTextField",
                    comment: "add error button title"
                ),
                for: .normal
            )
        }
    }

    @IBAction func toggleEnable(_ sender: Any) {
        if let textField = textField {
            textField.isEnabled = !textField.isEnabled
            if textField.isEnabled {
                enableButton?.setTitle(
                    NSLocalizedString(
                        "Enable text field",
                        tableName: "SkyFloatingLabelTextField",
                        comment: "enable button title"
                    ),
                    for: .normal)
            } else {
                enableButton?.setTitle(
                    NSLocalizedString(
                        "Disable text field",
                        tableName: "SkyFloatingLabelTextField",
                        comment: "enable button title"
                    ),
                    for: .normal)
            }
        }
    }
    
    @IBAction func resignTextField() {
        textField?.resignFirstResponder()
    }

    @IBAction func titleColorChanged(_ segmentedControl: UISegmentedControl) {
        textField?.titleColor =
            colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    @IBAction func selectedTitleColorChanged(_ segmentedControl: UISegmentedControl) {
        textField?.selectedTitleColor =
            colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    @IBAction func placeholderColorChanged(_ segmentedControl: UISegmentedControl) {
        textField?.placeholderColor =
            colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    @IBAction func textColorChanged(_ segmentedControl: UISegmentedControl) {
        textField?.textColor =
            colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    @IBAction func errorColorChanged(_ segmentedControl: UISegmentedControl) {
        textField?.errorColor =
            colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    @IBAction func tintColorChanged(_ segmentedControl: UISegmentedControl) {
        textField?.tintColor =
            colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }

    @IBAction func disabledColorChanged(_ segmentedControl: UISegmentedControl) {
        textField?.disabledColor =
            colorForSegmentIndex(segmentIndex: segmentedControl.selectedSegmentIndex)
    }
    // MARK: helper

    func colorForSegmentIndex(segmentIndex: Int) -> UIColor {
        switch segmentIndex {
        case 0: return .white
        case 1: return .red
        case 2: return .blue
        default: return .black
        }
    }
}
