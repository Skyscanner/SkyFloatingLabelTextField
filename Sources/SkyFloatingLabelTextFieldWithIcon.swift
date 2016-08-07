//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import UIKit

/**
 A beautiful and flexible textfield implementation with support for icon, title label, error message and placeholder.
 */
public class SkyFloatingLabelTextFieldWithIcon: SkyFloatingLabelTextField {

    /// A UILabel value that identifies the label used to display the icon
    public var iconLabel:UILabel!
    
    /// A UIFont value that determines the font that the icon is using
    @IBInspectable
    public var iconFont:UIFont? {
        didSet {
            self.iconLabel?.font = iconFont
        }
    }
    
    /// A String value that determines the text used when displaying the icon
    @IBInspectable
    public var iconText:String? {
        didSet {
            self.iconLabel?.text = iconText
        }
    }
    
    /// A UIColor value that determines the color of the icon in the normal state
    @IBInspectable
    public var iconColor:UIColor = UIColor.gray {
        didSet {
            self.updateIconLabelColor()
        }
    }
    
    /// A UIColor value that determines the color of the icon when the control is selected
    @IBInspectable
    public var selectedIconColor:UIColor = UIColor.gray {
        didSet {
            self.updateIconLabelColor()
        }
    }
    
    /// A float value that determines the width of the icon
    @IBInspectable public var iconWidth:CGFloat = 20 {
        didSet {
            self.updateFrame()
        }
    }
    
    /// A float value that determines the left margin of the icon. Use this value to position the icon more precisely horizontally.
    @IBInspectable public var iconMarginLeft:CGFloat = 4 {
        didSet {
            self.updateFrame()
        }
    }
    
    /// A float value that determines the bottom margin of the icon. Use this value to position the icon more precisely vertically.
    @IBInspectable
    public var iconMarginBottom:CGFloat = 4 {
        didSet {
            self.updateFrame()
        }
    }
    
    /// A float value that determines the rotation in degrees of the icon. Use this value to rotate the icon in either direction.
    @IBInspectable
    public var iconRotationDegrees:Double = 0 {
        didSet {
            self.iconLabel.transform = CGAffineTransform(rotationAngle: CGFloat(iconRotationDegrees * M_PI / 180.0))
        }
    }
    
    // MARK: Initializers
    
    /**
    Initializes the control
    - parameter frame the frame of the control
    */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.createIconLabel()
    }
    
    /**
     Intialzies the control by deserializing it
     - parameter coder the object to deserialize the control from
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createIconLabel()
    }
    
    // MARK: Creating the icon label
    
    /// Creates the icon label
    private func createIconLabel() {
        let iconLabel = UILabel()
        iconLabel.backgroundColor = UIColor.clear
        iconLabel.textAlignment = .center
        iconLabel.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        self.iconLabel = iconLabel
        self.addSubview(iconLabel)
        
        self.updateIconLabelColor()
    }
    
    // MARK: Handling the icon color
    
    /// Update the colors for the control. Override to customize colors.
    override public func updateColors() {
        super.updateColors()
        self.updateIconLabelColor()
    }
    
    private func updateIconLabelColor() {
        if self.hasErrorMessage {
            self.iconLabel?.textColor = self.errorColor
        } else {
            self.iconLabel?.textColor = self.editingOrSelected ? self.selectedIconColor : self.iconColor
        }
    }
    
    // MARK: Custom layout overrides
    
    /**
    Calculate the bounds for the textfield component of the control. Override to create a custom size textbox in the control.    
    - parameter bounds: The current bounds of the textfield component
    - returns: The rectangle that the textfield component should render in
    */
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        if isLTRLanguage {
            rect.origin.x += CGFloat(iconWidth + iconMarginLeft)
        } else {
            rect.origin.x -= CGFloat(iconWidth + iconMarginLeft)
        }
        rect.size.width -= CGFloat(iconWidth + iconMarginLeft)
        return rect
    }

    /**
     Calculate the rectangle for the textfield when it is being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        if isLTRLanguage {
            rect.origin.x += CGFloat(iconWidth + iconMarginLeft)
        } else {
            // don't change the editing field X position for RTL languages
        }
        rect.size.width -= CGFloat(iconWidth + iconMarginLeft)
        return rect
    }

    /**
     Calculates the bounds for the placeholder component of the control. Override to create a custom size textbox in the control.
     - parameter bounds: The current bounds of the placeholder component
     - returns: The rectangle that the placeholder component should render in
     */
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.placeholderRect(forBounds: bounds)
        if isLTRLanguage {
            rect.origin.x += CGFloat(iconWidth + iconMarginLeft)
        } else {
            // don't change the editing field X position for RTL languages
        }
        rect.size.width -= CGFloat(iconWidth + iconMarginLeft)
        return rect
    }
    
    /// Invoked by layoutIfNeeded automatically
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrame()
    }
    
    private func updateFrame() {
        let textHeight = self.textHeight()
        let textWidth:CGFloat = self.bounds.size.width
        if isLTRLanguage {
            self.iconLabel.frame = CGRect(x: 0, y: self.bounds.size.height - textHeight - iconMarginBottom, width: iconWidth, height: textHeight)
        } else {
            self.iconLabel.frame = CGRect(x: textWidth - iconWidth , y: self.bounds.size.height - textHeight - iconMarginBottom, width: iconWidth, height: textHeight)
        }
    }
}
