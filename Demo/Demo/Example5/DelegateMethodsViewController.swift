//
//  DelegateMethodsViewController.swift
//  Demo
//
//  Created by Daniel Langh on 01/01/16.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

import UIKit

class DelegateMethodsViewController: UIViewController, WatermarkedTextFieldDelegate {

    @IBOutlet var textField:WatermarkedTextField?
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

    
    // MARK: - WatermarkedTextField delegate
    
    func watermarkedTextFieldDidBeginEditing(watermarkedTextField: WatermarkedTextField) {
        self.log("watermarkedTextFieldDidBeginEditing:")
    }
    
    func watermarkedTextField(watermarkedTextField: WatermarkedTextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.log("watermarkedTextField:shouldChangeCharactersInRange:replacementString:")
        return true
    }
    
    func watermarkedTextFieldDidEndEditing(watermarkedTextField: WatermarkedTextField) {
        self.log("watermarkedTextFieldDidEndEditing:")
    }
    
    func watermarkedTextFieldShouldBeginEditing(watermarkedTextField: WatermarkedTextField) -> Bool {
        self.log("watermarkedTextFieldShouldBeginEditing:")
        return true
    }
    
    func watermarkedTextFieldShouldClear(watermarkedTextField: WatermarkedTextField) -> Bool {
        self.log("watermarkedTextFieldShouldClear:")
        return true
    }
    
    func watermarkedTextFieldShouldEndEditing(watermarkedTextField: WatermarkedTextField) -> Bool {
        self.log("watermarkedTextFieldShouldEndEditing:")
        return true
    }
    
    func watermarkedTextFieldShouldReturn(watermarkedTextField: WatermarkedTextField) -> Bool {
        self.log("watermarkedTextFieldShouldReturn")
        return true
    }
}
