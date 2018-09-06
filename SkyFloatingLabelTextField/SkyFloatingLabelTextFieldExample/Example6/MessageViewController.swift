//
//  MessageViewController.swift
//  SkyFloatingLabelTextFieldExample
//
//  Created by David Tomić on 06/09/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBOutlet weak var textField: SkyFloatingLabelTextFieldWithMessage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addMessageClicked(_ sender: UIButton) {
        if let _ = textField.message {
            sender.setTitle("Add Message", for: .normal)
            textField.message = nil
        } else {
            sender.setTitle("Clear Message", for: .normal)
            textField.message = "Copyright © 2018 Skyscanner. All rights reserved"
        }
    }
}
