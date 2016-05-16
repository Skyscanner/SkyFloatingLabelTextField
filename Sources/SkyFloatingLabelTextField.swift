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
    /// A Boolean value that determines if the language displayed is LTR. Default value set automatically from the application language settings.
    var isLTRLanguage = UIApplication.sharedApplication().userInterfaceLayoutDirection == .LeftToRight {
        didSet {
           self.updateTextAligment()
        }
    }
    
    private func updateTextAligment() {
        if(self.isLTRLanguage) {
            self.textAlignment = .Left
        } else {
            self.textAlignment = .Right
        }
    }
    
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
            self.updatePlaceholder()
        }
    }

    /// A UIColor value that determines text color of the placeholder label
    @IBInspectable public var placeholderFont:UIFont? {
        didSet {
            self.updatePlaceholder()
        }
    }
    
    private func updatePlaceholder() {
        if let
            placeholder = self.placeholder,
            font = self.placeholderFont ?? self.font {
                self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName:placeholderColor,
                    NSFontAttributeName: font])
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
    
    /// The backing property for the highlighted property
    private var _highlighted = false
    
    /// A Boolean value that determines whether the receiver is highlighted. When changing this value, highlighting will be done with animation
    override public var highlighted:Bool {
        get {
            return _highlighted
        }
        set {
            _highlighted = newValue
            self.updateTitleColor()
            self.updateLineView()
        }
    }

    /// A Boolean value that determines whether the textfield is being edited or is selected.
    public var editingOrSelected:Bool {
        get {
            return super.editing || self.selected;
        }
    }
    
    /// A Boolean value that determines whether the receiver has an error message.
    public var hasErrorMessage:Bool {
        get {
            return self.errorMessage != nil && self.errorMessage != ""
        }
    }

    private var _renderingInInterfaceBuilder:Bool = false
    
    /// The text content of the textfield
    @IBInspectable
    override public var text:String? {
        didSet {
            self.updateControl(false)
        }
    }
    
    /**
     The String to display when the input field is empty.
     The placeholder can also appear in the title label when both `title` `selectedTitle` and are `nil`.
     */
    @IBInspectable
    override public var placeholder:String? {
        didSet {
            self.setNeedsDisplay()
            self.updatePlaceholder()
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
        self.addEditingChangedObserver()
        self.updateTextAligment()
    }
    
    private func addEditingChangedObserver() {
        self.addTarget(self, action: Selector("editingChanged"), forControlEvents: .EditingChanged)
    }
    
    /**
     Invoked when the editing state of the textfield changes. Override to respond to this change.
     */
    public func editingChanged() {
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
     - returns: True when successfull becoming the first responder
    */
    override public func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        self.updateControl(true)
        return result
    }
    
    /**
     Attempt the control to resign being the first responder
     - returns: True when successfull resigning being the first responder
     */
    override public func resignFirstResponder() -> Bool {
        let result =  super.resignFirstResponder()
        self.updateControl(true)
        return result
    }
    
    // MARK: - View updates
    
    private func updateControl(animated:Bool = false) {
        self.updateColors()
        self.updateLineView()
        self.updateTitleLabel(animated)
    }
    
    private func updateLineView() {
        if let lineView = self.lineView {
            lineView.frame = self.lineViewRectForBounds(self.bounds, editing: self.editingOrSelected)
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
            self.lineView.backgroundColor = self.editingOrSelected ? self.selectedLineColor : self.lineColor
        }
    }
    
    private func updateTitleColor() {
        if self.hasErrorMessage {
            self.titleLabel.textColor = self.errorColor
        } else {
            if self.editingOrSelected || self.highlighted {
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
            if self.editingOrSelected {
                titleText = self.selectedTitleOrTitlePlaceholder()
                if titleText == nil {
                    titleText = self.titleOrPlaceholder()
                }
            } else {
                titleText = self.titleOrPlaceholder()
            }
        }
        self.titleLabel.text = titleText
        
        self.updateTitleVisibility(animated)
    }
    
    private var _titleVisible = false
    
    /*
    *   Set this value to make the title visible
    */
    public func setTitleVisible(titleVisible:Bool, animated:Bool = false, animationCompletion: (()->())? = nil) {
        if(_titleVisible == titleVisible) {
            return
        }
        _titleVisible = titleVisible
        self.updateTitleColor()
        self.updateTitleVisibility(animated, completion: animationCompletion)
    }
    
    /**
     Returns whether the title is being displayed on the control.
     - returns: True if the title is displayed on the control, false otherwise.
     */
    public func isTitleVisible() -> Bool {
        return self.hasText() || self.hasErrorMessage || _titleVisible
    }
    
    private func updateTitleVisibility(animated:Bool = false, completion: (()->())? = nil) {
        let alpha:CGFloat = self.isTitleVisible() ? 1.0 : 0.0
        let frame:CGRect = self.titleLabelRectForBounds(self.bounds, editing: self.isTitleVisible())
        let updateBlock = { () -> Void in
            self.titleLabel.alpha = alpha
            self.titleLabel.frame = frame
        }
        if animated {
            let animationOptions:UIViewAnimationOptions = .CurveEaseOut;
            let duration = self.isTitleVisible() ? titleFadeInDuration : titleFadeOutDuration
            
            UIView.animateWithDuration(duration, delay: 0, options: animationOptions, animations: { () -> Void in
                updateBlock()
                }, completion: { _ in
                    completion?()
                })
        } else {
            updateBlock()
            completion?()
        }
    }
    
    // MARK: - UITextField text/placeholder positioning overrides
    
    /** 
    Calculate the rectangle for the textfield when it is not being edited
    - parameter bounds: The current bounds of the field
    - returns: The rectangle that the textfield should render in
    */
    override public func textRectForBounds(bounds: CGRect) -> CGRect {
        super.textRectForBounds(bounds)
        let titleHeight = self.titleHeight()
        let lineHeight = self.selectedLineHeight
        let rect = CGRectMake(0, titleHeight, bounds.size.width, bounds.size.height - titleHeight - lineHeight)
        return rect
    }
    
    /**
     Calculate the rectangle for the textfield when it is being edited
     - parameter bounds: The current bounds of the field
     - returns: The rectangle that the textfield should render in
     */
    override public func editingRectForBounds(bounds: CGRect) -> CGRect {
        let titleHeight = self.titleHeight()
        let lineHeight = self.selectedLineHeight
        let rect = CGRectMake(0, titleHeight, bounds.size.width, bounds.size.height - titleHeight - lineHeight)
        return rect
    }
    
    /**
     Calculate the rectangle for the placeholder
     - parameter bounds: The current bounds of the placeholder
     - returns: The rectangle that the placeholder should render in
     */
    override public func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        let titleHeight = self.titleHeight()
        let lineHeight = self.selectedLineHeight
        let rect = CGRectMake(0, titleHeight, bounds.size.width, bounds.size.height - titleHeight - lineHeight)
        return rect
    }
    
    // MARK: - Positioning Overrides
    
    /**
    Calculate the bounds for the title label. Override to create a custom size title field.
    - parameter bounds: The current bounds of the title
    - parameter editing: True if the control is selected or highlighted
    - returns: The rectangle that the title label should render in
    */
    public func titleLabelRectForBounds(bounds:CGRect, editing:Bool) -> CGRect {
        let titleHeight = self.titleHeight()
        if editing {
            return CGRectMake(0, 0, bounds.size.width, titleHeight)
        }
        return CGRectMake(0, titleHeight, bounds.size.width, titleHeight)
    }

    /**
     Calculate the bounds for the bottom line of the control. Override to create a custom size bottom line in the textbox.
     - parameter bounds: The current bounds of the line
     - parameter editing: True if the control is selected or highlighted
     - returns: The rectangle that the line bar should render in
     */
    public func lineViewRectForBounds(bounds:CGRect, editing:Bool) -> CGRect {
        let lineHeight:CGFloat = editing ? CGFloat(self.selectedLineHeight) : CGFloat(self.lineHeight)
        return CGRectMake(0, bounds.size.height - lineHeight, bounds.size.width, lineHeight);
    }
    
    /**
     Calculate the height of the title label.
     -returns: the calculated height of the title label. Override to size the title with a different height
     */
    public func titleHeight() -> CGFloat {
        if let titleLabel = self.titleLabel,
            font = titleLabel.font {
                return font.lineHeight
        }
        return 15.0
    }
    
    /**
     Calcualte the height of the textfield.
     -returns: the calculated height of the textfield. Override to size the textfield with a different height
     */
    public func textHeight() -> CGFloat {
        return self.font!.lineHeight + 7.0
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
        
        self.titleLabel.frame = self.titleLabelRectForBounds(self.bounds, editing: self.isTitleVisible() || _renderingInInterfaceBuilder)
        self.lineView.frame = self.lineViewRectForBounds(self.bounds, editing: self.editingOrSelected || _renderingInInterfaceBuilder)
    }
    
    /**
     Calculate the content size for auto layout
     
     - returns: the content size to be used for auto layout
     */
    override public func intrinsicContentSize() -> CGSize {
        return CGSizeMake(self.bounds.size.width, self.titleHeight() + self.textHeight())
    }
    
    // MARK: - Helpers
    
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
