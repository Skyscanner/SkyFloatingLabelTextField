//
//  ShowcaseExampleViewController.swift
//  Demo
//
//  Created by Gergely Orosz on 04/01/2016.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

import UIKit

class ShowcaseExampleViewController: UIViewController {
    
    var departureCityField: WatermarkedTextField!
    var arrivalCityField: WatermarkedTextField!
    var titleField: WatermarkedTextField!
    var firstNameField: WatermarkedTextField!
    var lastNameField: WatermarkedTextField!
    
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
        self.departureCityField = WatermarkedTextField()
        self.departureCityField.placeholder = "Departure City"
        self.applySkyscannerTheme(self.departureCityField)
        self.view.addSubview(self.departureCityField)
    }
    
    func setupArrivalCityField() {
        self.arrivalCityField = WatermarkedTextField()
        self.arrivalCityField.placeholder = "Arrival City"
        self.applySkyscannerTheme(self.arrivalCityField)
        self.view.addSubview(self.arrivalCityField)
    }
    
    // MARK: - Styling the text fields to the Skyscanner theme
    
    func applySkyscannerTheme(textField: WatermarkedTextField) {
        
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
        
        textField.textField.font = UIFont(name: "Courier-Bold", size: 18)
        textField.titleLabel.font = UIFont(name: "Courier", size: 12)
        
    }
    
    // MARK: - Animation logic
    
    //
    func updateCityFieldsLayout() {
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
