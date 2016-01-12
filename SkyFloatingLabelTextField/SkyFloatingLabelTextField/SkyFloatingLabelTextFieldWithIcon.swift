//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import UIKit

public class SkyFloatingLabelTextFieldWithIcon: SkyFloatingLabelTextField {
    
    public var iconLabel:UILabel!
    public var iconWidth:CGFloat = 20.0
    public var iconMarginLeft:CGFloat = 4.0
    
    /// A UIFont value that determines the font that the icon is using
    @IBInspectable
    public var iconFont:UIFont? {
        didSet {
            self.iconLabel?.font = iconFont
        }
    }
    
    @IBInspectable
    public var iconText:String? {
        didSet {
            self.iconLabel?.text = iconText
        }
    }
    
    @IBInspectable
    public var iconColor:UIColor = UIColor.grayColor() {
        didSet {
            self.updateIconLabelColor()
        }
    }
    
    @IBInspectable
    public var selectedIconColor:UIColor = UIColor.grayColor() {
        didSet {
            self.updateIconLabelColor()
        }
    }
    
    @IBInspectable
    public var iconMarginBottom:Double = 4 {
        didSet {
        }
    }
    
    @IBInspectable
    public var iconRotationDegrees:Double = 0 {
        didSet {
            self.iconLabel.transform = CGAffineTransformMakeRotation(CGFloat(iconRotationDegrees * M_PI / 180.0))
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
        iconLabel.textAlignment = .Center
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
            self.iconLabel?.textColor = self.editing ? self.selectedIconColor : self.iconColor
        }
    }
    
    // MARK: Custom layout overrides
    
    override public func textFieldRectForBounds(bounds: CGRect) -> CGRect {
        var rect = super.textFieldRectForBounds(bounds)
        rect.origin.x += (iconWidth + iconMarginLeft)
        rect.size.width -= (iconWidth + iconMarginLeft)
        return rect
    }
    
    override public func placeholderLabelRectForBounds(bounds: CGRect) -> CGRect {
        var rect = super.placeholderLabelRectForBounds(bounds)
        rect.origin.x += (iconWidth + iconMarginLeft)
        rect.size.width -= (iconWidth + iconMarginLeft)
        return rect
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let textHeight = self.textHeight()
        let marginBottom = CGFloat(self.iconMarginBottom)
        self.iconLabel.frame = CGRectMake(0, self.bounds.size.height - textHeight - marginBottom, iconWidth, textHeight)
    }
}
