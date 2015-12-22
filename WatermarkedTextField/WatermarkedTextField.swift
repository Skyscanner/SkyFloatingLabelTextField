//
//  WatermarkedTextField.swift
//  Demo
//
//  Created by Daniel Langh on 21/12/15.
//  Copyright © 2015 Skyscanner. All rights reserved.
//

import UIKit

// MARK: -

protocol HighlightableView {
    var highlighted:Bool {get set}
}

// MARK: - UITextField extension

extension UITextField {
    func fixCaretPosition() {
        // TODO: this is a fix for the caret position
        // http://stackoverflow.com/questions/14220187/uitextfield-has-trailing-whitespace-after-securetextentry-toggle
        
        let beginning = self.beginningOfDocument
        self.selectedTextRange = self.textRangeFromPosition(beginning, toPosition: beginning)
        let end = self.endOfDocument
        self.selectedTextRange = self.textRangeFromPosition(end, toPosition: end)
    }
}

// MARK: - WatermarkedTextFieldDelegate

@objc protocol WatermarkedTextFieldDelegate: class {
    func watermarkedTextFieldDidBeginEditing(watermarkedTextField:WatermarkedTextField)
    func watermarkedTextFieldDidEndEditing(watermarkedTextField:WatermarkedTextField)
    func watermarkedTextFieldShouldReturn(watermarkedTextField:WatermarkedTextField) -> Bool
}

// MARK: - WatermarkedTextField

@IBDesignable
class WatermarkedTextField: UIControl, UITextFieldDelegate {

    // MARK: animation variables
    
    var titleFadeInDuration:Double = 0.2
    var titleFadeOutDuration:Double = 0.6
    var placeholderFadeInDuration:Double = 0.2
    var placeholderFadeOutDuration:Double = 0.6
    var notHighlightedFadeOutDelay:Double = 0.2
    
    // MARK: colors
    
    @IBInspectable var textColor:UIColor = UIColor.blackColor() {
        didSet {
            self.textField.textColor = textColor
        }
    }

    @IBInspectable var placeholderColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            self.placeholderLabel.textColor = placeholderColor
        }
    }
    
    @IBInspectable var errorColor:UIColor = UIColor.redColor() {
        didSet {
            self.updateTitleColor()
        }
    }
    
    @IBInspectable var titleColor:UIColor = UIColor.grayColor() {
        didSet {
            self.updateTitleColor()
        }
    }
    
    @IBInspectable var selectedLineColor:UIColor = UIColor.blackColor() {
        didSet {
            self.updateLineColor()
        }
    }
    @IBInspectable var lineColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            self.updateLineColor()
        }
    }
    @IBInspectable var caretColor:UIColor? {
        didSet {
            self.textField?.valueForKey("textInputTraits")?.setValue(caretColor, forKey: "insertionPointColor")
        }
    }

    // MARK: delegate
    
    @IBOutlet weak var delegate:WatermarkedTextFieldDelegate?

    // MARK: view components
    
    var textField:UITextField!
    var placeholderLabel:UILabel!
    var lineView:UIView!
    var titleLabel:UILabel!
    
    // MARK: properties
    
    var titleFormatter:(String -> String) = { (text:String) -> String in
        return text.uppercaseString
    }
    
    var secureTextEntry:Bool = false {
        didSet {
            self.textField.secureTextEntry = secureTextEntry
            self.textField.fixCaretPosition()
        }
    }
    
    var errorMessage:String? {
        didSet {
            self.updateControl(true)
        }
    }
    
    override var enabled:Bool {
        set {
            super.enabled = newValue
            self.textField.enabled = newValue
        }
        get {
            return super.enabled
        }
    }
    
    override var highlighted:Bool {
        set {
            self.setHighlighted(newValue, animated:false)
        }
        get {
            return super.highlighted
        }
    }
    
    var editing:Bool {
        get {
            return self.isFirstResponder() || self.tooltipVisible
        }
    }
    
    var hasErrorMessage:Bool {
        get {
            return self.errorMessage != nil
        }
    }
    
    var hasText:Bool {
        get {
            if let text = self.text {
                return text.characters.count > 0
            }
            return false
        }
    }
    
    var _text:String?
    @IBInspectable var text:String? {
        set {
            self.setText(newValue, animated:false)
        }
        get {
            return _text
        }
    }
    
    @IBInspectable var placeholder:String? {
        didSet {
            self.placeholderLabel.text = placeholder
            self.updateTitleLabel()
        }
    }
    
    @IBInspectable var selectedTitle:String? {
        didSet {
            self.updateControl()
        }
    }
    
    @IBInspectable var deselectedTitle:String? {
        didSet {
            self.updateControl()
        }
    }
    
    var tooltipVisible:Bool = false {
        didSet {
            self.updateControl(true)
        }
    }
    
    var titleHeight:CGFloat = 20.0
    
    // MARK: - init
    
    init(frame:CGRect, textField:UITextField?, lineView:UIView?) {
        super.init(frame: frame)
        
        self.lineView = lineView
        self.textField = textField
        self.createLineView()
        self.createTitleLabel()
        self.createPlaceholderLabel()
        self.createTextField()
    }
    
    override convenience init(frame: CGRect) {
        self.init(frame:frame, textField:nil, lineView:nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createLineView()
        self.createTitleLabel()
        self.createPlaceholderLabel()
        self.createTextField()
    }
    
    // MARK: create components
    
    func createTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        titleLabel.font = UIFont.systemFontOfSize(13)
        titleLabel.alpha = 0.0
        titleLabel.textColor = self.titleColor
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
    }
    
    func createPlaceholderLabel() {
        let placeholderLabel = UILabel()
        placeholderLabel.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        placeholderLabel.font = UIFont.systemFontOfSize(18.0)
        placeholderLabel.textColor = self.placeholderColor
        placeholderLabel.alpha = 1.0
        self.addSubview(placeholderLabel)
        self.placeholderLabel = placeholderLabel
    }
    
    func createTextField() {
        
        if self.textField == nil {
            let textField = UITextField()
            textField.font = UIFont.systemFontOfSize(18.0)
            self.textField = textField
        }
        textField.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        textField.delegate = self
        textField.addTarget(self, action: Selector("editingDidEndOnExit:"), forControlEvents: .EditingDidEndOnExit)
        textField.addTarget(self, action: Selector("textFieldChanged:"), forControlEvents: .EditingChanged)
        self.addSubview(textField)
    }
    
    func createLineView() {
        
        if self.lineView == nil {
            let lineView = UIView()
            lineView.userInteractionEnabled = false
            self.lineView = lineView
        }
        lineView.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
        self.addSubview(lineView)
    }
    
    // MARK: input
    
    func installDummyInputView() {
        self.textField.inputView = UIView(frame: CGRectZero)
    }
    
    // MARK: responder
    
    override func becomeFirstResponder() -> Bool {
        self.textField.userInteractionEnabled = true
        let success = self.textField.becomeFirstResponder()
        if !success {
            self.textField.userInteractionEnabled = false
        }
        self.updateControl(true)
        return success
    }
    
    override func resignFirstResponder() -> Bool {
        let success = self.textField.resignFirstResponder()
        if success {
            self.textField.userInteractionEnabled = false
        }
        self.updateControl(true)
        return success
    }
    
    override func isFirstResponder() -> Bool {
        return self.textField.isFirstResponder() || self.textField.editing
    }
    
    // MARK: -

    func resetErrorMessageIfPresent() {
        if self.hasErrorMessage {
            self.errorMessage = nil
        }
    }
    
    // MARK: -
    
    func deselectedTitleOrPlaceholder() -> String? {
        if let title = self.deselectedTitle ?? self.placeholder {
            return self.titleFormatter(title)
        }
        return nil
    }
    
    func selectedTitleOrPlaceholder() -> String? {
        if let title = self.selectedTitle ?? self.placeholder {
            return self.titleFormatter(title)
        }
        return nil
    }
    
    func setText(text:String?, animated:Bool = false) {
        _text = text
        self.textField.text = text
        self.resetErrorMessageIfPresent()
        self.updateControl(animated)
    }
    
    func setHighlighted(highlighted:Bool, animated:Bool = false) {
        if(super.highlighted != highlighted) {
            super.highlighted = highlighted
            
            if(highlighted) {
                self.updatePlaceholderLabelVisibility()
                self.updateTitleLabel()
            } else {
                self.performSelector(Selector("fadeoutHighlighted"), withObject: self, afterDelay: notHighlightedFadeOutDelay)
            }
        }
    }
    
    // MARK: -
    
    func updateControl(animated:Bool = false) {
        
        self.updateLineColor()
        self.updateTitleLabel(animated)
        self.updatePlaceholderLabelVisibility()
        
        if var leftView = self.textField.leftView as? HighlightableView {
            leftView.highlighted = self.editing
        }
    }
    
    func updatePlaceholderLabelVisibility() {
        self.placeholderLabel.hidden = self.hasText
    }
    
    func hidePlaceholder(animated:Bool = false) {

        UIView.animateWithDuration(placeholderFadeOutDuration) { () -> Void in
            self.placeholderLabel.alpha = 0.0
        }
    }
    
    // MARK: - selection states
    
    func updateLineColor() {
        if self.hasErrorMessage {
            self.lineView.backgroundColor = self.errorColor
        } else {
            self.lineView.backgroundColor = self.editing ? self.selectedLineColor : self.lineColor
        }
    }
    func updateTitleColor() {
        if self.hasErrorMessage {
            self.titleLabel.textColor = self.errorColor
        } else {
            self.titleLabel.textColor = self.titleColor
        }
    }
    
    // MARK: -
    
    func updateTitleLabel(animated:Bool = false) {

        if let errorMessage = self.errorMessage {
            self.titleLabel.text = self.titleFormatter(errorMessage)
            self.showTitleIfHidden(animated)
        }
        else {
            let editing = self.editing
            
            if editing {
                self.titleLabel.text = self.selectedTitleOrPlaceholder()
            } else {
                self.titleLabel.text = self.deselectedTitleOrPlaceholder()
            }
            
            if self.hasText || self.hasErrorMessage {
                self.showTitleIfHidden(animated)
            } else {
                self.hideTitle(animated)
            }
        }
        self.updateTitleColor()
    }
    
    func showTitleIfHidden(animated:Bool = false) {
        
        let updateBlock = { () -> Void in
            self.titleLabel.alpha = 1.0
            self.titleLabel.frame = self.titleLabelRectForBounds(self.bounds, editing: true)
        }
        if animated {
            UIView.animateWithDuration(titleFadeInDuration, animations: { () -> Void in
                updateBlock()
            })
        } else {
            updateBlock()
        }
    }
    
    func hideTitle(animated:Bool = false) {
        
        let updateBlock = { () -> Void in
            self.titleLabel.alpha = 0.0
            self.titleLabel.frame = self.titleLabelRectForBounds(self.bounds, editing: false)
        }
        if animated {
            UIView.animateWithDuration(titleFadeInDuration, animations: { () -> Void in
                updateBlock()
            })
        } else {
            updateBlock()
        }
    }
    
    func fadeoutHighlighted() {
        
        // TODO:
        /*
        if self.isFirstResponder() {
            if !self.hasText {
                self.hideTitle(true)
            }
        } else {
            if !self.hasText {
                self.hideTitle(true)
            } else {
                self.hidePlaceholder(true)
            }
        }*/
    }
    
    // MARK: - overridable rect calculation
    
    func titleLabelRectForBounds(bounds:CGRect) -> CGRect {
        return self.titleLabelRectForBounds(bounds, editing: self.editing)
    }
    
    func titleLabelRectForBounds(bounds:CGRect, editing:Bool) -> CGRect {

        let lineHeight = self.titleLabel.font.lineHeight
        if editing {
            return CGRectMake(0, 0, bounds.size.width, lineHeight)
        } else {
            return CGRectMake(0, lineHeight, bounds.size.width, lineHeight)
        }
    }

    func lineViewRectForBounds(bounds:CGRect) -> CGRect {
        return self.lineViewRectForBounds(bounds, editing: self.editing)
    }
    
    func lineViewRectForBounds(bounds:CGRect, editing:Bool) -> CGRect {
        let lineWidth:CGFloat = editing ? 1.0 : 0.5
        return CGRectMake(0, bounds.size.height - lineWidth, bounds.size.width, lineWidth);
    }
    
    func textFieldRectForBounds(bounds:CGRect) -> CGRect {
        return CGRectMake(0, titleHeight, bounds.size.width, bounds.size.height - titleHeight)
    }
    
    func placeholderLabelRectForBounds(bounds:CGRect) -> CGRect {
        let offsetX:CGFloat = self.textField.leftView != nil ? CGRectGetMaxX(self.textField.leftView!.frame) : 0.0
        return CGRectMake(offsetX, titleHeight, bounds.size.width - offsetX, bounds.size.height - titleHeight)
    }
    
    // MARK: - textfield delegate

    func textFieldDidBeginEditing(textField: UITextField) {
        self.updateControl(true)
        if let delegate = self.delegate {
            delegate.watermarkedTextFieldDidBeginEditing(self)
        }
    }
    func textFieldDidEndEditing(textField: UITextField) {
        self.updateControl(true)
        if let delegate = self.delegate {
            delegate.watermarkedTextFieldDidEndEditing(self)
        }
    }
    
    func textFieldChanged(textfield: UITextField) {
        self.setText(textField.text, animated: true)
        self.resetErrorMessageIfPresent()
    }
    
    func editingDidEndOnExit(textfield: UITextField) {
        self.sendActionsForControlEvents(.EditingDidEndOnExit)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let delegate = self.delegate {
            return delegate.watermarkedTextFieldShouldReturn(self)
        }
        return true
    }
    
    // MARK: touch handling
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !self.isFirstResponder() {
            self.becomeFirstResponder()
        }
        
        super.touchesBegan(touches, withEvent: event)
    }
    
    // MARK: - layout
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.placeholderLabel.frame = self.placeholderLabelRectForBounds(self.bounds)
        self.textField.frame = self.textFieldRectForBounds(self.bounds)
        self.lineView.frame = self.lineViewRectForBounds(self.bounds, editing: self.editing)
        self.titleLabel.frame = self.titleLabelRectForBounds(self.bounds, editing: self.hasText)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return CGSizeMake(self.bounds.size.width, 50.0)
    }
}

