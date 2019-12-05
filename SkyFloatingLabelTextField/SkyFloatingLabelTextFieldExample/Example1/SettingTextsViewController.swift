//  Copyright 2016-2019 Skyscanner Ltd
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

class SettingTextsViewController: UIViewController {

    @IBOutlet var textField: SkyFloatingLabelTextField?
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var addErrorButton: UIButton?
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.translatesAutoresizingMaskIntoConstraints = true
        scrollView.contentSize = CGSize(width: view.frame.width, height: 2000);
    }
    
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
        textField?.resignFirstResponder()
    }

    @IBAction func selectedTitleChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            textField?.selectedTitle = nil
        case 1:
            textField?.selectedTitle = "Selected title"
        default:
            break
        }
    }

    @IBAction func titleChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            textField?.title = nil
        case 1:
            textField?.title = "Deselected title"
        default:
            break
        }
    }

    @IBAction func placeholderChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            textField?.placeholder = nil
        case 1:
            textField?.placeholder = NSLocalizedString(
                "Placeholder",
                tableName: "SkyFloatingLabelTextField",
                comment: "placeholder for field"
            )
        default:
            break
        }
    }

    @IBAction func enabledChanged(_ sender: Any) {
        if let textField = textField {
            textField.isEnabled = !textField.isEnabled
        }
    }
    
    @IBAction func animationOnTouchChanged(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            textField?.isAnimationOnTouch = false
        case 1:
            textField?.isAnimationOnTouch = true
        default:
            break
        }
    }
}
