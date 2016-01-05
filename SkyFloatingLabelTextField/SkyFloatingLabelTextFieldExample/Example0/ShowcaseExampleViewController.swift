//
//  ShowcaseExampleViewController.swift
//  Demo
//
//  Created by Gergely Orosz on 04/01/2016.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

import UIKit

class ShowcaseExampleViewController: UIViewController, SkyFloatingLabelTextFieldDelegate {
    
    var departureCityField: SkyFloatingLabelTextFieldWithIcon!
    var arrivalCityField: SkyFloatingLabelTextFieldWithIcon!
    var titleField: SkyFloatingLabelTextField!
    var firstNameField: SkyFloatingLabelTextField!
    var lastNameField: SkyFloatingLabelTextField!
    var submitButton: UIButton!
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
    
    var cityFieldsSplitPercentage: CGFloat = 0.5 {
        didSet {
            self.updateCityFieldsLayout()
        }
    }
    
    override func awakeFromNib() {
        // force viewDidLoad to execute
        NSLog("awakeFromNib %@", self.view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDepartureCityField()
        self.setupArrivalCityField()
        self.setupTitleField()
        self.setupFirstNameField()
        self.setupLastNameField()
        self.setupSubmitButton()
        
        self.updateCityFieldsLayout()
        self.updateNameFieldsLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Creating the form elements
    
    func setupDepartureCityField() {
        self.departureCityField = SkyFloatingLabelTextFieldWithIcon()
        self.departureCityField.placeholder = "Departure City"
        self.departureCityField.delegate = self
        self.applySkyscannerThemeWithIcon(self.departureCityField)
        self.departureCityField.iconText = "\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
        
        self.view.addSubview(self.departureCityField)
    }
    
    func setupArrivalCityField() {
        self.arrivalCityField = SkyFloatingLabelTextFieldWithIcon()
        self.arrivalCityField.placeholder = "Arrival City"
        self.arrivalCityField.delegate = self
        self.applySkyscannerThemeWithIcon(self.arrivalCityField)
        self.arrivalCityField.iconRotationDegrees = 90
        self.arrivalCityField.iconText = "\u{f072}"
        self.view.addSubview(self.arrivalCityField)
    }
    
    func setupTitleField() {
        self.titleField = SkyFloatingLabelTextField()
        self.titleField.placeholder = "Title"
        self.titleField.delegate = self
        self.applySkyscannerTheme(self.titleField)
        self.view.addSubview(self.titleField)
    }
    
    func setupFirstNameField() {
        self.firstNameField = SkyFloatingLabelTextField()
        self.firstNameField.placeholder = "Firstname"
        self.firstNameField.delegate = self
        self.applySkyscannerTheme(self.firstNameField)
        self.view.addSubview(self.firstNameField)
    }
    
    func setupLastNameField() {
        self.lastNameField = SkyFloatingLabelTextField()
        self.lastNameField.placeholder = "Lastname"
        self.lastNameField.delegate = self
        self.applySkyscannerTheme(self.lastNameField)
        self.view.addSubview(self.lastNameField)
    }
    
    func setupSubmitButton() {
        let offsetY:CGFloat = 222
        let screenWidth:CGFloat = self.view.bounds.width
        let buttonWidth:CGFloat = 150
        let buttonHeight:CGFloat = 40
        let marginRight:CGFloat = 12
        
        self.submitButton = UIButton(frame: CGRectMake(screenWidth - buttonWidth - marginRight, offsetY, buttonWidth, buttonHeight))
        self.submitButton.setTitle("Submit", forState: .Normal)
        self.submitButton.setTitleColor(darkGreyColor, forState: .Normal)
        self.submitButton.setTitleColor(overcastBlueColor, forState: .Highlighted)
        self.submitButton.layer.borderColor = darkGreyColor.CGColor
        self.submitButton.layer.borderWidth = 1
        self.submitButton.layer.cornerRadius = 5
        self.submitButton.addTarget(self, action: "submitButtonPressStarted", forControlEvents: .TouchDown)
        self.submitButton.addTarget(self, action: "submitButtonPressEnded", forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.submitButton)
    }
    
    func updateNameFieldsLayout() {
        let offsetY:CGFloat = 142
        let marginLeft:CGFloat = 12
        let marginRight:CGFloat = 12
        let spacingBetweenFields:CGFloat = 12
        let fieldHeight:CGFloat = 50
        let screenWidth:CGFloat = self.view.bounds.width
        
        let titleFieldLength:CGFloat = 50
        let nameFieldLength = (screenWidth - marginLeft - marginRight - 2*spacingBetweenFields - titleFieldLength) / 2
        
        self.titleField.frame = CGRectMake(marginLeft, offsetY, titleFieldLength, fieldHeight)
        self.firstNameField.frame = CGRectMake(marginLeft + titleFieldLength + spacingBetweenFields, offsetY, nameFieldLength, fieldHeight)
        self.lastNameField.frame = CGRectMake(marginLeft + titleFieldLength + nameFieldLength + 2 * spacingBetweenFields, offsetY, nameFieldLength, fieldHeight)
    }
    
    // MARK: - Styling the text fields to the Skyscanner theme
    
    func applySkyscannerThemeWithIcon(textField: SkyFloatingLabelTextFieldWithIcon) {
        self.applySkyscannerTheme(textField)
        
        textField.iconColor = lightGreyColor
        textField.selectedIconColor = overcastBlueColor
        textField.iconFont = UIFont(name: "FontAwesome", size: 15)
    }
    
    func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        
        let onePixelHeight = 1.0 / Double(UIScreen.mainScreen().scale)
        
        textField.tintColor = overcastBlueColor
        
        textField.textColor = darkGreyColor
        textField.lineColor = lightGreyColor
        textField.lineHeight = onePixelHeight
        
        textField.selectedTitleColor = overcastBlueColor
        textField.selectedLineColor = overcastBlueColor
        textField.selectedLineHeight = 2 * onePixelHeight
        
        // Set custom fonts for the title, placeholder and textfield labels
        textField.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        textField.placeholderLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        textField.textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
    }
    
    // MARK: - Validating the fields when "submit" is pressed
    
    func submitButtonPressStarted() {
        // By setting the highlighted property to true, the floating title is shown
        if (self.departureCityField.textField.text ?? "").isEmpty {
            self.departureCityField.highlighted = true
        }
        if (self.arrivalCityField.textField.text ?? "").isEmpty {
            self.arrivalCityField.highlighted = true
        }
        if (self.titleField.textField.text ?? "").isEmpty {
            self.titleField.highlighted = true
        }
        if (self.firstNameField.textField.text ?? "").isEmpty {
            self.firstNameField.highlighted = true
        }
        if (self.lastNameField.textField.text ?? "").isEmpty {
            self.lastNameField.highlighted = true
        }
    }
    
    func submitButtonPressEnded() {
        // When setting the highlighted property to false, if the textfield is not selected, then the title field disappears
        self.departureCityField.highlighted = false
        self.arrivalCityField.highlighted = false
        self.titleField.highlighted = false
        self.firstNameField.highlighted = false
        self.lastNameField.highlighted = false
    }
    
    // MARK: - Animating the width change of the city fields
    
    func updateCityFieldsLayout() {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.layoutCityFields()
        })
    }
    
    func layoutCityFields() {
        let offsetY:CGFloat = 72
        let marginLeft:CGFloat = 12
        let marginRight:CGFloat = 12
        let spacingBetweenFields:CGFloat = 12
        let screenWidth:CGFloat = self.view.bounds.width
        let contentWidth = screenWidth - marginLeft - marginRight - spacingBetweenFields
        let cityFieldHeight:CGFloat = 50
        
        let departureCityFieldWidth = contentWidth * self.cityFieldsSplitPercentage
        let arrivalCityFieldWidth = contentWidth * (1 - self.cityFieldsSplitPercentage)
        
        self.departureCityField.frame = CGRectMake(marginLeft, offsetY, departureCityFieldWidth, cityFieldHeight)
        self.arrivalCityField.frame = CGRectMake(marginLeft + departureCityFieldWidth + spacingBetweenFields, offsetY, arrivalCityFieldWidth, cityFieldHeight)
    }
    
    // MARK: - Delegate
    
    func textFieldDidBeginEditing(textField: SkyFloatingLabelTextField) {
        if(textField == self.departureCityField) {
            self.cityFieldsSplitPercentage = 0.65;
        }
        else if(textField == self.arrivalCityField) {
            self.cityFieldsSplitPercentage = 0.35;
        }
    }

}
