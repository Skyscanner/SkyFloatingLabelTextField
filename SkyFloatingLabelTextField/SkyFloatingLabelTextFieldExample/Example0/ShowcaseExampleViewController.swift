//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import UIKit

let isLTRLanguage = UIApplication.sharedApplication().userInterfaceLayoutDirection == .LeftToRight

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
        self.departureCityField.placeholder     = NSLocalizedString("Departure City", tableName: "SkyFloatingLabelTextField", comment: "placeholder for the departure city field")
        self.departureCityField.selectedTitle   = NSLocalizedString("Departure City", tableName: "SkyFloatingLabelTextField", comment: "title for the departure city field")
        self.departureCityField.title           = NSLocalizedString("Departure City", tableName: "SkyFloatingLabelTextField", comment: "title for the departure city field")

        self.applySkyscannerThemeWithIcon(self.arrivalCityField)
        if isLTRLanguage {
            self.arrivalCityField.iconRotationDegrees = 90
        } else { // In RTL languages the plane should point to the other side
            self.arrivalCityField.iconRotationDegrees = 180
            self.departureCityField.iconRotationDegrees = 270
        }
        self.arrivalCityField.iconText = "\u{f072}"

        self.arrivalCityField.placeholder     = NSLocalizedString("Arrival City", tableName: "SkyFloatingLabelTextField", comment: "placeholder for the arrival city field")
        self.arrivalCityField.selectedTitle   = NSLocalizedString("Arrival City", tableName: "SkyFloatingLabelTextField", comment: "title for the arrival city field")
        self.arrivalCityField.title           = NSLocalizedString("Arrival City", tableName: "SkyFloatingLabelTextField", comment: "title for the arrival city field")
        
        self.titleField.placeholder     = NSLocalizedString("Title", tableName: "SkyFloatingLabelTextField", comment: "placeholder for person title field")
        self.titleField.selectedTitle   = NSLocalizedString("Title", tableName: "SkyFloatingLabelTextField", comment: "selected title for person title field")
        self.titleField.title           = NSLocalizedString("Title", tableName: "SkyFloatingLabelTextField", comment: "title for person title field")

        self.nameField.placeholder     = NSLocalizedString("Name", tableName: "SkyFloatingLabelTextField", comment: "placeholder for traveler name field")
        self.nameField.selectedTitle   = NSLocalizedString("Name", tableName: "SkyFloatingLabelTextField", comment: "selected title for traveler name field")
        self.nameField.title           = NSLocalizedString("Name", tableName: "SkyFloatingLabelTextField", comment: "title for traveler name field")
        
        self.emailField.placeholder     = NSLocalizedString("Email", tableName: "SkyFloatingLabelTextField", comment: "placeholder for Email field")
        self.emailField.selectedTitle   = NSLocalizedString("Email", tableName: "SkyFloatingLabelTextField", comment: "selected title for Email field")
        self.emailField.title           = NSLocalizedString("Email", tableName: "SkyFloatingLabelTextField", comment: "title for Email field")

        self.applySkyscannerTheme(self.titleField)
        self.applySkyscannerTheme(self.nameField)
        self.applySkyscannerTheme(self.emailField)
        
        self.arrivalCityField.delegate = self
        self.departureCityField.delegate = self
        self.titleField.delegate = self
        self.nameField.delegate = self
        self.emailField.delegate = self
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
    
    var isSubmitButtonPressed = false
    
    var highlightingAnimationInProgress = false
    
    @IBAction func submitButtonDown(sender: AnyObject) {
        self.isSubmitButtonPressed = true
        if !self.departureCityField.hasText() {
            self.highlightingAnimationInProgress = true
            // By setting the highlighted property to true, the floating title is shown
            self.departureCityField.setHighlighted(true, animated: false, animationCompletion: self.highligtingAnimationComplete)
        }
        if !self.arrivalCityField.hasText() {
            self.highlightingAnimationInProgress = true
            self.arrivalCityField.setHighlighted(true, animated: false, animationCompletion: self.highligtingAnimationComplete)
        }
        if !self.titleField.hasText() {
            self.highlightingAnimationInProgress = true
            self.titleField.setHighlighted(true, animated: false, animationCompletion: self.highligtingAnimationComplete)
        }
        if !self.nameField.hasText() {
            self.highlightingAnimationInProgress = true
            self.nameField.setHighlighted(true, animated: false, animationCompletion: self.highligtingAnimationComplete)
        }
        if !self.emailField.hasText() {
            self.highlightingAnimationInProgress = true
            self.emailField.setHighlighted(true, animated: false, animationCompletion: self.highligtingAnimationComplete)
        }
    }
    
    @IBAction func submitButtonTouchUpInside(sender: AnyObject) {
        self.isSubmitButtonPressed = false
        if(!self.highlightingAnimationInProgress) {
            self.departureCityField.highlighted = false
            self.arrivalCityField.highlighted = false
            self.titleField.highlighted = false
            self.nameField.highlighted = false
            self.emailField.highlighted = false
        }
    }
    
    func highligtingAnimationComplete() {
        // If a field is not filled out, display the highlighted title for 0.3 seco
        let displayTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(0.3 * Double(NSEC_PER_SEC)))
        dispatch_after(displayTime, dispatch_get_main_queue(), {
            self.highlightingAnimationInProgress = false
            if(!self.isSubmitButtonPressed) {
                self.departureCityField.highlighted = false
                self.arrivalCityField.highlighted = false
                self.titleField.highlighted = false
                self.nameField.highlighted = false
                self.emailField.highlighted = false
            }
        })
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
        self.validateEmailTextFieldWithText()string
        return true
    }
    
    func validateEmailTextFieldWithText(email: String) {
        if(email.characters.count == 0) {
            self.emailField.errorMessage = nil
        }
        else if(!isValidEmail(email)) {
            self.emailField.errorMessage = NSLocalizedString("Email not valid", tableName: "SkyFloatingLabelTextField", comment: " ")
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
