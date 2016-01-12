//  Copyright 2016 Skyscanner Ltd
//
//  Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

import Foundation

/**
The `SkyFloatingLabelTextFieldDelegate` protocol defines the messages sent to a text field delegate as part of the sequence of editing its text. All of the methods of this protocol are optional.
*/
@objc public protocol SkyFloatingLabelTextFieldDelegate: class {
    
    /**
     Tells the delegate that editing began for the specified text field.
     
     - parameter textField: The text field for which an editing session began.
     */
    optional func textFieldDidBeginEditing(textField:SkyFloatingLabelTextField)
    
    /**
     Tells the delegate that editing stopped for the specified text field.
     
     - parameter textField: The text field for which the editing session ended.
     */
    optional func textFieldDidEndEditing(textField:SkyFloatingLabelTextField)
    
    /**
     Asks the delegate if the text field should process the pressing of the return button.
     
     - parameter textField: The text field whose return button was pressed.
     */
    optional func textFieldShouldReturn(textField:SkyFloatingLabelTextField) -> Bool
    
    /**
     Asks the delegate if the text field should process the pressing of the clear button.
     
     - parameter textField: The text field whose clear button was pressed.
     */
    optional func textFieldShouldClear(textField:SkyFloatingLabelTextField) -> Bool
    
    /**
     Asks the delegate if editing should begin in the specified text field.
     
     - parameter textField: The text field for which editing is about to begin.
     
     - returns: `true` if an editing session should be initiated; otherwise, `false` to disallow editing.
     */
    optional func textFieldShouldBeginEditing(textField:SkyFloatingLabelTextField) -> Bool
    
    /**
     Asks the delegate if editing should stop in the specified text field.
     
     - parameter textField: The text field for which editing is about to end.
     
     - returns: `true` if editing should stop; otherwise, `false` if the editing session should continue
     */
    optional func textFieldShouldEndEditing(textField:SkyFloatingLabelTextField) -> Bool
    
    
    /**
     Asks the delegate if editing should stop in the specified text field.
     
     - parameter textField: The text field containing the text.
     - parameter range: The range of characters to be replaced.
     - parameter string: The replacement string.
     
     - returns: `true` if the specified text range should be replaced; otherwise, `false` to keep the old text.
     */
    optional func textField(textField: SkyFloatingLabelTextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
}

