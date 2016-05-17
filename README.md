# SkyFloatingLabelTextField

[![Build Status](https://travis-ci.org/Skyscanner/SkyFloatingLabelTextField.svg?branch=master)](https://travis-ci.org/Skyscanner/SkyFloatingLabelTextField)
[![Coverage Status](https://coveralls.io/repos/github/Skyscanner/SkyFloatingLabelTextField/badge.svg?branch=master)](https://coveralls.io/github/Skyscanner/SkyFloatingLabelTextField?branch=master)
[![Pod Platform](https://img.shields.io/cocoapods/p/SkyFloatingLabelTextField.svg?style=flat)](https://cocoapods.org/pods/SkyFloatingLabelTextField)
[![Pod License](https://img.shields.io/cocoapods/l/SkyFloatingLabelTextField.svg?style=flat)](https://github.com/SkyFloatingLabelTextField/blob/master/LICENSE.md)

[![Pod Version](https://img.shields.io/cocoapods/v/SkyFloatingLabelTextField.svg?style=flat)](https://cocoapods.org/pods/SkyFloatingLabelTextField)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Documentation](https://img.shields.io/cocoapods/metrics/doc-percent/SkyFloatingLabelTextField.svg)](http://cocoadocs.org/docsets/SkyFloatingLabelTextField/)
[![Readme Score](http://readme-score-api.herokuapp.com/score.svg?url=https://github.com/Skyscanner/SkyFloatingLabelTextField)](http://clayallsopp.github.io/readme-score?url=https://github.com/Skyscanner/SkyFloatingLabelTextField)

`SkyFloatingLabelTextField` is a beautiful, flexible and customizable implementation of the space saving **"Float Label Pattern"**. This design enables adding context to input fields that are visible at the time of typing, while minimizing the additional space used to display this additional context. This component is used in the [Skyscanner TravelPro iOS application](https://itunes.apple.com/gb/app/travelpro-business-travel/id1046916687) in several places, like when [searching for flights](http://codevoyagers.com/2016/04/06/open-sourcing-skyfloatinglabeltextfield/).

On top of implementing the space-saving floating title, the component also supports using iconography, RTL text support (e.g. Arabic & Hebrew), various states (error, selected, highlighted states), and is very much customizable and extensible.

![](/SkyFloatingLabelTextField/images/showcase-example.gif)

## Usage

To start using the component add it to your project using CocoaPods, Carthage or manually as per the [Installation](#installation) section.

The UI component can be used via the `SkyFloatingLabelTextField` class. To use icons on the right hand side, use the `SkyFloatingLabelTextFieldWithIcon` class. This control can be used very similar to `UITextField` - both from Interface Builder, or from code.

To create an instance of the class, use Interface builder, or do it from code. This example will create the following textbox with the placeholder and title:

![](/SkyFloatingLabelTextField/images/example-1.gif)

```swift
let textField = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 200, 45))
textField.placeholder = "Name"
textField.title = "Your full name"
self.view.addSubview(textField)
```

### Colors

To customize the colors of the textfield, set a few properties - either from code, or from Interface builder. To use a textfield with an icon, utilize the `SkyFloatingLabelTextFieldWithIcon` class (and bundle the font class with your app). This example will change colors for the textfield on the right:

![](/SkyFloatingLabelTextField/images/example-2.gif)

```swift
let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)

let textField1 = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 120, 45))
textField1.placeholder = "First name"
textField1.title = "Given name"
self.view.addSubview(textField1)

let textField2 = SkyFloatingLabelTextField(frame: CGRectMake(150, 10, 120, 45))
textField2.placeholder = "Last name"
textField2.title = "Family name"

textField2.tintColor = overcastBlueColor // the color of the blinking cursor
textField2.textColor = darkGreyColor
textField2.lineColor = lightGreyColor
textField2.selectedTitleColor = overcastBlueColor
textField2.selectedLineColor = overcastBlueColor

textField2.lineHeight = 1.0 // bottom line height in points
textField2.selectedLineHeight = 2.0
```

### Icons and fonts

Use the `SkyFloatingLabelTextFieldWithIcon` field to display icons next to the textfields. You will have to set the `iconFont` property and bundle your icon with your app (if it's not a built in one). Icons can be rotated and more precise positioning is also supported:

![](/SkyFloatingLabelTextField/images/example-3.gif)

```swift
let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)

let textField1 = SkyFloatingLabelTextFieldWithIcon(frame: CGRectMake(10, 10, 120, 45))
textField1.placeholder = "Departure"
textField1.title = "Flying from"
textField1.iconFont = UIFont(name: "FontAwesome", size: 15)
textField1.iconText = "\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
self.view.addSubview(textField1)

let textField2 = SkyFloatingLabelTextFieldWithIcon(frame: CGRectMake(150, 10, 120, 45))
textField2.placeholder = "Arrival"
textField2.title = "Flying to"
textField2.tintColor = overcastBlueColor
textField2.selectedTitleColor = overcastBlueColor
textField2.selectedLineColor = overcastBlueColor

// Set icon properties
textField2.iconColor = UIColor.lightGrayColor()
textField2.selectedIconColor = overcastBlueColor
textField2.iconFont = UIFont(name: "FontAwesome", size: 15)
textField2.iconText = "\u{f072}" // plane icon as per https://fortawesome.github.io/Font-Awesome/cheatsheet/
textField2.iconMarginBottom = 4.0 // more precise icon positioning. Usually needed to tweak on a per font basis.
textField2.iconRotationDegrees = 90 // rotate it 90 degrees
textField2.iconMarginLeft = 2.0
self.view.addSubview(textField2)
```

### Error state and delegates

The textfield supports displaying an error state - this can be useful for example when validating fields on the fly. When the `errorMessage` property is set on the control, then the control is highlighted with the color set in the `errorColor` property.

To get notified of different events happening on the textfield - such as the text changing, editing starting or ending - just set the `delegate` property to a class implementing the standard [UITextFieldDelegate](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITextFieldDelegate_Protocol/) protocol:

![](/SkyFloatingLabelTextField/images/example-4.gif)

```swift
class MyViewController: UIViewController, UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        let textField1 = SkyFloatingLabelTextField(frame: CGRectMake(10, 10, 120, 45))
        textField1.placeholder = "Email"
        textField1.title = "Email address"
        textField1.errorColor = UIColor.redColor()
        textField1.delegate = self
        self.view.addSubview(textField1)
    }

    /// Implementing a method on the UITextFieldDelegate protocol. This will notify us when something has changed on the textfield
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text {
            if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
                if(text.characters.count < 3 || !text.containsString("@")) {
                    floatingLabelTextField.errorMessage = "Invalid email"
                }
                else {
                    // The error message will only disappear when we reset it to nil or empty string
                    floatingLabelTextField.errorMessage = ""
                }
            }
        }
        return true
    }
}
```

### RTL language support

The component automatically detects the language writing direction. When the phone has a RTL language set (e.g. Arabic or Hebrew), then it automatically adjusts to support this style.

Alternatively, set the `isLTRLanguage` property to manually change the writing direction.

![](/SkyFloatingLabelTextField/images/RTL-example.png)

### Further customizing the control by subclassing

The control was designed to allow further customization in subclasses. The control itself inherits from `UITextField`, so the standard overrides from there can all be used. A few other notable customization hooks via overriding are:
- `updateColors`: override this method to customize colors whenever the state of the control changes
- Layout overrides:
  - `titleLabelRectForBounds(bounds:CGRect, editing:Bool)`:  override to change the bounds of the top title placeholder view
  - `textRectForBounds(bounds: CGRect)`: override to change the bounds of the control (inherited from `UITextField`)
  - `editingRectForBounds(bounds: CGRect)`: override to change the bounds of the control when editing / selected (inherited from `UITextField`)
  - `placeholderRectForBounds(bounds: CGRect)`:  override to change the bounds of the placeholder view
  - `lineViewRectForBounds(bounds:CGRect, editing:Bool)`: override to change the bounds of the bottom line view

## Documentation

See the [SkyFloatingLabelTextField documentation](http://cocoadocs.org/docsets/SkyFloatingLabelTextField) on [CocoaDocs.org](http://cocoadocs.org) for the full documentation.

## Installation

#### CocoaPods

The control is available through [CocoaPods](https://cocoapods.org/). CocoaPods can be installed using [Ruby gems](https://rubygems.org/):
```shell
$ gem install cocoapods
```

Then simply add `SkyFloatingLabelTextField` to your Podfile:

```
pod 'SkyFloatingLabelTextField', '~> 1.0'
```

Lastly, let CocoaPods fetch the latest version of the component by running:
```shell
$ cocoapods update
```

#####Integrating into Objective C projects

When integrating the component into an Objective C project, in the Podfile add `use_frameworks!`. For example as shown in [SkyFloatingLabelTextFieldObjectiveCExample](https://github.com/Skyscanner/SkyFloatingLabelTextField/tree/master/SkyFloatingLabelTextFieldObjectiveCExample):

```
use_frameworks!

target 'SkyFloatingLabelTextFieldObjectiveCExample' do
  pod 'SkyFloatingLabelTextField', '~> 1.0'
end
```

Then to use the component in your code, add the following line to your `.h` or `.m` files:

```objc
@import SkyFloatingLabelTextField;
```

#### Carthage
The component supports [Carthage](https://github.com/Carthage/Carthage). Start by making sure you have the latest version of Carthage installed. Using [Homebrew](http://brew.sh/) run this:
```shell
$ brew update
$ brew install carthage
```
Then add `SkyFloatingLabelTextField` to your `Cartfile`:
```
github "Skyscanner/SkyFloatingLabelTextField"
```
Finally, add the framework to the Xcode project of your App. Link the framework to your App and copy it to the App’s Frameworks directory via the “Build Phases” section.

#### Manual

You can download the latest files from our [Releases page](https://github.com/Skyscanner/SkyFloatingLabelTextField/releases). After doing so, copy the files in the `Sources` folder to your project.

## Contributing

We welcome all contributions. Please read [this guide](/CONTRIBUTING.md) before opening issues or submitting pull requests, as well as how and who to contact with questions.

## Credits

The original component was built by [Daniel Langh](https://github.com/intonarumori), [Gergely Orosz](https://github.com/gergelyorosz) and [Raimon Laupente](https://github.com/wolffan). Notable contributions by [Shai Shamir](https://github.com/pichirichi) (RTL language support).

Credits for the original design, and improving it with iconography to Matt D. Smith ([@mds](https://twitter.com/mds)).

## FAQ

- *Can I use it in Objective C projects?*

  Of course! Please see the [Integrating-into-Objective-C-projects](#Integrating into Objective C projects) section on how to integrate the component via CocoaPods.

- *Does the control work well with auto layout? What about using it programmatically?*

  The control was built to support both use cases. It plays nicely with autolayout. As the control is a subclass of `UITextField`, overriding `textRectForBounds(bounds:)` or `editingRectForBounds(bounds:)` is always an option. Alternatively, overriding `intrinsiccontentsize` is also another possibility.

- *How can I remove the line from the bottom of the textfield?*

  Set `lineHeight` and `selectedLineHeight` to `0`, and the line won't be displayed.

- *I'd like to validate the textfield using the `errorMessage`. How can I re-validate text is typed in the textfield?*

  Using a delegate implement the `textField(textField:,range:string:)` method. This method fires whenever the text is changed - do the validation here. Alternatively, using subclassing you can also override the `becomeFirstResponder` method to e.g. clear the text or error message when the textfield is selected.
