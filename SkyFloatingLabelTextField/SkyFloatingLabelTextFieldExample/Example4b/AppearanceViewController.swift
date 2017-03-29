//
//  AppearanceViewController.swift
//  SkyFloatingLabelTextField
//
//  Created by Martin Wildfeuer on 29.03.17.
//  Copyright © 2017 Skyscanner. All rights reserved.
//

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
        if(addErrorButton?.title(for: .normal) == NSLocalizedString("Add error", tableName: "SkyFloatingLabelTextField", comment: "add error button title")) {
            label.errorMessage = NSLocalizedString("error message", tableName: "SkyFloatingLabelTextField", comment: "error message")
            addErrorButton.setTitle(NSLocalizedString("Clear error", tableName: "SkyFloatingLabelTextField", comment: "clear errors button title"), for: .normal)
        } else {
            label.errorMessage = ""
            addErrorButton?.setTitle(NSLocalizedString("Add error", tableName: "SkyFloatingLabelTextField", comment: "add error button title"), for: .normal)
        }
    }
}
