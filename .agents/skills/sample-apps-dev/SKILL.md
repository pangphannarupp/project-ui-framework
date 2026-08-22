---
name: "sample-apps-dev"
description: "Workflow for Sample Apps and Demos"
---

# Sample Apps Development Workflow

This skill outlines how to manage and run the sample projects inside the workspace, including both Flutter and Web/Vue apps.

## Workflow Steps

1. **Vue/Web Sample Apps**:
   - Located in `sample_apps/` (e.g., `mini-pos`, `mini-zoo-ticket`, `mini-cinema`, `mini-bus-ticket`, `mini-food-court`, `mini-smart-parking`, `mini-appointment-booking`, `mini-ev-charge`, `mini-lucky-wheel`, `smart-mini-app`).
   - Use Node.js workflows (`npm install` and `npm run dev`).
   - **MANDATORY**: All sample projects MUST use components from `@phanna/ui-framework` (e.g. `PPButton`, `PPInput`, `PPTextField`, `PPSelect`, `PPDatePicker`, `PPTimePicker`, `PPBottomSheet`, `PPAlert`, `PPConfirm`, `PPQRCode`, `PPSpinWheel`, `PPProgressGauge`, `PPStepper`, `PPChip`, `PPSegment`, `PPSwitch`, `PPSlider`, `PPToast`, etc.) instead of raw unstyled HTML elements.
   - **MANDATORY UI DIVERSITY**: Every sample app template MUST have a **distinct visual design, unique navigation pattern, and domain-specific interactive canvas** (e.g. architectural floor plans, 3D sculptors, cyber HUD dashboards, metallic hardware kiosks, editorial magazine layouts, conveyor track simulators) rather than repeating generic card list views.

2. **Flutter Sample App**:
   - Located in `flutter_sample/`.
   - **MANDATORY**: All sample screens MUST use widgets from `flutter_ui_framework` (`PpButton`, `PpTextField`, `PpCard`, `PpBottomSheet`, `PpColorPicker`, `PpPinDots`, `PpKeypad`, `PpProgressGauge`, `PpSegment`, `PpBottomNav`, `PpAppBar`, etc.).
   - Ensure you run `flutter pub get` inside this directory before building.
   - Run the app using `flutter run` to test new components added to the `flutter_ui_framework`.

3. **Component Data Sync & Unique Templates**:
   - When adding a new demo, ensure it is properly registered in files like `component_data.dart` or the router catalog.
   - Ensure the new demo introduces fresh interactive patterns to expand the showcase variety.
