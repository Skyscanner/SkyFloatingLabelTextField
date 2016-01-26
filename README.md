# SkyFloatingLabelTextField

`SkyFloatingLabelTextField` is a beautiful, flexible and customizable implementation of the **"Float Label Pattern"**. This design enables adding context to input fields that is visible at time of typing, while minimizing the additional space used to display this additional context. This component is used in the [Skyscanner TravelPro iOS application](https://itunes.apple.com/gb/app/travelpro-business-travel/id1046916687) in several places.

On top of implementing the space-saving floating title, the component also supports using iconography, various states (error, selected, highlighted states), and is very much customizable and extensible.

![](/SkyFloatingLabelTextField/images/showcase-example.gif)

## Usage

The UI component can be used via the `SkyFloatingLabelTextField` and `SkyFloatingLabelTextFieldWithIcon` classes - the latter has support for icons on the right side of the textbox.

The control can be used very similar to the `UITextField`, both from Interface Builder, or from code.

## States and properties

The control supports three different states, with matching properties:
- **State independent**
  - `text`: the value of the textfield, the same way as UITextField works
  - `textColor`: the color of the editable text
  - `tintColor`: the color of the cursor when editing, as per `UITextField`
- **Deselected / Normal** state
  - `deselectedTitle`: the text contents of the title above the textfield 
  - `titleColor`: the color of the floating label
  - `lineHeight`: the height of the bottom line, under the textfield
  - `lineColor`:  the color of the bottom line, under the textfield
- **Selected** state: when the textfield's `selected` property is set to `true`. This is typically when it becomes the first responder.
  - `selectedTitle`
  - `selectedTitleColor`
  - `selectedLineHeight`
  - `selectedLineColor`
- **Highlighted** state: when the `highlighted` property is set to true.
  - In this case the title color is shown using the `selectedTitleColor` and the line color is displayed using the `selectedLineColor` values
  - Highlighting can be an alternative way to show fields that have not been filled out, e.g. when a person submits a form. See [this example](/SkyFloatingLabelTextField/blob/master/SkyFloatingLabelTextField/SkyFloatingLabelTextFieldExample/Example0/ShowcaseExampleViewController.swift) on how it is used there.
- **Error**: when the textfield's `errorMessage` property is set to a non `nil` value
  - `errorMessage`: the text displayed as the title of the textfield
  - `errorColor`: the color used to display the title and bottom line with

###`SkyFloatingLabelTextFieldWithIcon` additional properties:
- **State independent**
  - `iconFont`: font to use to display icons
  - `iconText`: the icon's content
  - `iconMarginBottom`: margin in points on the bottom of the icon. Helps position icon to the right height more precisely
  - `iconRotationDegrees`: rotates the icon itself. In the above example the second airline logo is the same icon, just rotated by 90 degrees
- **Deselected / Normal** state
  - `iconColor`: color to display the icon with
- **Selected** state
  -  `selectedIconColor`: color used when the textfield is elected

###Further customizing the control by subclassing

The control was designed to allow further customization in subclasses. The control itself inherits from `UITextField`, so the standard overrides from there can all be used. A few other notable customization hooks via overriding are:
- `updateColors`: override this method to customzie colors whenever the state of the control changes
- Layout overrrides:
  - `titleLabelRectForBounds`: override to change the bounds of the title label
  - `lineViewRectForBounds`: override to change the bounds of the bottom line view
  - `placeholderLabelRectForBounds`: override to change the bounds of the placeholder view

## Installation

### Manual

Copy the files in the `SkyFloatingLabelTextField` to your project:
- `SkyFloatingLabelTextField.swift`
- `SkyFloatingLabelTextFieldDelegate.swift`
- `SkyFloatingLabelTextFieldWithIcon.swift`
- `UITextField+fixCaretPosition.swift`

### Cocoapods

Support coming soon.

### Carthage

##Contributing

We welcome all contributions. Please read [this guide](/CONTRIBUTING.md) before opening issues or submitting pull requests, as well as how and who to contact with questions.

## Credits

Credits for the original design, and improving it with iconography to Matt D. Smith ([@mds](https://twitter.com/mds)).

The original component was built by [Daniel Langh](https://github.com/intonarumori), [Gergely Orosz](https://github.com/gergelyorosz) and [Raimon Laupente](https://github.com/wolffan).
