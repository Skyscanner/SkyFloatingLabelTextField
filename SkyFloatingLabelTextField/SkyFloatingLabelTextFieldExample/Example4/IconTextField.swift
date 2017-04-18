//  Copyright 2016-2017 Skyscanner Ltd
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

@IBDesignable
public class IconTextField: SkyFloatingLabelTextField {

    public var iconLabel: UILabel!
    public var iconWidth: CGFloat = 25.0

    @IBInspectable
    public var icon: String? {
        didSet {
            iconLabel?.text = icon
        }
    }

    // MARK: Initializers

    override public init(frame: CGRect) {
        super.init(frame: frame)
        createIconLabel()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createIconLabel()
    }

    // MARK: Creating the icon label

    func createIconLabel() {
        iconLabel = UILabel()
        iconLabel.backgroundColor = UIColor.clear
        iconLabel.textAlignment = .center
        iconLabel.autoresizingMask = [.flexibleTopMargin, .flexibleRightMargin]
        addSubview(iconLabel)

        updateIconLabelColor()
    }

    // MARK: Handling the icon color

    override public func updateColors() {
        updateColors()
        updateIconLabelColor()
    }

    private func updateIconLabelColor() {
        if hasErrorMessage {
            iconLabel?.textColor = errorColor
        } else {
            iconLabel?.textColor = isEditing ? selectedLineColor : lineColor
        }
    }

    // MARK: Custom layout overrides

    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        if isLTRLanguage {
            rect.origin.x += iconWidth
        } else {
            rect.origin.x = 0
        }
        rect.size.width -= iconWidth
        return rect
    }
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.origin.x += iconWidth - iconWidth
        rect.size.width -= iconWidth
        return rect
    }

    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.placeholderRect(forBounds: bounds)
        rect.origin.x += iconWidth
        rect.size.width -= iconWidth
        return rect
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        let textWidth: CGFloat = bounds.size.width

        if isLTRLanguage {
            iconLabel.frame = CGRect(
                x: 0,
                y: bounds.size.height - textHeight(),
                width: iconWidth,
                height: textHeight()
            )
        } else {
            iconLabel.frame = CGRect(
                x: textWidth - iconWidth,
                y: bounds.size.height - textHeight(),
                width: iconWidth,
                height: textHeight()
            )
        }
    }
}
