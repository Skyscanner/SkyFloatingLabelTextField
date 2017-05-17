//
//  SearchTextField.swift
//  SearchTextField
//
//  Created by Alejandro Pasccon on 4/20/16.
//  Copyright © 2016 Alejandro Pasccon. All rights reserved.
//  Edited  by Tristan Richard
//

import UIKit

open class SearchTextField: UITextField {
    
    ////////////////////////////////////////////////////////////////////////
    // Public interface
    
    /// Maximum number of results to be shown in the suggestions list
    open var maxNumberOfResults = 0
    
    /// Maximum height of the results list
    open var maxResultsListHeight = 0
    
    /// Indicate if this field has been interacted with yet
    open var interactedWith = false
    
    /// Indicate if keyboard is showing or not
    open var keyboardIsShowing = false
    
    /// Set your custom visual theme, or just choose between pre-defined SearchTextFieldTheme.lightTheme() and SearchTextFieldTheme.darkTheme() themes
    open var theme = SearchTextFieldTheme.lightTheme() {
        didSet {
            tableView?.reloadData()
            
            if let placeholderColor = theme.placeholderColor {
                if let placeholderString = placeholder {
                    self.attributedPlaceholder = NSAttributedString(string: placeholderString, attributes: [NSForegroundColorAttributeName: placeholderColor])
                }
                
                self.placeholderLabel?.textColor = placeholderColor
            }
        }
    }
    
    /// Show the suggestions list without filter when the text field is focused
    open var startVisible = false
    
    /// Set an array of SearchTextFieldItem's to be used for suggestions
    open func filterItems(_ items: [SearchTextFieldItem]) {
        filterDataSource = items
    }
    
    /// Set an array of strings to be used for suggestions
    open func filterStrings(_ strings: [String]) {
        var items = [SearchTextFieldItem]()
        
        for value in strings {
            items.append(SearchTextFieldItem(title: value))
        }
        
        filterDataSource = items
    }
    
    /// Closure to handle when the user pick an item
    open var itemSelectionHandler: SearchTextFieldItemHandler?
    
    /// Closure to handle when the user stops typing
    open var userStoppedTypingHandler: ((Void) -> Void)?
    
    /// Set your custom set of attributes in order to highlight the string found in each item
    open var highlightAttributes: [String: AnyObject] = [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 10)]
    
    open func showLoadingIndicator() {
        self.rightViewMode = .always
        indicator.startAnimating()
    }
    
    open func stopLoadingIndicator() {
        self.rightViewMode = .never
        indicator.stopAnimating()
    }
    
    open var inlineMode: Bool = false {
        didSet {
            if inlineMode == true {
                autocorrectionType = .no
                spellCheckingType = .no
            }
        }
    }
    
    open var startFilteringAfter: String?
    
    open var comparisonOptions: NSString.CompareOptions = [.caseInsensitive]
    
    ////////////////////////////////////////////////////////////////////////
    // Private implementation
    
    fileprivate var tableView: UITableView?
    fileprivate var shadowView: UIView?
    fileprivate var direction: Direction = .down
    fileprivate var fontConversionRate: CGFloat = 0.7
    fileprivate var keyboardFrame: CGRect?
    fileprivate var timer: Timer? = nil
    fileprivate var placeholderLabel: UILabel?
    fileprivate static let cellIdentifier = "APSearchTextFieldCell"
    fileprivate let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    fileprivate var filteredResults = [SearchTextFieldItem]()
    fileprivate var filterDataSource = [SearchTextFieldItem]() {
        didSet {
            filter(false)
            redrawSearchTableView()
        }
    }
    
    fileprivate var currentInlineItem = ""
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidEndEditing), for: .editingDidEnd)
        self.addTarget(self, action: #selector(SearchTextField.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SearchTextField.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SearchTextField.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SearchTextField.keyboardDidChangeFrame(_:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if inlineMode {
            buildPlaceholderLabel()
        } else {
            buildSearchTableView()
        }
        
        // Create the loading indicator
        indicator.hidesWhenStopped = true
        self.rightView = indicator
    }
    
    override open func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var rightFrame = super.rightViewRect(forBounds: bounds)
        rightFrame.origin.x -= 5
        return rightFrame
    }
    
    // Create the filter table and shadow view
    fileprivate func buildSearchTableView() {
        if let tableView = tableView, let shadowView = shadowView {
            tableView.layer.masksToBounds = true
            tableView.layer.borderWidth = 0.5
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorInset = UIEdgeInsets.zero
            
            shadowView.backgroundColor = UIColor.lightText
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize.zero
            shadowView.layer.shadowOpacity = 1
            
            self.window?.addSubview(tableView)
        } else {
            tableView = UITableView(frame: CGRect.zero)
            shadowView = UIView(frame: CGRect.zero)
        }
        
        redrawSearchTableView()
    }
    
    fileprivate func buildPlaceholderLabel() {
        var newRect = self.placeholderRect(forBounds: self.bounds)
        var caretRect = self.caretRect(for: self.beginningOfDocument)
        let textRect = self.textRect(forBounds: self.bounds)
        
        if let range = textRange(from: beginningOfDocument, to: endOfDocument) {
            caretRect = self.firstRect(for: range)
        }
        
        newRect.origin.x = caretRect.origin.x + caretRect.size.width + textRect.origin.x
        newRect.size.width = newRect.size.width - newRect.origin.x
        
        if let placeholderLabel = placeholderLabel {
            placeholderLabel.font = self.font
            placeholderLabel.frame = newRect
        } else {
            placeholderLabel = UILabel(frame: newRect)
            placeholderLabel?.font = self.font
            placeholderLabel?.backgroundColor = UIColor.clear
            placeholderLabel?.lineBreakMode = .byClipping
            
            if let placeholderColor = self.attributedPlaceholder?.attribute(NSForegroundColorAttributeName, at: 0, effectiveRange: nil) as? UIColor {
                placeholderLabel?.textColor = placeholderColor
            } else {
                placeholderLabel?.textColor = UIColor ( red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0 )
            }
            
            self.addSubview(placeholderLabel!)
        }
    }
    
    // Re-set frames and theme colors
    fileprivate func redrawSearchTableView() {
        if inlineMode {
            tableView?.isHidden = true
            return
        }
        
        if let tableView = tableView {
            let positionGap: CGFloat = 0
            guard let frame = self.superview?.convert(self.frame, to: nil) else { return }
            
            if self.direction == .down {
                var tableHeight: CGFloat = 0
                if keyboardIsShowing, let keyboardHeight = keyboardFrame?.size.height {
                    tableHeight = min((tableView.contentSize.height + positionGap), (UIScreen.main.bounds.size.height - frame.origin.y - frame.height - keyboardHeight))
                } else {
                    tableHeight = min((tableView.contentSize.height + positionGap), (UIScreen.main.bounds.size.height - frame.origin.y - frame.height))
                }
                
                if maxResultsListHeight > 0 {
                    tableHeight = min(tableHeight, CGFloat(self.maxResultsListHeight))
                }
                
                var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
                tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
                tableViewFrame.origin.x += 2
                tableViewFrame.origin.y += frame.size.height + 2
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    self?.tableView?.frame = tableViewFrame
                })
                
                var shadowFrame = CGRect(x: 0, y: 0, width: frame.size.width - 6, height: 1)
                shadowFrame.origin = self.convert(shadowFrame.origin, to: nil)
                shadowFrame.origin.x += 3
                shadowFrame.origin.y = tableView.frame.origin.y
                shadowView!.frame = shadowFrame
            } else {
                let tableHeight = min((tableView.contentSize.height + positionGap), (UIScreen.main.bounds.size.height - frame.origin.y - theme.cellHeight * 2))
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    self?.tableView?.frame = CGRect(x: frame.origin.x + 2, y: (frame.origin.y - tableHeight + positionGap), width: frame.size.width - 4, height: tableHeight)
                    self?.shadowView?.frame = CGRect(x: frame.origin.x + 3, y: (frame.origin.y + 3), width: frame.size.width - 6, height: 1)
                })
            }
            
            superview?.bringSubview(toFront: tableView)
            superview?.bringSubview(toFront: shadowView!)
            
            if self.isFirstResponder {
                superview?.bringSubview(toFront: self)
            }
            
            tableView.layer.borderColor = theme.borderColor.cgColor
            tableView.layer.cornerRadius = 2
            tableView.separatorColor = theme.separatorColor
            tableView.backgroundColor = theme.bgColor
            
            tableView.reloadData()
        }
    }
    
    // Handle keyboard events
    open func keyboardWillShow(_ notification: Notification) {
        if !keyboardIsShowing && isEditing, let keyboardRect = ((notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardIsShowing = true
            keyboardFrame = keyboardRect
            interactedWith = true
            prepareDrawTableResult()
        }
    }
    
    open func keyboardWillHide(_ notification: Notification) {
        if keyboardIsShowing {
            keyboardIsShowing = false
            direction = .down
            redrawSearchTableView()
        }
    }
    
    open func keyboardDidChangeFrame(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            if let keyboardRect = ((notification as NSNotification).userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self?.keyboardFrame = keyboardRect
                self?.prepareDrawTableResult()
            }
        }
    }
    
    open func typingDidStop() {
        if userStoppedTypingHandler != nil {
            self.userStoppedTypingHandler!()
        }
    }
    
    // Handle text field changes
    open func textFieldDidChange() {
        if !inlineMode && tableView == nil {
            buildSearchTableView()
        }
        // Detect pauses while typing
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(SearchTextField.typingDidStop), userInfo: self, repeats: false)
        
        if text!.isEmpty {
            clearResults()
            tableView?.reloadData()
            self.placeholderLabel?.text = ""
        } else {
            filter(false)
            prepareDrawTableResult()
        }
        
        buildPlaceholderLabel()
    }
    
    open func textFieldDidBeginEditing() {
        if startVisible && text!.isEmpty {
            clearResults()
            filter(true)
        }
        placeholderLabel?.attributedText = nil
    }
    
    open func textFieldDidEndEditing() {
        clearResults()
        tableView?.reloadData()
        placeholderLabel?.attributedText = nil
    }
    
    open func textFieldDidEndEditingOnExit() {
        if let firstElement = filteredResults.first {
            if let itemSelectionHandler = self.itemSelectionHandler {
                itemSelectionHandler(firstElement, 0)
            }
            else {
                if inlineMode, let filterAfter = startFilteringAfter {
                    let stringElements = self.text?.components(separatedBy: filterAfter)
                    
                    self.text = stringElements!.first! + filterAfter + firstElement.title
                } else {
                    self.text = firstElement.title
                }
            }
        }
    }
    
    fileprivate func filter(_ addAll: Bool) {
        clearResults()
        
        for i in 0 ..< filterDataSource.count {
            
            var item = filterDataSource[i]
            
            var tempText = text!
            if keyboardType == .emailAddress {
                if tempText.contains("@") {
                    let emailsplit = tempText.components(separatedBy: "@")
                    if (emailsplit.count > 1) {
                        tempText = "@\(emailsplit[1])"
                    } else {
                        tempText = "@"
                    }
                } else {
                    return
                }
            }
            
            
            if !inlineMode {
                
                // Find text in title and subtitle
                let titleFilterRange = (item.title as NSString).range(of: tempText, options: comparisonOptions)
                let subtitleFilterRange = item.subtitle != nil ? (item.subtitle! as NSString).range(of: tempText, options: comparisonOptions) : NSMakeRange(NSNotFound, 0)
                
                if titleFilterRange.location != NSNotFound || subtitleFilterRange.location != NSNotFound || addAll {
                    item.attributedTitle = NSMutableAttributedString(string: item.title)
                    item.attributedSubtitle = NSMutableAttributedString(string: (item.subtitle != nil ? item.subtitle! : ""))
                    
                    item.attributedTitle!.setAttributes(highlightAttributes, range: titleFilterRange)
                    
                    if subtitleFilterRange.location != NSNotFound {
                        item.attributedSubtitle!.setAttributes(highlightAttributesForSubtitle(), range: subtitleFilterRange)
                    }
                    
                    filteredResults.append(item)
                }
            } else {
                var textToFilter = tempText.lowercased()
                
                if inlineMode, let filterAfter = startFilteringAfter {
                    if let suffixToFilter = textToFilter.components(separatedBy: filterAfter).last, suffixToFilter != "", textToFilter != suffixToFilter {
                        textToFilter = suffixToFilter
                    } else {
                        placeholderLabel?.text = ""
                        return
                    }
                }
                
                if item.title.lowercased().hasPrefix(textToFilter) {
                    let itemSuffix = item.title.substring(from: textToFilter.index(textToFilter.startIndex, offsetBy: textToFilter.characters.count))
                    item.attributedTitle = NSMutableAttributedString(string: itemSuffix)
                    filteredResults.append(item)
                }
            }
        }
        
        tableView?.reloadData()
        
        if inlineMode {
            handleInlineFiltering()
        }
    }
    
    // Clean filtered results
    fileprivate func clearResults() {
        filteredResults.removeAll()
        tableView?.removeFromSuperview()
    }
    
    // Look for Font attribute, and if it exists, adapt to the subtitle font size
    fileprivate func highlightAttributesForSubtitle() -> [String: AnyObject] {
        var highlightAttributesForSubtitle = [String: AnyObject]()
        
        for attr in highlightAttributes {
            if attr.0 == NSFontAttributeName, let font = attr.1 as? UIFont {
                let fontName = font.fontName
                let pointSize = font.pointSize * fontConversionRate
                highlightAttributesForSubtitle[attr.0] = UIFont(name: fontName, size: pointSize)
            } else {
                highlightAttributesForSubtitle[attr.0] = attr.1
            }
        }
        
        return highlightAttributesForSubtitle
    }
    
    // Handle inline behaviour
    func handleInlineFiltering() {
        if let text = self.text {
            if text == "" {
                self.placeholderLabel?.attributedText = nil
            } else {
                if let firstResult = filteredResults.first {
                    self.placeholderLabel?.attributedText = firstResult.attributedTitle
                } else {
                    self.placeholderLabel?.attributedText = nil
                }
            }
        }
    }
    
    // MARK: - Prepare for draw table result
    fileprivate func prepareDrawTableResult() {
        guard let frame = self.superview?.convert(self.frame, to: UIApplication.shared.keyWindow) else { return }
        if let keyboardFrame = keyboardFrame {
            var newFrame = frame
            newFrame.size.height += theme.cellHeight
            
            if keyboardFrame.intersects(newFrame) {
                direction = .up
            } else {
                direction = .down
            }
            
            redrawSearchTableView()
        }
    }
    
    open func showResults() {
        prepareDrawTableResult()
    }
}

extension SearchTextField: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.isHidden = !interactedWith || (filteredResults.count == 0)
        shadowView?.isHidden = !interactedWith || (filteredResults.count == 0)
        
        if maxNumberOfResults > 0 {
            return min(filteredResults.count, maxNumberOfResults)
        } else {
            return filteredResults.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: SearchTextField.cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: SearchTextField.cellIdentifier)
        }
        
        cell!.backgroundColor = UIColor.clear
        cell!.layoutMargins = UIEdgeInsets.zero
        cell!.preservesSuperviewLayoutMargins = false
        cell!.textLabel?.font = theme.font
        cell!.detailTextLabel?.font = UIFont(name: theme.font.fontName, size: theme.font.pointSize * fontConversionRate)
        cell!.textLabel?.textColor = theme.fontColor
        cell!.detailTextLabel?.textColor = theme.fontColor
        
        cell!.textLabel?.text = filteredResults[(indexPath as NSIndexPath).row].title
        cell!.detailTextLabel?.text = filteredResults[(indexPath as NSIndexPath).row].subtitle
        cell!.textLabel?.attributedText = filteredResults[(indexPath as NSIndexPath).row].attributedTitle
        cell!.detailTextLabel?.attributedText = filteredResults[(indexPath as NSIndexPath).row].attributedSubtitle
        
        cell!.imageView?.image = filteredResults[(indexPath as NSIndexPath).row].image
        
        cell!.selectionStyle = .none
        
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return theme.cellHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if itemSelectionHandler == nil {
            self.text = filteredResults[(indexPath as NSIndexPath).row].title
        } else {
            let index = indexPath.row
            itemSelectionHandler!(filteredResults[index], index)
        }
        
        clearResults()
    }
}

////////////////////////////////////////////////////////////////////////
// Search Text Field Theme
public struct SearchTextFieldTheme {
    public var cellHeight: CGFloat
    public var bgColor: UIColor
    public var borderColor: UIColor
    public var separatorColor: UIColor
    public var font: UIFont
    public var fontColor: UIColor
    public var placeholderColor: UIColor?
    
    init(cellHeight: CGFloat, bgColor:UIColor, borderColor: UIColor, separatorColor: UIColor, font: UIFont, fontColor: UIColor) {
        self.cellHeight = cellHeight
        self.borderColor = borderColor
        self.separatorColor = separatorColor
        self.bgColor = bgColor
        self.font = font
        self.fontColor = fontColor
    }
    
    public static func lightTheme() -> SearchTextFieldTheme {
        return SearchTextFieldTheme(cellHeight: 30, bgColor: UIColor (red: 1, green: 1, blue: 1, alpha: 0.6), borderColor: UIColor (red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0), separatorColor: UIColor.clear, font: UIFont.systemFont(ofSize: 10), fontColor: UIColor.black)
    }
    
    public static func darkTheme() -> SearchTextFieldTheme {
        return SearchTextFieldTheme(cellHeight: 30, bgColor: UIColor (red: 0.8, green: 0.8, blue: 0.8, alpha: 0.6), borderColor: UIColor (red: 0.7, green: 0.7, blue: 0.7, alpha: 1.0), separatorColor: UIColor.clear, font: UIFont.systemFont(ofSize: 10), fontColor: UIColor.white)
    }
}

////////////////////////////////////////////////////////////////////////
// Filter Item
public struct SearchTextFieldItem {
    // Private vars
    fileprivate var attributedTitle: NSMutableAttributedString?
    fileprivate var attributedSubtitle: NSMutableAttributedString?
    
    // Public interface
    public var title: String
    public var subtitle: String?
    public var image: UIImage?
    
    public init(title: String, subtitle: String?, image: UIImage?) {
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
    
    public init(title: String, subtitle: String?) {
        self.title = title
        self.subtitle = subtitle
    }
    
    public init(title: String) {
        self.title = title
    }
}

public typealias SearchTextFieldItemHandler = (_ item: SearchTextFieldItem, _ index: Int) -> Void

////////////////////////////////////////////////////////////////////////
// Suggestions List Direction
enum Direction {
    case down
    case up
}
