---
name: "ios-dev"
description: "Workflow for iOS native development"
---

# iOS Native Development Workflow

This skill outlines how to interact with the iOS folder in the workspace.

## Workflow Steps

1. **Modifying Native Code**:
   - Navigate to the `ios/` directory.
   - Use Xcode for modifying project settings or Swift files when possible to ensure `.pbxproj` formatting remains correct.

2. **Handling CocoaPods**:
   - If iOS dependencies change, navigate to `ios/` and run `pod install`. Make sure you are using a compatible Ruby version if using a Mac with Apple Silicon.

3. **Building**:
   - Build using `flutter build ios` to ensure Flutter assets are correctly bundled.
