<a href="https://r9ryvd37cq5.typeform.com/to/E99SDQZx"><img src="https://related.chat/github/header34.png" width="880"></a>

---

<img src="https://related.chat/hud/001.gif" width="80"> <img src="https://related.chat/hud/002.gif" width="80"> <img src="https://related.chat/hud/003.gif" width="80"> <img src="https://related.chat/hud/004.gif" width="80"> <img src="https://related.chat/hud/005.gif" width="80"> <img src="https://related.chat/hud/006.gif" width="80"> <img src="https://related.chat/hud/007.gif" width="80"> <img src="https://related.chat/hud/008.gif" width="80"> <img src="https://related.chat/hud/009.gif" width="80"> <img src="https://related.chat/hud/010.gif" width="80"> <img src="https://related.chat/hud/011.gif" width="80"> <img src="https://related.chat/hud/011.png" width="80"> <img src="https://related.chat/hud/012.gif" width="80"> <img src="https://related.chat/hud/012.png" width="80"> <img src="https://related.chat/hud/013.gif" width="80"> <img src="https://related.chat/hud/013.png" width="80"> <img src="https://related.chat/hud/014.gif" width="80"> <img src="https://related.chat/hud/014.png" width="80"> <img src="https://related.chat/hud/015.gif" width="80"> <img src="https://related.chat/hud/015.png" width="80">

## WHAT'S NEW

### Version: 13.7.2

- Any SF Symbols can be displayed directly by defining its name `ProgressHUD.show(symbol: "car.fill")`
- The `showFailed` and `showError` methods can now handle `Error?` parameters as well. In this case the `localizedDescription` will be displayed.
- The `setupDelayTimer` method is fixed. Now `[weak self]` is used within the timer's closure to prevent potential retain cycles and avoid memory leaks.

### Version: 13.7.1

- The `mediaSize` and `marginSize` options are now available to adjust the HUD dimensions.

### Version: 13.7.0

- New `AnimationType.none` has been implemented. So you can display some text without animation.

### Version: 13.6.2

- We have the optional `delay:` parameter to set the timeout.
- We have the `.remove()` function to dismiss the HUD immediately.

### Version: 13.5 and 13.6

- Bugfix related to iPad split screen.
- Bugfix related to showProgress.

## OVERVIEW

**ProgressHUD** is a convenient and intuitive HUD tool designed specifically for iOS. It enables seamless presentation of concise alerts or notifications to users of your app in a simple and non-disruptive way.

## INSTALLATION

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects.

To incorporate the **ProgressHUD** library into your Xcode project utilizing CocoaPods, please reference it within your `Podfile` as shown below:

```ruby
pod 'ProgressHUD'
```

### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager) is a tool for managing the distribution of Swift code.

Once you've configured your `Package.swift` manifest file, you may proceed to include **ProgressHUD** in the dependencies section of the same file.

```swift
dependencies: [ .package(url: "https://github.com/relatedcode/ProgressHUD.git", from: "13.7.2") ]
```

### Manually

If you prefer not to use any of the dependency managers, you can integrate **ProgressHUD** into your project manually. Just copy the `ProgressHUD.swift` file in your Xcode project.

## QUICK START

```swift
ProgressHUD.show("Some text...")
```

```swift
ProgressHUD.show("Some text...", interaction: false)
```

```swift
ProgressHUD.showSucceed()
```

```swift
ProgressHUD.showSucceed("Some text...", delay: 1.5)
```

```swift
ProgressHUD.showFailed()
```

```swift
ProgressHUD.showFailed("Some text...")
```

```swift
ProgressHUD.showProgress(0.15)
```

```swift
ProgressHUD.showProgress("Loading...", 0.42)
```

```swift
ProgressHUD.show(icon: .heart)
```

```swift
ProgressHUD.show("Some text...", icon: .privacy, delay: 2.0)
```

```swift
ProgressHUD.show(symbol: "box.truck")
```

```swift
ProgressHUD.show("Some text...", symbol: "figure.2.arms.open")
```

```swift
ProgressHUD.dismiss()
```

```swift
ProgressHUD.remove()
```

## REQUIREMENTS

- iOS 13.0+

## CUSTOMIZATION

You can customize attributes like color, font, image, animation type, size, and more by using these methods:

```swift
ProgressHUD.animationType = .circleStrokeSpin
```

```swift
ProgressHUD.colorHUD = .systemGray
```

```swift
ProgressHUD.colorBackground = .lightGray
```

```swift
ProgressHUD.colorAnimation = .systemBlue
```

```swift
ProgressHUD.colorProgress = .systemBlue
```

```swift
ProgressHUD.colorStatus = .label
```

```swift
ProgressHUD.mediaSize = 100
ProgressHUD.marginSize = 50
```

```swift
ProgressHUD.fontStatus = .boldSystemFont(ofSize: 24)
```

```swift
ProgressHUD.imageSuccess = UIImage(named: "success.png")
```

```swift
ProgressHUD.imageError = UIImage(named: "error.png")
```

A comprehensive list of the predefined animation and icon types:

```swift
public enum AnimationType {
	case none
	case systemActivityIndicator
	case horizontalCirclesPulse
	case lineScaling
	case singleCirclePulse
	case multipleCirclePulse
	case singleCircleScaleRipple
	case multipleCircleScaleRipple
	case circleSpinFade
	case lineSpinFade
	case circleRotateChase
	case circleStrokeSpin
}
```

```swift
public enum AnimatedIcon {
	case succeed
	case failed
	case added
}
```

```swift
public enum AlertIcon {
	case heart
	case doc
	case bookmark
	case moon
	case star
	case exclamation
	case flag
	case message
	case question
	case bolt
	case shuffle
	case eject
	case card
	case rotate
	case like
	case dislike
	case privacy
	case cart
	case search
}
```

## LICENSE

MIT License

Copyright (c) 2023 Related Code

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
