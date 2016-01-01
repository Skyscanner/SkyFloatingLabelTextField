//
//  SubclassingViewController.swift
//  Demo
//
//  Created by Daniel Langh on 01/01/16.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

import UIKit

class SubclassingViewController: UIViewController {

    @IBOutlet var textField:ThemedTextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blueColor = UIColor(red: 0.0, green: 221.0/256.0, blue: 238.0/256.0, alpha: 1.0)
        self.view.tintColor = blueColor
    }
    
    @IBAction func addError() {
        self.textField?.errorMessage = "error message"
    }
    
    @IBAction func resignTextField() {
        self.textField?.resignFirstResponder()
    }

}
