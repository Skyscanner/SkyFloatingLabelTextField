//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import UIKit

class ShowcaseExampleViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var arrivalCityField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var departureCityField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var titleField: SkyFloatingLabelTextField!
    @IBOutlet weak var nameField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupThemeColors()
        
        self.departureCityField.becomeFirstResponder()
    }
    
    // MARK: - Creating the form elements
    
    func setupThemeColors() {
        self.submitButton.layer.borderColor = darkGreyColor.CGColor
        self.submitButton.layer.borderWidth = 1
        self.submitButton.layer.cornerRadius = 5
        self.submitButton.setTitleColor(overcastBlueColor, forState: .Highlighted)
        
        self.applySkyscannerThemeWithIcon(self.departureCityField)
        self.departureCityField.iconText = "\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
        
        self.applySkyscannerThemeWithIcon(self.arrivalCityField)
        self.arrivalCityField.iconRotationDegrees = 90
        self.arrivalCityField.iconText = "\u{f072}"
        
        self.applySkyscannerTheme(self.titleField)
        self.applySkyscannerTheme(self.nameField)
        self.applySkyscannerTheme(self.emailField)
        
        self.arrivalCityField.delegate = self
        self.departureCityField.delegate = self
        self.titleField.delegate = self
        self.nameField.delegate = self
        self.emailField.delegate = self
        
        //self.arrivalCityField.errorMessage = "Please fill out this field"
        
        /*
        Use cases:
            - when error message is set, show it: wheter text is present, or not
            - when text is set
                - either clear error message
                - or keep it
            - when textfield is foucsed
                - clear error message
                - or keep it
        
            - default behaviour:
                - when text is set, keep error message
                - when textfield is focused, keep error message
            - to change behaviour
                - override setText to clear error message
                - override becomeFirstResponder
        */
        
        // errorMessageBehaviour
        //  - showWhenTextI

        //self.departureCityField.errorMessage = "Please fill out this field"
    }
    
    // MARK: - Styling the text fields to the Skyscanner theme
    
    func applySkyscannerThemeWithIcon(textField: SkyFloatingLabelTextFieldWithIcon) {
        self.applySkyscannerTheme(textField)
        
        textField.iconColor = lightGreyColor
        textField.selectedIconColor = overcastBlueColor
        textField.iconFont = UIFont(name: "FontAwesome", size: 15)
    }
    
    func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        
        textField.tintColor = overcastBlueColor
        
        textField.textColor = darkGreyColor
        textField.lineColor = lightGreyColor
        
        textField.selectedTitleColor = overcastBlueColor
        textField.selectedLineColor = overcastBlueColor
        
        // Set custom fonts for the title, placeholder and textfield labels
        textField.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        textField.placeholderFont = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
    }
    
    // MARK: - Validating the fields when "submit" is pressed
    
    @IBAction func submitButtonDown(sender: AnyObject) {
        // By setting the highlighted property to true, the floating title is shown
        if !self.departureCityField.hasText() {
            self.departureCityField.highlighted = true
        }
        if !self.arrivalCityField.hasText() {
            self.arrivalCityField.highlighted = true
        }
        if !self.titleField.hasText() {
            self.titleField.highlighted = true
        }
        if !self.nameField.hasText() {
            self.nameField.highlighted = true
        }
        if !self.emailField.hasText() {
            self.emailField.highlighted = true
        }
    }

    @IBAction func submitButtonTouchUpInside(sender: AnyObject) {
        // When setting the highlighted property to false, if the textfield is not selected, then the title field disappears
        self.departureCityField.highlighted = false
        self.arrivalCityField.highlighted = false
        self.titleField.highlighted = false
        self.nameField.highlighted = false
        self.emailField.highlighted = false
    }
    
    // MARK: - Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Validate the email field
        if (textField == self.emailField) {
            validateEmailTextField()
        }
        
        // When pressing return, move to the next field
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder! {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        self.validateEmailTextField()
        return true
    }
    
    func validateEmailTextField() {
        if let email = self.emailField.text {
            if(email.characters.count == 0) {
                self.emailField.errorMessage = nil
            }
            else if(!isValidEmail(email)) {
                self.emailField.errorMessage = "Email not valid"
            } else {
                self.emailField.errorMessage = nil
            }
        } else {
             self.emailField.errorMessage = nil
        }
    }
    
    func isValidEmail(str:String?) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(str)
    }
}
