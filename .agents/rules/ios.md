---
name: "ios.md"
description: "Rules for iOS native development and SwiftUI component parity with web/ui-framework"
---

# iOS Native Rules & Component Standards

## 1. Web UI-Framework as Single Source of Truth (SSOT)
When creating, updating, or refactoring any component in iOS (`ios/ui-framework-sample/UIFramework/`):
- **MANDATORY**: You MUST inspect the reference component in `web/ui-framework/src/components/PP<Name>.vue` before writing any code.
- Extract the complete contract: props, default values, union string types, slots, emitted events, and CSS styles/tokens.
- Ensure 100% parity with web in **name**, **usage (API contract)**, and **style (visual appearance)**.

## 2. Component Naming & Alias Parity
- **File Placement**: Place the component in `ios/ui-framework-sample/UIFramework/Sources/UIFramework/Biz<Name>.swift`.
- **Primary View**: Name the primary SwiftUI view `public struct Biz<Name>: View`.
- **Web Alias**: Always provide a matching `public typealias PP<Name> = Biz<Name>` (or equivalent wrapper) so code can reference both `Biz<Name>` and `PP<Name>` interchangeably.
- **Core Name**: The core identifier `<Name>` must strictly match the web component `PP<Name>.vue` (e.g., `PPButton` -> `BizButton` & `PPButton`, `PPSwitch` -> `BizSwitch` & `PPSwitch`, `PPDatePicker` -> `BizDatePicker` & `PPDatePicker`).

## 3. Usage & API Contract Parity
- **Properties & Initializers**:
  - Map Vue `props` to Swift struct properties with identical names, types, and default values.
  - Mark the struct and its initializer with `public init(...)`.
  - Boolean flags must preserve semantics (e.g., `isBlock: Bool = false`, `disabled: Bool = false`, `loading: Bool = false`, `rounded: Bool = false`).
- **Bindings & State**:
  - Map two-way bindings (`v-model`) to `@Binding public var ...` (e.g., `isOn: Binding<Bool>`, `text: Binding<String>`).
- **Callbacks & Actions**:
  - Map Vue events (`@click`, `@complete`, etc.) to Swift action closures:
    - `@click` -> `action: () -> Void`
    - `@complete` -> `onComplete: ((String) -> Void)? = nil`
- **Slots & Children**:
  - Map Vue slots to `@ViewBuilder` closures or `AnyView`:
    - Default slot / label -> `label: String` or `@ViewBuilder content: () -> Content`
    - Named icon slots (`iconLeft`, `iconRight`) -> `iconLeft: (() -> AnyView)? = nil`, `iconRight: (() -> AnyView)? = nil`
- **Variants & Options**:
  - Map Vue string literal unions (`variant?: 'primary' | 'secondary' | 'outline' | 'ghost' | 'danger' | 'success' | 'outline-danger'`) to a strongly-typed Swift `public enum` (e.g., `public enum BizButtonVariant { case primary, secondary, outline, ghost, danger, success, outlineDanger }`).

## 4. Style & Design Token Parity
All colors, dimensions, borders, and typography must mirror `web/ui-framework`:
- **Color Tokens**:
  - **Primary Variant (Navy)**: `Color(hex: "#1A2A5E")` (maps to `--pp-primary-variant` / `#1a2a5e`)
  - **Primary Brand (Blue)**: `Color(hex: "#003399")` (maps to `--pp-primary` / `#003399`)
  - **Primary Pressed / Active**: `Color(hex: "#121E42")`
  - **Secondary**: `Color(hex: "#F1F5F9")` or `Color(hex: "#E0E0E0")` with text `Color(hex: "#334155")` / `Color(hex: "#333333")`
  - **Danger**: `Color(hex: "#EF4444")` / `Color(hex: "#D32F2F")`
  - **Success**: `Color(hex: "#10B981")`
  - **Warning**: `Color(hex: "#F59E0B")`
  - **Info / Accent**: `Color(hex: "#3B82F6")`
  - **Outline / Border**: `Color(hex: "#CCCCCC")` or `Color(hex: "#CBD5E1")`
  - **Disabled Background**: `Color(hex: "#C0C0C0")` or `Color(hex: "#E2E8F0")`
  - **Disabled Content**: `Color.white` or `Color(hex: "#A5ADBA")`
- **Corner Radii**:
  - Standard cards, buttons, inputs, sheets, and dialogs: `.cornerRadius(12)`
  - Chips, tags, small badges: `.cornerRadius(8)`
  - Rounded / pill variant: `.clipShape(Capsule())` or `.cornerRadius(9999)`
- **Sizing & Spacing**:
  - Button / Input heights: `.frame(minHeight: 56)` for large, `44`-`48` for medium/normal, `32`-`36` for small.
  - Horizontal padding: `24` for large, `16` for medium, `12` for small.
  - Icon gap: `8` pt between icon and label.
- **Interactive States**:
  - Implement active/pressed darkening using `ButtonStyle` or pressed opacity (`configuration.isPressed ? 0.8 : 1.0`).
  - Disabled state: Read `@Environment(\.isEnabled) private var isEnabled` and adjust opacity/background colors.
  - Loading state: Display `ProgressView()` spinner matching web spinner behavior.

## 5. Gallery & Demo Verification
- After creating or updating a component, add an interactive showcase in:
  - `ios/ui-framework-sample/UIFramework/Sources/UIFramework/Phase*Demos.swift` or gallery screens.
- Verify that the component compiles cleanly without errors using `swift build` in `ios/ui-framework-sample/UIFramework/`.

## 6. General iOS Best Practices
- **SwiftUI First**: Write components using declarative SwiftUI with clean modular layout views (`HStack`, `VStack`, `ZStack`).
- **Public Modifiers**: Since `UIFramework` is a Swift Package module, all exposed structs, enums, properties, initializers, and `body` must be declared `public`.
- **Preivew Providers**: Include `#Preview` or `PreviewProvider` with sample state for interactive canvas validation.
