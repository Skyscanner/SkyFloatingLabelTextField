//
//  CustomLayoutTextField.swift
//  Demo
//
//  Created by Daniel Langh on 01/01/16.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

import UIKit


public class CustomLayoutTextField: WatermarkedTextField {
    
    public var iconLabel:UILabel?
    public var iconInset:CGFloat = 20.0
    
    override public init(frame: CGRect, textField: UITextField?, lineView: UIView?) {
        super.init(frame: frame, textField: textField, lineView: lineView)
        self.createIconLabel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createIconLabel()
    }
    
    // MARK: - Icon label
    
    func createIconLabel() {
        let iconLabel = UILabel()
        iconLabel.backgroundColor = UIColor.clearColor()
        iconLabel.font = UIFont(name: "Dashicons-Regular", size: 15)
        iconLabel.text = ""
        iconLabel.textAlignment = .Center
        iconLabel.frame = CGRectMake(0, self.bounds.size.height - 30.0, 20, 30.0)
        iconLabel.autoresizingMask = [.FlexibleTopMargin, .FlexibleRightMargin]
        self.iconLabel = iconLabel
        self.addSubview(iconLabel)
    }
    
    private func updateIconLabelColor() {
        self.iconLabel?.textColor = self.editing ? self.selectedLineColor : self.lineColor
    }
    
    override public func updateColors() {
        super.updateColors()
        self.updateIconLabelColor()
    }
    
    // MARK: - Custom layout overrides
    
    override public func lineViewRectForBounds(bounds: CGRect, editing: Bool) -> CGRect {
        if editing {
            return CGRectMake(0, bounds.size.height-3.0, bounds.size.width, 3.0)
        } else {
            return CGRectMake(0, bounds.size.height-1.0, bounds.size.width, 1.0)
        }
    }
    
    override public func textFieldRectForBounds(bounds: CGRect) -> CGRect {
        let lineHeight = self.textField.font!.lineHeight
        return CGRectMake(iconInset, lineHeight, bounds.size.width-iconInset, bounds.size.height - lineHeight)
    }
    
    override public func placeholderLabelRectForBounds(bounds: CGRect) -> CGRect {
        let lineHeight = self.textField.font!.lineHeight
        return CGRectMake(iconInset, lineHeight, bounds.size.width-iconInset, bounds.size.height - lineHeight)
    }
}
