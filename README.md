# LayoutInspector

[![CI Status](https://img.shields.io/travis/Igor/LayoutInspector.svg?style=flat)](https://travis-ci.org/Igor/LayoutInspector)
[![Version](https://img.shields.io/cocoapods/v/LayoutInspector.svg?style=flat)](https://cocoapods.org/pods/LayoutInspector)
[![License](https://img.shields.io/cocoapods/l/LayoutInspector.svg?style=flat)](https://cocoapods.org/pods/LayoutInspector)
[![Platform](https://img.shields.io/cocoapods/p/LayoutInspector.svg?style=flat)](https://cocoapods.org/pods/LayoutInspector)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

LayoutInspector is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LayoutInspector'
```

Specify how you want to trigger layout inspection: calling it by your own (set .custom trigger type) or automatically when taking device screenshot (set .screenshot trigger type)
```
*import LayoutInspector*

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LayoutInspector.shared.setTriggerType(.screenshot)
        return true
    }
}

```

## Author

Ihor, wadedunk08@gmail.com

## License

LayoutInspector is available under the MIT license. See the LICENSE file for more info.
