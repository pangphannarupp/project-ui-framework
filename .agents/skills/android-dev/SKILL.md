---
name: "android-dev"
description: "Workflow for Android native development"
---

# Android Native Development Workflow

This skill outlines how to interact with the Android folder in the workspace.

## Workflow Steps

1. **Modifying Native Code**:
   - Navigate to the `android/` directory for root-level native code or the respective Android directories inside `flutter_sample/` and `flutter_ui_framework/`.
   - Update `MainActivity.kt` or plugins.

2. **Fixing Kotlin Errors**:
   - You can utilize the provided Python scripts in the root (like `fix_kt_errors.py`, `fix_kt_errors_final.py`) to bulk-resolve Kotlin linting and compilation issues.

3. **Building**:
   - Run native builds through Flutter (`flutter build apk` or `flutter build appbundle`) rather than raw Gradle commands, unless isolating a native-specific build error.
