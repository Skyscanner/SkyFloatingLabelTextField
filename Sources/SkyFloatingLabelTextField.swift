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
public class SkyFloatingLabelTextField: UITextField {
    
    // MARK: Animation timing
    
    /// The value of the title appearing duration
    public var titleFadeInDuration:NSTimeInterval = 0.2
    /// The value of the title disappearing duration
    public var titleFadeOutDuration:NSTimeInterval = 0.3
    
    // MARK: Colors
    
    private var cachedTextColor:UIColor?
    
    /// A UIColor value that determines the text color of the editable text
    @IBInspectable
    override public var textColor:UIColor? {
        set {
            self.cachedTextColor = newValue
            self.updateControl(false)
        }
        get {
            return cachedTextColor
        }
    }
    
    /// A UIColor value that determines text color of the placeholder label
    @IBInspectable public var placeholderColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// A UIColor value that determines text color of the placeholder label
    @IBInspectable public var placeholderFont:UIFont? {
        didSet {
            self.setNeedsDisplay()
        }
    }

    /// A UIColor value that determines the text color of the title label when in the normal state
    @IBInspectable public var titleColor:UIColor = UIColor.grayColor() {
        didSet {
            self.updateTitleColor()
        }
    }
    
    /// A UIColor value that determines the color of the bottom line when in the normal state
    @IBInspectable public var lineColor:UIColor = UIColor.lightGrayColor() {
        didSet {
            self.updateLineView()
        }
    }
    
    /// A UIColor value that determines the color used for the title label and the line when the error message is not `nil`
    @IBInspectable public var errorColor:UIColor = UIColor.redColor() {
        didSet {
            self.updateColors()
        }
    }
    
    /// A UIColor value that determines the text color of the title label when editing
    @IBInspectable public var selectedTitleColor:UIColor = UIColor.blueColor() {
        didSet {
            self.updateTitleColor()
        }
    }
    
    /// A UIColor value that determines the color of the line in a selected state
    @IBInspectable public var selectedLineColor:UIColor = UIColor.blackColor() {
        didSet {
            self.updateLineView()
        }
    }
    
    // MARK: Line height
    
    /// A CGFloat value that determines the height for the bottom line when the control is in the normal state
    @IBInspectable public var lineHeight:CGFloat = 0.5 {
        didSet {
            self.updateLineView()
            self.setNeedsDisplay()
        }
    }
    
    /// A CGFloat value that determines the height for the bottom line when the control is in a selected state
    @IBInspectable public var selectedLineHeight:CGFloat = 1.0 {
        didSet {
            self.updateLineView()
            self.setNeedsDisplay()
        }
    }
    
    // MARK: View components
    
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
    override public var secureTextEntry:Bool {
        set {
            super.secureTextEntry = newValue
            self.fixCaretPosition()
        }
        get {
            return super.secureTextEntry
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
    
    /*
    /// A Boolean value that determines if the receiver is currently editing.
    public var editing:Bool {
        get {
            return self.isFirstResponder() || self.selected
        }
    }*/
    
    /// A Boolean value that determines whether the receiver has an error message.
    public var hasErrorMessage:Bool {
        get {
            return self.errorMessage != nil
        }
    }
    
    /// A Boolean value that determines whether the receiver has text input.
    /*
    public var hasText:Bool {
        get {
            super.hasText()
            if let text = self.text {
                return text.characters.count > 0
            }
            return false
        }
    }*/
    
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
    
    @IBInspectable
    override public var text:String? {
        didSet {
            self.resetErrorMessageIfPresent()
            self.updateControl(false)
        }
    }
    
    /// Sets the value of the textfield
    public func setText(text:String?, animated:Bool = false) {
        super.text = text
        self.resetErrorMessageIfPresent()
        self.updateControl(animated)
    }
    
    /**
     The String to display when the input field is empty.
     The placeholder can also appear in the title label when both `title` `selectedTitle` and are `nil`.
     */
    @IBInspectable
    override public var placeholder:String? {
        didSet {
            self.setNeedsDisplay()
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
        self.init_SkyFloatingLabelTextField()
    }
    
    /**
     Intialzies the control by deserializing it
     - parameter coder the object to deserialize the control from
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.init_SkyFloatingLabelTextField()
    }
    
    private final func init_SkyFloatingLabelTextField() {
        self.borderStyle = .None
        self.createTitleLabel()
        self.createLineView()
        self.updateColors()
        self.addTextChangeObserver()
    }
    
    private func addTextChangeObserver() {
        self.addTarget(self, action: Selector("textChanged:"), forControlEvents: .EditingChanged)
    }
    
    public func textChanged(textField:UITextField) {
        resetErrorMessageIfPresent()
        updateControl(true)
        updateTitleLabel(true)
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
        let onePixel:CGFloat = 1.0 / UIScreen.mainScreen().scale
        self.lineHeight = 2.0 * onePixel
        self.selectedLineHeight = 2.0 * self.lineHeight
    }
    
    // MARK: Responder handling
    
    /**
    Attempt the control to become the first responder
    @return True when successfull becoming the first responder
    */
    override public func becomeFirstResponder() -> Bool {
        let success = super.becomeFirstResponder()
        self.updateControl(true)
        return success
    }
    
    /**
     Attempt the control to resign being the first responder
     @return True when successfull resigning being the first responder
     */
    override public func resignFirstResponder() -> Bool {
        let success = super.resignFirstResponder()
        self.updateControl(true)
        return success
    }
    
    // MARK: - View updates
    
    private func updateControl(animated:Bool = false) {
        self.updateColors()
        self.updateLineView()
        self.updateTitleLabel(animated)
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
            super.textColor = self.errorColor
        } else {
            super.textColor = self.cachedTextColor
        }
    }
    
    // MARK: - Title handling
    
    private func updateTitleLabel(animated:Bool = false) {
        
        var titleText:String? = nil
        if self.hasErrorMessage {
            titleText = self.titleFormatter(errorMessage!)
        } else {
            if self.editing {
                titleText = self.selectedTitleOrTitlePlaceholder()
                if titleText == nil {
                    titleText = self.titleOrPlaceholder()
                }
            } else {
                titleText = self.titleOrPlaceholder()
            }
        }
        self.titleLabel.text = titleText
        
        let titleVisible = (titleText != nil) && self.hasText()
        self.setTitleVisibile(titleVisible, animated: animated)
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
    
    // MARK: - UITextField text/placeholder positioning Overrides
    
    override public func textRectForBounds(bounds: CGRect) -> CGRect {
        let titleHeight = self.titleHeight()
        let lineHeight = self.selectedLineHeight
        let rect = CGRectMake(0, titleHeight, bounds.size.width, bounds.size.height - titleHeight - lineHeight)
        return rect
    }
    
    override public func editingRectForBounds(bounds: CGRect) -> CGRect {
        let titleHeight = self.titleHeight()
        let lineHeight = self.selectedLineHeight
        let rect = CGRectMake(0, titleHeight, bounds.size.width, bounds.size.height - titleHeight - lineHeight)
        return rect
    }
    
    override public func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        let titleHeight = self.titleHeight()
        let lineHeight = self.selectedLineHeight
        let rect = CGRectMake(0, titleHeight, bounds.size.width, bounds.size.height - titleHeight - lineHeight)
        return rect
    }
    
    override public func drawPlaceholderInRect(rect: CGRect) {
        if let
            placeholder = self.placeholder,
            font = self.placeholderFont ?? self.font {
                var adjustedRect = rect
                adjustedRect.origin.y = rect.origin.y + (rect.size.height - font.lineHeight)/2.0
                (placeholder as NSString).drawInRect(adjustedRect, withAttributes: [NSForegroundColorAttributeName:self.placeholderColor, NSFontAttributeName: font])
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
        if titleLabel != nil {
            if let font = self.titleLabel.font {
                return font.lineHeight
            }
        }
        return 15.0
    }
    
    /**
     -returns the calculated height of the textfield. Override to size the textfield with a different height
     */
    public func textHeight() -> CGFloat {
        return self.font!.lineHeight + 7.0
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
        _renderingInInterfaceBuilder = true
        self.updateControl(false)
        self.invalidateIntrinsicContentSize()
    }
    
    /// Invoked by layoutIfNeeded automatically
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.frame = self.titleLabelRectForBounds(self.bounds, editing: self.hasText() || _renderingInInterfaceBuilder)
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
        if(!self.hasText()) {
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
    
    private func selectedTitleOrTitlePlaceholder() -> String? {
        if let title = self.selectedTitle ?? self.title ?? self.placeholder {
            return self.titleFormatter(title)
        }
        return nil
    }
}