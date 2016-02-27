//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import UIKit

/**
 A beautiful and flexible textfield implementation with support for title label, error message and placeholder.
 */
@IBDesignable
public class SkyFloatingLabelTextField: UIControl, UITextFieldDelegate {
    
    // MARK: Animation timing
    
    /// The value of the title appearing duration.
    public var titleFadeInDuration:Double = 0.2
    /// The value of the title disappearing duration.
    public var titleFadeOutDuration:Double = 0.3
    
    // MARK: Colors
    
    /// The text color of the editable text.
    @IBInspectable public var textColor:UIColor = UIColor.blackColor() {
        didSet {
            self.updateTextColor()
        }
    }
    
    /// The text color of the placeholder label.
    @IBInspectable public var placeholderColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            self.placeholderLabel.textColor = placeholderColor
        }
    }
    
    /// The text color of the title label when not editing.
    @IBInspectable public var titleColor:UIColor = UIColor.grayColor() {
        didSet {
            self.updateTitleColor()
        }
    }
    
    /// The color of the line when not editing.
    @IBInspectable public var lineColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            self.updateLineView()
        }
    }
    
    /// The color used for the title label and the line when the error message is not `nil`
    @IBInspectable public var errorColor:UIColor = UIColor.redColor() {
        didSet {
            self.updateColors()
        }
    }
    
    /// The text color of the title label when editing.
    @IBInspectable public var selectedTitleColor:UIColor = UIColor.blueColor() {
        didSet {
            self.updateTitleColor()
        }
    }
    
    /// The color of the line when editing.
    @IBInspectable public var selectedLineColor:UIColor = UIColor.blackColor() {
        didSet {
            self.updateLineView()
        }
    }
    
    // MARK: Line height
    
    @IBInspectable public var lineHeight:Double = 0.5 {
        didSet {
            self.updateLineView()
        }
    }
    
    @IBInspectable public var selectedLineHeight:Double = 1.0 {
        didSet {
            self.updateLineView()
        }
    }
    
    // MARK: Delegate
    
    /// The `SkyFloatingLabelTextField` delegate.
    @IBOutlet public weak var delegate:SkyFloatingLabelTextFieldDelegate?
    
    // MARK: View components
    
    /// The internal `UITextField` for text input.
    public var textField:UITextField!
    
    /// The internal `UILabel` that displays the placeholder text when no text input is present.
    public var placeholderLabel:UILabel!
    
    /// The internal `UIView` to display the line below the text input.
    public var lineView:UIView!
    
    /// The internal `UILabel` that displays the selected, deselected title or the error message based on the current state.
    public var titleLabel:UILabel!
    
    // MARK: Properties
    
    /**
    The formatter to use before displaying content in the title label. This can be the `title`, `selectedTitle` or the `errorMessage`.
    The default implementation converts the text to uppercase.
    */
    public var titleFormatter:(String -> String) = { (text:String) -> String in
        return text.uppercaseString
    }
    
    /**
     Identifies whether the text object should hide the text being entered.
     */
    public var secureTextEntry:Bool = false {
        didSet {
            self.textField.secureTextEntry = secureTextEntry
            self.textField.fixCaretPosition()
        }
    }
    
    /// A String value for the error message to display.
    public var errorMessage:String? {
        didSet {
            self.updateControl(true)
        }
    }
    
    /// A Boolean value that determines whether the receiver discards `errorMessage` when the text input is changed.
    public var discardsErrorMessageOnTextChange:Bool = true
    
    /// A Boolean value that determines whether the receiver is enabled.
    override public var enabled:Bool {
        set {
            super.enabled = newValue
            self.textField.enabled = newValue
        }
        get {
            return super.enabled
        }
    }
    
    /// The backing property for the highlighted property
    private var _highlighted = false
    
    /// A Boolean value that determines whether the receiver is highlighted. When changing this value, highlighting will be done with animation
    override public var highlighted:Bool {
        get {
            return _highlighted
        }
        set {
            self.setHighlighted(_highlighted, animated: true)
        }
    }
    
    /**
     Sets the highlighted state with specifying whether this state change should be animated
     
     - parameter highlighted: Whether the field should be highlighted
     - parameter animated: Whether the change in highlighting should be animated
     */
    public func setHighlighted(highlighted:Bool, animated:Bool) {
        _highlighted = highlighted
        if(self.highlighted) {
            self.updateTitleColor()
            _titleVisible = true
            self.updateTitleVisibility(animated, animateFromCurrentState: true)
            self.updateLineView()
        } else {
            if(animated) {
                // Performing fading out after a short timeout to make sure the title previously faded in all the way
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(self.titleFadeInDuration * Double(NSEC_PER_SEC)))
                dispatch_after(time, dispatch_get_main_queue(), { () -> Void in
                    self.fadeOutHighlightedWithAnimated(true)
                })
            } else {
                self.fadeOutHighlightedWithAnimated(false)
            }
        }
    }
    
    /// A Boolean value that determines if the receiver is currently editing.
    public var editing:Bool {
        get {
            return self.isFirstResponder() || self.selected
        }
    }
    
    /// A Boolean value that determines whether the receiver has an error message.
    public var hasErrorMessage:Bool {
        get {
            return self.errorMessage != nil
        }
    }
    
    /// A Boolean value that determines whether the receiver has text input.
    public var hasText:Bool {
        get {
            if let text = self.text {
                return text.characters.count > 0
            }
            return false
        }
    }
    
    private var _titleVisible:Bool = false
    private var _renderingInInterfaceBuilder:Bool = false
    
    /// A Boolean value determining whether the title field is shown
    public var titleVisible:Bool {
        get {
            return _titleVisible
        }
    }
    private func setTitleVisibile(titleVisible:Bool, animated:Bool = false) {
        if titleVisible != _titleVisible {
            _titleVisible = titleVisible
            self.updateTitleVisibility(animated)
        }
    }
    
    private var _text:String?
    
    /// A String value that is displayed in the input field.
    @IBInspectable public var text:String? {
        set {
            self.setText(newValue, animated:false)
        }
        get {
            return _text
        }
    }
    
    /// Sets the value of the textfield
    public func setText(text:String?, animated:Bool = false) {
        _text = text
        self.textField.text = text
        self.resetErrorMessageIfPresent()
        self.updateControl(animated)
        self.delegate?.textFieldChanged?(self)
    }
    
    /**
     The String to display when the input field is empty.
     The placeholder can also appear in the title label when both `title` `selectedTitle` and are `nil`.
     */
    @IBInspectable public var placeholder:String? {
        didSet {
            self.placeholderLabel.text = placeholder
            self.updateTitleLabel()
        }
    }
    
    /// The String to display when the textfield is editing and the input is not empty.
    @IBInspectable public var selectedTitle:String? {
        didSet {
            self.updateControl()
        }
    }
    
    /// The String to display when the textfield is not editing and the input is not empty.
    @IBInspectable public var title:String? {
        didSet {
            self.updateControl()
        }
    }
    
    // Determines whether the field is selected. When selected, the title floats above the textbox.
    public override var selected:Bool {
        didSet {
            self.updateControl(true)
        }
    }
    
    // MARK: - Initializers
    
    /**
    Initializes the control
    - parameter frame the frame of the control
    */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.createTitleLabel()
        self.createPlaceholderLabel()
        self.createTextField()
        self.createLineView()
        self.updateColors()
    }
    
    /**
     Intialzies the control by deserializing it
     - parameter coder the object to deserialize the control from
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createTitleLabel()
        self.createPlaceholderLabel()
        self.createTextField()
        self.createLineView()
        self.updateColors()
    }
    
    // MARK: create components
    
    private func createTitleLabel() {
        let titleLabel = UILabel()
        titleLabel.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        titleLabel.font = UIFont.systemFontOfSize(13)
        titleLabel.alpha = 0.0
        titleLabel.textColor = self.titleColor
        self.addSubview(titleLabel)
        self.titleLabel = titleLabel
    }
    
    private func createPlaceholderLabel() {
        let placeholderLabel = UILabel()
        placeholderLabel.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        placeholderLabel.font = UIFont.systemFontOfSize(18.0)
        placeholderLabel.textColor = self.placeholderColor
        placeholderLabel.alpha = 1.0
        self.addSubview(placeholderLabel)
        self.placeholderLabel = placeholderLabel
    }
    
    private func createTextField() {
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
    
    private func createLineView() {
        
        if self.lineView == nil {
            let lineView = UIView()
            lineView.userInteractionEnabled = false
            self.lineView = lineView
            self.configureDefaultLineHeight()
        }
        lineView.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
        self.addSubview(lineView)
    }
    
    private func configureDefaultLineHeight() {
        let onePixel = 1.0 / Double(UIScreen.mainScreen().scale)
        self.lineHeight = 2.0 * onePixel
        self.selectedLineHeight = 2.0 * self.lineHeight
    }
    
    // MARK: Responder handling
    
    /**
    Attempt the control to become the first responder
    @return True when successfull becoming the first responder
    */
    override public func becomeFirstResponder() -> Bool {
        self.textField.userInteractionEnabled = true
        let success = self.textField.becomeFirstResponder()
        if !success {
            self.textField.userInteractionEnabled = false
        }
        self.updateControl(true)
        return success
    }
    
    /**
     Attempt the control to resign being the first responder
     @return True when successfull resigning being the first responder
     */
    override public func resignFirstResponder() -> Bool {
        let success = self.textField.resignFirstResponder()
        if success {
            self.textField.userInteractionEnabled = false
        }
        self.updateControl(true)
        return success
    }
    
    /**
     @return whether the control is currently the first responder
     */
    override public func isFirstResponder() -> Bool {
        return self.textField.isFirstResponder() || self.textField.editing
    }
    
    // MARK: - View updates
    
    private func updateControl(animated:Bool = false) {
        self.updateColors()
        self.updateLineView()
        self.updateTitleLabel(animated)
        self.updatePlaceholderLabelVisibility()
    }
    
    private func updatePlaceholderLabelVisibility() {
        self.placeholderLabel.hidden = self.hasText
    }
    
    private func updateLineView() {
        if let lineView = self.lineView {
            lineView.frame = self.lineViewRectForBounds(self.bounds, editing: self.editing)
        }
        self.updateLineColor()
    }
    
    // MARK: - Color updates
    
    /// Update the colors for the control. Override to customize colors.
    public func updateColors() {
        self.updateLineColor()
        self.updateTitleColor()
        self.updateTextColor()
    }
    
    private func updateLineColor() {
        if self.hasErrorMessage {
            self.lineView.backgroundColor = self.errorColor
        } else {
            self.lineView.backgroundColor = self.editing ? self.selectedLineColor : self.lineColor
        }
    }
    
    private func updateTitleColor() {
        if self.hasErrorMessage {
            self.titleLabel.textColor = self.errorColor
        } else {
            // TODO: unit test that this is set when highlighted
            if self.editing || self.highlighted {
                self.titleLabel.textColor = self.selectedTitleColor
            } else {
                self.titleLabel.textColor = self.titleColor
            }
        }
    }
    
    private func updateTextColor() {
        if self.hasErrorMessage {
            self.textField.textColor = self.errorColor
        } else {
            self.textField.textColor = textColor
        }
    }
    
    // MARK: - Title handling
    
    private func updateTitleLabel(animated:Bool = false) {
        
        if self.hasErrorMessage {
            self.titleLabel.text = self.titleFormatter(errorMessage!)
        } else {
            if self.editing {
                self.titleLabel.text = self.selectedTitleOrPlaceholder()
            } else {
                self.titleLabel.text = self.titleOrPlaceholder()
            }
        }
        self.setTitleVisibile(self.hasErrorMessage || self.hasText, animated: animated)
    }
    
    private func updateTitleVisibility(animated:Bool = false, animateFromCurrentState:Bool = false) {
        let alpha:CGFloat = _titleVisible ? 1.0 : 0.0
        let frame:CGRect = self.titleLabelRectForBounds(self.bounds, editing: _titleVisible)
        let updateBlock = { () -> Void in
            self.titleLabel.alpha = alpha
            self.titleLabel.frame = frame
        }
        if animated {
            var animationOptions:UIViewAnimationOptions = .CurveEaseOut;
            if(animateFromCurrentState) {
                animationOptions = [.BeginFromCurrentState, .CurveEaseOut]
            }
            let duration = _titleVisible ? titleFadeInDuration : titleFadeOutDuration
            
            UIView.animateWithDuration(duration, delay: 0, options: animationOptions, animations: { () -> Void in
                updateBlock()
                }, completion: nil)
        } else {
            updateBlock()
        }
    }
    
    // MARK: - Positioning Overrides
    
    /**
    Calculate the bounds for the title label. Override to create a custom size title field.
    
    - parameter bounds The current bounds of the title
    
    - parameter editing True if the control is selected or highlighted
    
    -returns The rectangle that the title label should render in
    */
    public func titleLabelRectForBounds(bounds:CGRect, editing:Bool) -> CGRect {
        
        let titleHeight = self.titleHeight()
        if editing {
            return CGRectMake(0, 0, bounds.size.width, titleHeight)
        } else {
            return CGRectMake(0, titleHeight, bounds.size.width, titleHeight)
        }
    }
    
    /**
     Calculate the bounds for the textfield component of the control. Override to create a custom size textbox in the control.
     
     - parameter bounds The current bounds of the textfield component
     
     - parameter editing True if the control is selected or highlighted
     
     -returns The rectangle that the textfield component should render in
     */
    public func textFieldRectForBounds(bounds:CGRect) -> CGRect {
        let titleHeight = self.titleHeight()
        return CGRectMake(0, titleHeight, bounds.size.width, bounds.size.height - titleHeight)
    }
    
    /**
     Calculate the bounds for the placeholder component of the control. Override to create a custom size textbox in the control.
     
     - parameter bounds The current bounds of the placeholder component
     
     - parameter editing True if the control is selected or highlighted
     
     -returns The rectangle that the placeholder component should render in
     */
    public func placeholderLabelRectForBounds(bounds:CGRect) -> CGRect {
        let titleHeight = self.titleHeight()
        return CGRectMake(0, titleHeight, bounds.size.width, bounds.size.height - titleHeight)
    }
    
    /**
     Calculate the bounds for the bottom line of the control. Override to create a custom size bottom line in the textbox.
     
     - parameter bounds The current bounds of the line
     
     - parameter editing True if the control is selected or highlighted
     
     -returns The rectangle that the line bar should render in
     */
    public func lineViewRectForBounds(bounds:CGRect, editing:Bool) -> CGRect {
        let lineHeight:CGFloat = editing ? CGFloat(self.selectedLineHeight) : CGFloat(self.lineHeight)
        return CGRectMake(0, bounds.size.height - lineHeight, bounds.size.width, lineHeight);
    }
    
    /**
     -returns the calculated height of the title label. Override to size the title with a different height
     */
    public func titleHeight() -> CGFloat {
        return self.titleLabel.font!.lineHeight
    }
    
    /**
     -returns the calculated height of the textfield. Override to size the textfield with a different height
     */
    public func textHeight() -> CGFloat {
        return self.textField.font!.lineHeight + 7.0
    }
    
    // MARK: - Textfield delegate methods
    
    /**
    Tells the delegate that editing began for the specified text field.
    
    - parameter textField: The text field for which an editing session began.
    */
    public func textFieldDidBeginEditing(textField: UITextField) {
        self.updateControl(true)
        self.delegate?.textFieldDidBeginEditing?(self)
    }
    
    /**
     Tells the delegate that editing stopped for the specified text field.
     
     - parameter textField: The text field for which the editing session ended.
     */
    public func textFieldDidEndEditing(textField: UITextField) {
        self.updateControl(true)
        self.delegate?.textFieldDidEndEditing?(self)
    }
    
    /**
     Asks the delegate if the text field should process the pressing of the return button.
     
     - parameter textField: The text field whose return button was pressed.
     */
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        if let delegate = self.delegate {
            if let result = delegate.textFieldShouldReturn?(self) {
                return result
            }
        }
        return true
    }
    
    /**
     Asks the delegate if the text field should process the pressing of the clear button.
     
     - parameter textField: The text field whose clear button was pressed.
     */
    public func textFieldShouldClear(textField: UITextField) -> Bool {
        if let delegate = self.delegate {
            if let result = delegate.textFieldShouldClear?(self) {
                return result
            }
        }
        return true
    }
    
    /**
     Asks the delegate if editing should begin in the specified text field.
     
     - parameter textField: The text field for which editing is about to begin.
     
     - returns: `true` if an editing session should be initiated; otherwise, `false` to disallow editing.
     */
    public func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if let delegate = self.delegate {
            if let result = delegate.textFieldShouldBeginEditing?(self) {
                return result
            }
        }
        return true
    }
    
    /**
     Asks the delegate if editing should stop in the specified text field.
     
     - parameter textField: The text field for which editing is about to end.
     
     - returns: `true` if editing should stop; otherwise, `false` if the editing session should continue
     */
    public func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        if let delegate = self.delegate {
            if let result = delegate.textFieldShouldEndEditing?(self) {
                return result
            }
        }
        return true
    }
    
    /**
     Asks the delegate if editing should stop in the specified text field.
     
     - parameter textField: The text field containing the text.
     - parameter range: The range of characters to be replaced.
     - parameter string: The replacement string.
     
     - returns: `true` if the specified text range should be replaced; otherwise, `false` to keep the old text.
     */
    public func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let delegate = self.delegate {
            if let result = delegate.textField?(self, shouldChangeCharactersInRange: range, replacementString: string) {
                return result
            }
        }
        return true
    }
    
    // MARK: TextField target actions
    
    internal func textFieldChanged(textfield: UITextField) {
        self.setText(textfield.text, animated: true)
        self.resetErrorMessageIfPresent()
    }
    
    internal func editingDidEndOnExit(textfield: UITextField) {
        self.sendActionsForControlEvents(.EditingDidEndOnExit)
    }
    
    // MARK: Touch handling
    
    /// Invoked when a touch event has started
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if !self.isFirstResponder() {
            self.becomeFirstResponder()
        }
        
        super.touchesBegan(touches, withEvent: event)
    }
    
    // MARK: - Layout
    
    /// Invoked when the interface builder renders the control
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.selected = true
        self.titleLabel.alpha = 1.0
        _renderingInInterfaceBuilder = true
        self.updateColors()
    }
    
    /// Invoked by layoutIfNeeded automatically
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.frame = self.titleLabelRectForBounds(self.bounds, editing: self.hasText || _renderingInInterfaceBuilder)
        self.placeholderLabel.frame = self.placeholderLabelRectForBounds(self.bounds)
        self.textField.frame = self.textFieldRectForBounds(self.bounds)
        self.lineView.frame = self.lineViewRectForBounds(self.bounds, editing: self.editing || _renderingInInterfaceBuilder)
    }
    
    /**
     Calculate the content size for auto layout
     
     - returns: the content size to be used for auto layout
     */
    override public func intrinsicContentSize() -> CGSize {
        return CGSizeMake(self.bounds.size.width, self.titleHeight() + self.textHeight())
    }
    
    // MARK: - Helpers
    
    private func fadeOutHighlightedWithAnimated(animated: Bool) {
        if(!self.hasText) {
            self.updateTitleColor()
            _titleVisible = false
            self.updateTitleVisibility(animated, animateFromCurrentState: true)
            self.updateLineView()
        }
    }
    
    private func resetErrorMessageIfPresent() {
        if self.hasErrorMessage && discardsErrorMessageOnTextChange {
            self.errorMessage = nil
        }
    }
    
    private func titleOrPlaceholder() -> String? {
        if let title = self.title ?? self.placeholder {
            return self.titleFormatter(title)
        }
        return nil
    }
    
    private func selectedTitleOrPlaceholder() -> String? {
        if let title = self.selectedTitle ?? self.placeholder {
            return self.titleFormatter(title)
        }
        return nil
    }
}