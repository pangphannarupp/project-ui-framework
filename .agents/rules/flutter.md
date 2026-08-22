---
name: "flutter.md"
description: "Rules for Flutter development within flutter_ui_framework and flutter_sample"
---

# Flutter & Dart Rules

1. **State Management**: Prefer stateless widgets where possible. For stateful logic in samples, ensure state is handled cleanly.
2. **Imports**: Prefer absolute imports for files within `lib/`. Avoid circular dependencies.
3. **UI Framework Usage (STRICT REQUIREMENT)**: All sample apps and demo pages in `flutter_sample/` MUST utilize components from `flutter_ui_framework` (e.g., `PpButton`, `PpTextField`, `PpCard`, `PpBottomSheet`, `PpColorPicker`, `PpPinDots`, `PpKeypad`, `PpProgressGauge`, `PpSegment`, `PpBottomNav`, `PpAppBar`, etc.) rather than plain raw Flutter widgets wherever a framework component exists.
4. **Documentation**: Add standard doc comments (`///`) to all public components, parameters, and classes in the `flutter_ui_framework`.
5. **Component Naming**: Prefix components in the framework consistently (e.g., `Pp` as seen in `pp_color_picker_demo.dart` or `pp_bottom_nav.dart`).
6. **Unique UI & Bespoke Template Architecture**: Avoid boilerplate or repetitive card list layouts. Each sample app screen should implement a tailored visual design matching its specific domain (e.g., dashboard gauges, timeline steppers, interactive preview canvases, or segmented control hubs).
