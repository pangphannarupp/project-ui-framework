---
name: "ios.md"
description: "Rules for iOS native development"
---

# iOS Native Rules

1. **Swift First**: Write new native iOS code in Swift rather than Objective-C.
2. **Method Channels**: For Flutter integrations, ensure the Flutter method channels in `AppDelegate` or plugin classes handle errors gracefully.
3. **Dependencies**: Use CocoaPods correctly. Avoid checking in `Pods/` directory if not required by standard practices.
4. **Info.plist**: Be careful when modifying `Info.plist`. Only request permissions that the app actually utilizes.
