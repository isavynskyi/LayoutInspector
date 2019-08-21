# Introduction

[![CI Status](https://img.shields.io/travis/isavynskyi/LayoutInspector.svg?style=flat)](https://travis-ci.org/isavynskyi/LayoutInspector)
[![Version](https://img.shields.io/cocoapods/v/LayoutInspector.svg?style=flat)](https://cocoapods.org/pods/LayoutInspector)
[![License](https://img.shields.io/cocoapods/l/LayoutInspector.svg?style=flat)](https://cocoapods.org/pods/LayoutInspector)
[![Platform](https://img.shields.io/cocoapods/p/LayoutInspector.svg?style=flat)](https://cocoapods.org/pods/LayoutInspector)

<a href="https://github.com/isavynskyi/LayoutInspector/blob/master/LayoutInspector_demo.gif"><img src="https://github.com/isavynskyi/LayoutInspector/blob/master/LayoutInspector_demo.gif" title="LayoutInspector demo"/></a>

## Features

- [x] Inspect layouts directly on iOS devices
- [x] Inspection could be triggered only if app is running under `DEBUG` build configuration, so it won't affect any other kind of the app builds (i.e. `RELEASE`)
- [x] Objective-C compatible
- [x] Works on all devices with iOS 11.0+

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 11.0 and higher
- Xcode 10.3 and higher
- Swift 5.0 and higher

## Installation

`LayoutInspector` is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LayoutInspector'
```

## Usage

**Layout inspection could be trigger:**
- manually whenever you want (on some actions, events, notifications etc) 
```swift
LayoutInspector.shared.showLayout()
```

- automatically when taking app screenshot
```swift
LayoutInspector.shared.setAutoTrigger(.screenshot)
```


**Swift**
```swift
import LayoutInspector

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LayoutInspector.shared.setAutoTrigger(.screenshot)
        return true
    }
}

```

**Objective-C**
```obj-c
@import LayoutInspector;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [LayoutInspector.shared setAutoTrigger:AutoTriggerScreenshot];
    return YES;
}

@end
```

## Changelog

| Version  | Description |
| ------------- | ------------- |
| `1.1.0`  | Release: Swift version upgraded to 5.0|
| `1.0.0`  | Release: test coverage added|
| `0.2.0`  | Pre-release: Objective-C compatibility |
| `0.1.1`  | Pre-release: fixed Lint warnings |
| `0.1.0`  | Pre-release: initial version  |

## Author

Ihor Savynskyi\
✉️ wadedunk08@gmail.com\
🌎 [Twitter](https://twitter.com/iWadedunk), [LinkedIn](https://www.linkedin.com/in/isavynskyi/)


## License

LayoutInspector is available under the MIT license. See the LICENSE file for more info.
