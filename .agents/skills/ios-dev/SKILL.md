---
name: "ios-dev"
description: "Workflow for iOS native development and SwiftUI component creation with Web UI-Framework parity"
---

# iOS Native Development Workflow

This skill outlines the workflow for developing iOS components in `ios/ui-framework-sample/UIFramework/` with strict parity to `web/ui-framework/`.

## Core Principle: Web UI-Framework as SSOT
Whenever you create or update an iOS component, `web/ui-framework/src/components/PP<Name>.vue` is the Single Source of Truth (SSOT). The iOS component must match the web component in **name**, **usage (API/props/events/slots)**, and **style (tokens, colors, dimensions, corner radius, states)**.

---

## Step-by-Step Component Creation Workflow

### Step 1: Inspect the Reference Web Component
1. Open and inspect `web/ui-framework/src/components/PP<Name>.vue`.
2. Extract the complete component contract:
   - **Props**: Identify all props, types, and default values (e.g., `variant`, `size`, `block`, `disabled`, `loading`, `rounded`).
   - **Events**: Note all `defineEmits` events (`@click`, `@update:modelValue`, `@change`, `@complete`).
   - **Slots**: Note default slot and named slots (`iconLeft`, `iconRight`, etc.).
   - **Styles & Tokens**: Check `<style scoped>` for CSS variables (`--pp-primary-variant`, `--pp-primary`, padding, height, border radius, transitions).

### Step 2: Formulate the SwiftUI View Contract
1. Create the component file in:
   `ios/ui-framework-sample/UIFramework/Sources/UIFramework/Biz<Name>.swift`
2. Declare any variant/size enums:
   ```swift
   public enum Biz<Name>Variant {
       case primary, secondary, outline, ghost, danger, success, outlineDanger
   }
   ```
3. Define the public SwiftUI View struct and initializer:
   ```swift
   import SwiftUI

   public struct Biz<Name>: View {
       public var variant: Biz<Name>Variant
       public var isBlock: Bool
       public var loading: Bool
       public var action: () -> Void

       public init(
           variant: Biz<Name>Variant = .primary,
           isBlock: Bool = false,
           loading: Bool = false,
           action: @escaping () -> Void = {}
       ) {
           self.variant = variant
           self.isBlock = isBlock
           self.loading = loading
           self.action = action
       }

       public var body: some View { ... }
   }
   ```
4. **MANDATORY Web Alias**: Always provide a matching `PP<Name>` typealias:
   ```swift
   public typealias PP<Name> = Biz<Name>
   ```

### Step 3: Implement Visual Styling Matching Web Design Tokens
Apply the exact design tokens used in web:
- **Colors**:
  - Primary Variant (Navy): `Color(hex: "#1A2A5E")`
  - Primary Brand (Blue): `Color(hex: "#003399")`
  - Primary Hover/Pressed: `Color(hex: "#121E42")`
  - Secondary: `Color(hex: "#F1F5F9")` / `Color(hex: "#E0E0E0")`
  - Danger: `Color(hex: "#EF4444")` / `Color(hex: "#D32F2F")`
  - Success: `Color(hex: "#10B981")`
  - Warning: `Color(hex: "#F59E0B")`
  - Border: `Color(hex: "#CCCCCC")` / `Color(hex: "#CBD5E1")`
  - Disabled: Background `Color(hex: "#C0C0C0")`, Content `Color.white`
- **Shapes & Radii**:
  - `.cornerRadius(12)` for cards, buttons, dialogs, sheets.
  - `.cornerRadius(8)` for chips/badges.
  - `Capsule()` or `.cornerRadius(9999)` for rounded/pill variants.
- **Dimensions**:
  - Default min height: `.frame(minHeight: 56)` for large, `44`-`48` for medium, `32`-`36` for small.
  - Sizing padding: `.padding(.horizontal, 24)` for large, `16` for medium, `12` for small.
- **Interactive States**:
  - Loading: Render `ProgressView()` when `loading == true`.
  - Disabled: Read `@Environment(\.isEnabled) private var isEnabled` and adjust opacity/colors.

### Step 4: Register in Gallery & Demo Views
1. Navigate to:
   `ios/ui-framework-sample/UIFramework/Sources/UIFramework/Phase*Demos.swift`
2. Add a showcase view demonstrating:
   - Default / Primary state
   - Secondary / Outline / Ghost variants
   - Disabled and Loading states
   - Icon integration (`iconLeft` / `iconRight`)
3. Add preview provider `#Preview` for Xcode live preview.

### Step 5: Verify & Build
1. Run `swift build` inside the package directory to verify compilation:
   ```bash
   cd ios/ui-framework-sample/UIFramework
   swift build
   ```
2. If building from the root iOS project:
   ```bash
   xcodebuild -workspace ios/ui-framework-sample/ui-framework-sample.xcodeproj/project.xcworkspace -scheme ui-framework-sample -sdk iphonesimulator build
   ```
