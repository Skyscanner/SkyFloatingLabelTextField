//
//  CustomLayoutTextField.swift
//  Demo
//
//  Created by Daniel Langh on 01/01/16.
//  Copyright © 2016 Skyscanner. All rights reserved.
//

import UIKit

@IBDesignable
public class IconTextField: WatermarkedTextField {
    
    public var iconLabel:UILabel!
    public var iconWidth:CGFloat = 20.0
    
    @IBInspectable
    public var icon:String? {
        didSet {
            self.iconLabel?.text = icon
        }
    }
    
    // MARK: Initializers
    
    override public init(frame: CGRect, textField: UITextField?, lineView: UIView?) {
        super.init(frame: frame, textField: textField, lineView: lineView)
        self.createIconLabel()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createIconLabel()
    }
    
    // MARK: Creating the icon label
    
    func createIconLabel() {
        let iconLabel = UILabel()
        iconLabel.backgroundColor = UIColor.clearColor()
        iconLabel.font = UIFont(name: "Dashicons-Regular", size: 15)
        iconLabel.textAlignment = .Center
        iconLabel.frame = CGRectMake(0, self.bounds.size.height - 30.0, iconWidth, 30.0)
        iconLabel.autoresizingMask = [.FlexibleTopMargin, .FlexibleRightMargin]
        self.iconLabel = iconLabel
        self.addSubview(iconLabel)

        self.updateIconLabelColor()
    }

    // MARK: Handling the icon color
    
    override public func updateColors() {
        super.updateColors()
        self.updateIconLabelColor()
    }

    private func updateIconLabelColor() {
        if self.hasErrorMessage {
            self.iconLabel?.textColor = self.errorColor
        } else {
            self.iconLabel?.textColor = self.editing ? self.selectedLineColor : self.lineColor
        }
    }
    
    // MARK: Custom layout overrides
    
    override public func textFieldRectForBounds(bounds: CGRect) -> CGRect {
        var rect = super.textFieldRectForBounds(bounds)
        rect.origin.x += iconWidth
        rect.size.width -= iconWidth
        return rect
    }
    
    override public func placeholderLabelRectForBounds(bounds: CGRect) -> CGRect {
        var rect = super.placeholderLabelRectForBounds(bounds)
        rect.origin.x += iconWidth
        rect.size.width -= iconWidth
        return rect
    }
}
