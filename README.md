# IMPulseButton
A fully customisable subclass of the native `UIButton` which allows you to create beautiful buttons without writing any line of code.

## Installation

### Requirements
- iOS 9.0+
- Swift 4.2+
- Xcode 12.0+

### CocoaPods
[CocoaPods](http://cocoapods.org/)  is a dependency manager for Cocoa projects. You can install it with the following command:

    $ gem install cocoapods

To integrate TransitionButton into your Xcode project using CocoaPods, specify it in your  `Podfile`:

    use_frameworks!
    
    pod 'IMPulseButton'

Then, run the following command:

    $ pod install

## Usage

Drag and drop an  `UIButton`  object into your view controller and set its class and module to  `IMPulseButton`.

Customise your button by setting the properties from the Interface Builder.

`IMPulseButton`  is a subclass of  `UIButton`. In addition to all what  `UIButton`  provides.  `IMPulseButton`  has one main methods :  

- `yourButton.commonInit(title: String, fullRounded: Bool, animationEnabled: Bool, action: () -> Void)` setup interface the button 
    
    -   `title`: the title of the button.
    -   `fullRounded`: revert the button to the original state after a delay to give opportunity to custom transition.
    - `animationEnabled` : If `true` the button animation will be played. If `false` the button animation will **not** played. 
    -   `completion`: a completion block to be called, it may be useful to transit to another view controller, example transit to the home screen from the login screen.

For the stop Animation call the func  `nukeAllAnimations()`  stop the button animation.

### Manually

To install manually the Floaty in an app, just drag the  `IMPulseButton.swift`  file into your project.

### Supported Attributes

| Attribute        | Description      | Default value  |
| ------------- |-------------| -----|
| buttonTitle     | The title of button     | My Button |
| buttonTitleColor     | The title color     | white |
| buttonTitleFont     | The title font     | .boldSystemFont(ofSize: 19.0) |
| buttonBackgroundColor     | Main background color     | blue |
| fullyRoundedCorners      | Apply a corner radius equals to height/2     | false |
| cornerRadius      | Apply a corner radius     | 0 |
| gradientEnabled | Apply the gradient background colors | false |
| gradientStartColor      | The first color of the gradient background     | clear |
| gradientEndColor      | The second color of the gradient background     | clear |
| gradientHorizontal| Whether the gradient should be horizontal or not     | false |
| Border Color      | The border color     | clear |
| Border Width      | The border width     | 0.0 |


### Upcoming functions 
 - [ ] Left and Right Image options
 - [ ] Spinning loader animation state
 
## Contributing
-   If you  **need help**  or you'd like to  **ask a general question**, open an issue.
-   If you  **found a bug**, open an issue.
-   If you  **have a feature request**, open an issue.
-   If you  **want to contribute**, submit a pull request.

## [](https://github.com/isamercan/IMPulseButton#acknowledgements)Acknowledgements


_**Follow me on:**_

#### [](https://github.com/isamercan/IMPulseButton#-linkedin)💼  [Linkedin](https://www.linkedin.com/in/isamercan/)
#### [](https://github.com/isamercan/IMPulseButton#-twitter)🤖  [Twitter](https://twitter.com/isamercan)
#### [](https://github.com/isamercan/IMPulseButton#-Medium)🌇  [Instagram](https://medium.com/@isamercan)

## [](https://github.com/isamercan/IMPulseButton#mit-license)MIT License

IMPulseButton is available under the MIT license. See the LICENSE file for more info.

Made with  ❤️  by  [Isa Mercan](https://github.com/isamercan).
