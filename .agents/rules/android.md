---
name: "android.md"
description: "Rules for Android native development"
---

# Android Native Rules

1. **Kotlin First**: Write new native code in Kotlin instead of Java.
2. **Architecture**: Follow standard Android MVVM architecture if writing complex native screens, but for Flutter plugins, keep native logic minimal and localized to the MethodChannel.
3. **Gradle**: Do not blindly update Gradle dependencies; ensure compatibility with the Flutter engine and cross-platform targets.
4. **Fixing Errors**: When applying native fixes (e.g., using `fix_kt_errors.py` scripts), ensure that modifications don't break compatibility with older Android versions specified in `minSdkVersion`.
