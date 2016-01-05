//
//  ShowcaseExampleViewController.swift
//  Demo
//
//  Created by Gergely Orosz on 04/01/2016.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

import UIKit

class ShowcaseExampleViewController: UIViewController, SkyFloatingLabelTextFieldDelegate {
    
    var departureCityField: SkyFloatingLabelTextField!
    var arrivalCityField: SkyFloatingLabelTextField!
    var titleField: SkyFloatingLabelTextField!
    var firstNameField: SkyFloatingLabelTextField!
    var lastNameField: SkyFloatingLabelTextField!
    
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
        self.updateCityFieldsLayout()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateCityFieldLengths() {
        // Whenever departure or arrival fields are selected, have them take up more space
    }
    
    func setupDepartureCityField() {
        self.departureCityField = SkyFloatingLabelTextField()
        self.departureCityField.placeholder = "Departure City"
        self.departureCityField.delegate = self
        self.applySkyscannerTheme(self.departureCityField)
        self.view.addSubview(self.departureCityField)
    }
    
    func setupArrivalCityField() {
        self.arrivalCityField = SkyFloatingLabelTextField()
        self.arrivalCityField.placeholder = "Arrival City"
        self.arrivalCityField.delegate = self
        self.applySkyscannerTheme(self.arrivalCityField)
        self.view.addSubview(self.arrivalCityField)
    }
    
    // MARK: - Styling the text fields to the Skyscanner theme
    
    func applySkyscannerTheme(textField: SkyFloatingLabelTextField) {
        
        let onePixelHeight = 1.0 / Double(UIScreen.mainScreen().scale)
        
        let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
        let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
        
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
            self.cityFieldsSplitPercentage = 0.6;
        }
        else if(textField == self.arrivalCityField) {
            self.cityFieldsSplitPercentage = 0.4;
        }
    }

}
