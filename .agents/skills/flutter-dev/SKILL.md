---
name: "flutter-dev"
description: "Workflow for developing and generating components in the Flutter UI Framework"
---

# Flutter Development Workflow

This skill outlines the workflow for interacting with the Flutter components and samples.

## Workflow Steps

1. **Creating a new component**:
   - Place the component in `flutter_ui_framework/lib/src/components/`.
   - Ensure the component is prefixed appropriately (e.g., `pp_`).
   - Export it from the main `flutter_ui_framework` library file.

2. **Creating a Demo**:
   - Place the demo file in `flutter_sample/lib/data/demos/`.
   - Register the demo in `flutter_sample/lib/data/component_data.dart`.

3. **Scripts**:
   - If generating icons or updating components, use the root scripts like `generate_icons.dart` or `generate_components.py` where applicable.
