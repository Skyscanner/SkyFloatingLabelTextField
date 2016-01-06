//
//  ShowcaseExampleViewController.swift
//  Demo
//
//  Created by Gergely Orosz on 04/01/2016.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

import UIKit

class ShowcaseExampleViewController: UIViewController, SkyFloatingLabelTextFieldDelegate {
    
    @IBOutlet weak var arrivalCityField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var departureCityField: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var titleField: SkyFloatingLabelTextField!
    @IBOutlet weak var nameField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailField: SkyFloatingLabelTextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
    let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
    let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)

    override func awakeFromNib() {
        // force viewDidLoad to execute
        //NSLog("awakeFromNib %@", self.view)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupThemeColors()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        textField.placeholderLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 18)
        textField.textField.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
    }
    
    // MARK: - Validating the fields when "submit" is pressed
    
    @IBAction func submitButtonDown(sender: AnyObject) {
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
        if (self.nameField.textField.text ?? "").isEmpty {
            self.nameField.highlighted = true
        }
        if (self.emailField.textField.text ?? "").isEmpty {
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
}
