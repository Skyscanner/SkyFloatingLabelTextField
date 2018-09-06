//
//  SkyFloatingLabelTextFieldWithMessage.swift
//  SkyFloatingLabelTextField
//
//  Created by David Tomić on 06/09/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

class SkyFloatingLabelTextFieldWithMessage: SkyFloatingLabelTextField {
    
    private var messageLabel: UILabel!
    
    @IBInspectable
    var topMargin: CGFloat = 5 {
        didSet {
            triggerLayoutSubviews()
        }
    }
    
    /// The message content of the textfield
    @IBInspectable
    var message: String? {
        didSet {
            messageLabel.text = message
            triggerLayoutSubviews()
        }
    }
    
    @IBInspectable
    /// A UIColor value that determines the text color of the message label
    var messageColor: UIColor = .gray {
        didSet {
            messageLabel.textColor = messageColor
        }
    }
    
    /// A UIFont value that determines the text font of the message label
    var messageFont: UIFont = .systemFont(ofSize: 12) {
        didSet {
            messageLabel.font = messageFont
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createMessageLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createMessageLabel()
    }
    
    /// Add message label in existing SkyFloatingLabelTextField
    private func createMessageLabel() {
        let messageLabel = UILabel()
        messageLabel.numberOfLines = 0
        messageLabel.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        messageLabel.textColor = messageColor
        messageLabel.font = messageFont
        addSubview(messageLabel)
        self.messageLabel = messageLabel
    }
    
    private var messageLabelHeight: CGFloat {
        if let messageLabel = messageLabel,
            let text = messageLabel.text {
            #if swift(>=4.0)
                let rect = text.boundingRect(with: CGSize(width: CGFloat(bounds.width),
                                                        height: .greatestFiniteMagnitude),
                                                    options: .usesLineFragmentOrigin,
                                                    attributes: [NSAttributedStringKey.font: messageLabel.font],
                                                    context: nil)
            return rect.height
            #else
            let rect = text.boundingRect(with: CGSize(width: CGFloat(bounds.width),
                                                      height: .greatestFiniteMagnitude),
                                         options: .usesLineFragmentOrigin,
                                         attributes: [NSFontAttributeName: messageLabel.font],
                                         context: nil)
            return rect.height
            #endif
        }
        return 0
    }
    
    private var messageLabelHeightWithTopMargin: CGFloat {
        return messageLabelHeight + topMargin
    }
    
    private var hasMessage: Bool {
        return message != nil
    }
    
    private func triggerLayoutSubviews() {
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    /// Invoked by layoutIfNeeded automatically
    override func layoutSubviews() {
        super.layoutSubviews()
        messageLabel.frame = messageLabelRectForBounds(bounds)
        invalidateIntrinsicContentSize()
    }
    
    /**
     Calculate the bounds for the message label of the control.
     - parameter bounds: The current bounds of the label
     - returns: The rectangle that the message label should render in
     */
    private func messageLabelRectForBounds(_ bounds: CGRect) -> CGRect {
        if hasMessage {
            return CGRect(x: 0, y: bounds.size.height - messageLabelHeight,
                          width: bounds.size.width, height: messageLabelHeight)
        }

        return .zero
    }
    
    /**
     Calculate the rectangle for the textfield when it is not being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        rect.size.height -= messageLabelHeightWithTopMargin
        return rect
    }
    
    /**
     Calculate the rectangle for the textfield when it is being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        rect.size.height -= messageLabelHeightWithTopMargin
        return rect
    }
    
    /**
     Calculate the rectangle for the placeholder
     - parameter bounds: The current bounds of the placeholder
     - returns: The rectangle that the placeholder should render in
     */
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.placeholderRect(forBounds: bounds)
        rect.size.height -= messageLabelHeightWithTopMargin
        return rect
    }
    
    /**
     Calculate the bounds for the bottom line of the control.
     - parameter bounds: The current bounds of the line
     - parameter editing: True if the control is selected or highlighted
     - returns: The rectangle that the line bar should render in
     */
    override func lineViewRectForBounds(_ bounds: CGRect, editing: Bool) -> CGRect {
        var rect = super.lineViewRectForBounds(bounds, editing: editing)
        rect.origin.y -= messageLabelHeightWithTopMargin
        return rect
    }
    
    /**
     Calculate the content size for auto layout
     - returns: the content size to be used for auto layout
     */
    override var intrinsicContentSize: CGSize {
        return CGSize(width: super.intrinsicContentSize.width,
                      height: super.intrinsicContentSize.height + messageLabelHeightWithTopMargin)
    }
}
