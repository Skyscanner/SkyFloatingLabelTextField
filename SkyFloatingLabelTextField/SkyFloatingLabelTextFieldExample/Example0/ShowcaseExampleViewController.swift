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
//  either express or implied. See the License for the specific language governing permissions and
//  limitations under the License.

import UIKit

let isLTRLanguage = UIApplication.shared.userInterfaceLayoutDirection == .leftToRight

class ShowcaseExampleViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var arrivalCityField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var departureCityField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var titleField: SkyFloatingLabelTextField!
    @IBOutlet weak var nameField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var submitButton: UIButton!

    var textFields: [SkyFloatingLabelTextField]!

    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)

    override func viewDidLoad() {
        super.viewDidLoad()

        textFields = [arrivalCityField, departureCityField, titleField, nameField, emailField]

        setupButton()
        setupCities()
        setupUser()

        for textField in textFields {
            textField.delegate = self
        }

        departureCityField.becomeFirstResponder()
    }

    // MARK: - Creating the form elements

    func setupButton() {
        submitButton.layer.borderColor = darkGreyColor.cgColor
        submitButton.layer.borderWidth = 1
        submitButton.layer.cornerRadius = 5
        submitButton.setTitleColor(overcastBlueColor, for: .highlighted)
    }

    func setupCities() {

        applySkyscannerThemeWithIcon(textField: self.departureCityField)

        // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
        departureCityField.iconText = "\u{f072}"
        departureCityField.placeholder = NSLocalizedString(
            "Departure City",
            tableName: "SkyFloatingLabelTextField",
            comment: "placeholder for the departure city field"
        )
        departureCityField.selectedTitle = NSLocalizedString(
            "Departure City",
            tableName: "SkyFloatingLabelTextField",
            comment: "title for the departure city field"
        )
        departureCityField.title = NSLocalizedString(
            "Departure City",
            tableName: "SkyFloatingLabelTextField",
            comment: "title for the departure city field"
        )

        applySkyscannerThemeWithIcon(textField: arrivalCityField)

        if isLTRLanguage {
            arrivalCityField.iconRotationDegrees = 90
        } else { // In RTL languages the plane should point to the other side
            arrivalCityField.iconRotationDegrees = 180
            departureCityField.iconRotationDegrees = 270
        }

        arrivalCityField.iconText = "\u{f072}"

        arrivalCityField.placeholder = NSLocalizedString(
            "Arrival City",
            tableName: "SkyFloatingLabelTextField",
            comment: "placeholder for the arrival city field"
        )
        arrivalCityField.selectedTitle = NSLocalizedString(
            "Arrival City",
            tableName: "SkyFloatingLabelTextField",
            comment: "title for the arrival city field"
        )
        arrivalCityField.title = NSLocalizedString(
            "Arrival City",
            tableName: "SkyFloatingLabelTextField",
            comment: "title for the arrival city field"
        )
    }

    func setupUser() {

        titleField.placeholder = NSLocalizedString(
            "Title",
            tableName: "SkyFloatingLabelTextField",
            comment: "placeholder for person title field"
        )
        titleField.selectedTitle = NSLocalizedString(
            "Title",
            tableName: "SkyFloatingLabelTextField",
            comment: "selected title for person title field"
        )
        titleField.title = NSLocalizedString(
            "Title",
            tableName: "SkyFloatingLabelTextField",
            comment: "title for person title field"
        )

        nameField.placeholder = NSLocalizedString(
            "Name",
            tableName: "SkyFloatingLabelTextField",
            comment: "placeholder for traveler name field"
        )
        nameField.selectedTitle = NSLocalizedString(
            "Name",
            tableName: "SkyFloatingLabelTextField",
            comment: "selected title for traveler name field"
        )
        nameField.title = NSLocalizedString(
            "Name",
            tableName: "SkyFloatingLabelTextField",
            comment: "title for traveler name field"
        )

        emailField.placeholder = NSLocalizedString(
            "Email",
            tableName: "SkyFloatingLabelTextField",
            comment: "placeholder for Email field"
        )
        emailField.selectedTitle = NSLocalizedString(
            "Email",
            tableName: "SkyFloatingLabelTextField",
            comment: "selected title for Email field"
        )
        emailField.title = NSLocalizedString(
            "Email",
            tableName: "SkyFloatingLabelTextField",
            comment: "title for Email field"
        )

        applySkyscannerTheme(textField: titleField)
        applySkyscannerTheme(textField: nameField)
        applySkyscannerTheme(textField: emailField)

    }

    // MARK: - Styling the text fields to the Skyscanner theme

    func applySkyscannerThemeWithIcon(textField: SkyFloatingLabelTextFieldWithIcon) {
        self.applySkyscannerTheme(textField: textField)

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

    var showingTitleInProgress = false

    @IBAction func submitButtonDown(_ sender: AnyObject) {
        self.isSubmitButtonPressed = true

        for textField in textFields where !textField.hasText {
            showingTitleInProgress = true
            textField.setTitleVisible(
                true,
                animated: true,
                animationCompletion: showingTitleInAnimationComplete
            )
            textField.isHighlighted = true
        }
    }

    @IBAction func submitButtonTouchUpInside(_ sender: AnyObject) {
        isSubmitButtonPressed = false
        if !showingTitleInProgress {
            hideTitleVisibleFromFields()
        }
    }

    func showingTitleInAnimationComplete(_ completed: Bool) {
        // If a field is not filled out, display the highlighted title for 0.3 seco
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.showingTitleInProgress = false
            if !self.isSubmitButtonPressed {
                self.hideTitleVisibleFromFields()
            }
        }
    }

    func hideTitleVisibleFromFields() {

        for textField in textFields {
            textField.setTitleVisible(false, animated: true)
            textField.isHighlighted = false
        }

    }

    // MARK: - Delegate

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Validate the email field
        if textField == emailField {
            validateEmailField()
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

    @IBAction func validateEmailField() {
        validateEmailTextFieldWithText(email: emailField.text)
    }

    func validateEmailTextFieldWithText(email: String?) {
        guard let email = email else {
            emailField.errorMessage = nil
            return
        }

        if email.characters.count == 0 {
            emailField.errorMessage = nil
        } else if !validateEmail(email) {
            emailField.errorMessage = NSLocalizedString(
                "Email not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " "
            )
        } else {
            emailField.errorMessage = nil
        }
    }

    // MARK: - validation

    func validateEmail(_ candidate: String) -> Bool {

        // NOTE: validating email addresses with regex is usually not the best idea.
        // This implementation is for demonstration purposes only and is not recommended for production use.
        // Regex source and more information here: http://emailregex.com

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
}
