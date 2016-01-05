//
//  DelegateMethodsViewController.swift
//  Demo
//
//  Created by Daniel Langh on 01/01/16.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

import UIKit

class DelegateMethodsViewController: UIViewController, SkyFloatingLabelTextFieldDelegate {

    @IBOutlet var textField:SkyFloatingLabelTextField?
    @IBOutlet var logTextView:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textField?.delegate = self
        self.logTextView?.text = ""
    }
    
    @IBAction func addError() {
        self.textField?.errorMessage = "error message"
    }
    
    @IBAction func resignTextField() {
        self.textField?.resignFirstResponder()
    }
    
    func log(text:String) {
        let date = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let row = "\(formatter.stringFromDate(date)) : \(text)"
        logTextView.text = "\(row)\n" + logTextView.text!
    }

    
    // MARK: - SkyFloatingLabelTextField delegate
    
    func textFieldDidBeginEditing(textField: SkyFloatingLabelTextField) {
        self.log("textFieldDidBeginEditing:")
    }
    
    func textField(textField: SkyFloatingLabelTextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.log("textField:shouldChangeCharactersInRange:replacementString:")
        return true
    }
    
    func textFieldDidEndEditing(textField: SkyFloatingLabelTextField) {
        self.log("textFieldDidEndEditing:")
    }
    
    func textFieldShouldBeginEditing(textField: SkyFloatingLabelTextField) -> Bool {
        self.log("textFieldShouldBeginEditing:")
        return true
    }
    
    func textFieldShouldClear(textField: SkyFloatingLabelTextField) -> Bool {
        self.log("textFieldShouldClear:")
        return true
    }
    
    func textFieldShouldEndEditing(textField: SkyFloatingLabelTextField) -> Bool {
        self.log("textFieldShouldEndEditing:")
        return true
    }
    
    func textFieldShouldReturn(textField: SkyFloatingLabelTextField) -> Bool {
        self.log("textFieldShouldReturn")
        return true
    }
}
