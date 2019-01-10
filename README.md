# LayoutInspector

[![CI Status](https://img.shields.io/travis/Igor/LayoutInspector.svg?style=flat)](https://travis-ci.org/isavynskyi/LayoutInspector)
[![Version](https://img.shields.io/cocoapods/v/LayoutInspector.svg?style=flat)](https://cocoapods.org/pods/LayoutInspector)
[![License](https://img.shields.io/cocoapods/l/LayoutInspector.svg?style=flat)](https://cocoapods.org/pods/LayoutInspector)
[![Platform](https://img.shields.io/cocoapods/p/LayoutInspector.svg?style=flat)](https://cocoapods.org/pods/LayoutInspector)

<a href="https://github.com/isavynskyi/LayoutInspector/blob/master/LayoutInspector_demo.gif"><img src="https://github.com/isavynskyi/LayoutInspector/blob/master/LayoutInspector_demo.gif" title="LayoutInspector demo"/></a>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Layout inspection could be triggered only if app is running under DEBUG build configuration, so it won't affect any other kind of the app builds (i.e. RELEASE)

## Installation

LayoutInspector is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LayoutInspector'
```

Specify how you want to trigger layout inspection: calling it by your own (set **.custom** trigger type) or automatically when taking device screenshot (set **.screenshot** trigger type)

**Swift**
```
import LayoutInspector

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LayoutInspector.shared.setTriggerType(.screenshot)
        return true
    }
}

```

**Objective-C**
```
@import LayoutInspector;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[LayoutInspector shared] setTriggerType:TriggerTypeScreenshot];
    return YES;
}

@end
```

## Author

Ihor Savynskyi\
✉️ wadedunk08@gmail.com\
🌎 [Twitter](https://twitter.com/iWadedunk), [LinkedIn](https://www.linkedin.com/in/isavynskyi/)


## License

LayoutInspector is available under the MIT license. See the LICENSE file for more info.
