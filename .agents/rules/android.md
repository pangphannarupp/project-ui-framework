---
name: "android.md"
description: "Rules for Android native development and Jetpack Compose component parity with web/ui-framework"
---

# Android Native Rules & Component Standards

## 1. Web UI-Framework as Single Source of Truth (SSOT)
When creating, updating, or refactoring any component in Android (`android/ui-framework-sample/ui-framework/`):
- **MANDATORY**: You MUST inspect the reference component in `web/ui-framework/src/components/PP<Name>.vue` before writing any code.
- Extract the complete contract: props, default values, union string types, slots, emitted events, and CSS styles/tokens.
- Ensure 100% parity with web in **name**, **usage (API contract)**, and **style (visual appearance)**.

## 2. Component Naming & Alias Parity
- **File Placement**: Place the component in `android/ui-framework-sample/ui-framework/src/main/java/kh/mcnc/lib/components/Biz<Name>.kt`.
- **Primary Composable**: Name the primary composable `Biz<Name>`.
- **Web Alias**: Always provide a matching `PP<Name>` composable wrapper / alias forwarding all parameters directly to `Biz<Name>` so code can reference both `Biz<Name>` and `PP<Name>` interchangeably.
- **Core Name**: The core identifier `<Name>` must strictly match the web component `PP<Name>.vue` (e.g., `PPButton` -> `BizButton` & `PPButton`, `PPSwitch` -> `BizSwitch` & `PPSwitch`, `PPDatePicker` -> `BizDatePicker` & `PPDatePicker`).

## 3. Usage & API Contract Parity
- **Parameters & Defaults**:
  - Map Vue `props` to Kotlin parameters with identical names, types, and default values.
  - Boolean flags must preserve semantics (e.g. `block: Boolean = false`, `disabled: Boolean = false`, `loading: Boolean = false`, `rounded: Boolean = false`).
  - Standard `modifier: Modifier = Modifier` should always be exposed as the first optional parameter.
- **Callbacks & Events**:
  - Map Vue events (`@click`, `@update:modelValue`, `@change`, `@complete`) to idiomatic Kotlin lambda functions:
    - `@click` -> `onClick: () -> Unit`
    - `@update:modelValue` / `@change` -> `onValueChange: (T) -> Unit` or `onCheckedChange: (Boolean) -> Unit`
    - `@complete` -> `onComplete: ((String) -> Unit)? = null`
- **Slots & Children**:
  - Map Vue slots to `@Composable` lambda parameters:
    - Default slot / text -> `text: String` or `content: @Composable () -> Unit`
    - Named icon slots (`iconLeft`, `iconRight`) -> `iconLeft: @Composable (() -> Unit)? = null`, `iconRight: @Composable (() -> Unit)? = null`
- **Variants & Options**:
  - Map Vue string literal unions (`variant?: 'primary' | 'secondary' | 'outline' | 'ghost' | 'danger' | 'success' | 'outline-danger'`) to a strongly-typed Kotlin `enum class` (e.g., `BizButtonVariant { Primary, Secondary, Outline, Ghost, Danger, Success, OutlineDanger }`).

## 4. Style & Design Token Parity
All colors, dimensions, borders, and typography must mirror `web/ui-framework`:
- **Color Tokens**:
  - **Primary Variant (Navy)**: `Color(0xFF1A2A5E)` (maps to `--pp-primary-variant` / `#1a2a5e`)
  - **Primary Brand (Blue)**: `Color(0xFF003399)` (maps to `--pp-primary` / `#003399`)
  - **Primary Pressed / Active**: `Color(0xFF121E42)`
  - **Secondary**: `Color(0xFFF1F5F9)` or `Color(0xFFE0E0E0)` with text `Color(0xFF334155)` / `Color(0xFF333333)`
  - **Danger**: `Color(0xFFEF4444)` / `Color(0xFFD32F2F)`
  - **Success**: `Color(0xFF10B981)`
  - **Warning**: `Color(0xFFF59E0B)`
  - **Info / Accent**: `Color(0xFF3B82F6)`
  - **Outline / Border**: `Color(0xFFCCCCCC)` or `Color(0xFFCBD5E1)`
  - **Disabled Background**: `Color(0xFFC0C0C0)` or `Color(0xFFE2E8F0)`
  - **Disabled Content**: `Color(0xFFFFFFFF)` or `Color(0xFFA5ADBA)`
- **Corner Radii**:
  - Standard cards, buttons, inputs, sheets, and dialogs: `RoundedCornerShape(12.dp)`
  - Chips, tags, small badges: `RoundedCornerShape(8.dp)`
  - Rounded / pill variant: `CircleShape` or `RoundedCornerShape(9999.dp)`
- **Sizing & Spacing**:
  - Button / Input heights: `56.dp` for large, `44.dp`-`48.dp` for medium/normal, `32.dp`-`36.dp` for small.
  - Horizontal padding: `24.dp` for large, `16.dp` for medium, `12.dp` for small.
  - Icon gap: `8.dp` between icon and label.
- **Interactive States**:
  - Implement active/pressed darkening or ripple effects matching web hover/active styles.
  - Disabled state: Set `enabled = false` and adjust opacity/colors.
  - Loading state: Display a circular progress indicator (`CircularProgressIndicator`) matching web spinner behavior.

## 5. Gallery & Demo Verification
- After creating or updating a component, add an interactive showcase in:
  - `android/ui-framework-sample/ui-framework/src/main/java/kh/mcnc/lib/ui/ComponentGalleryScreen.kt`
  - Register the item in `ComponentDetailActivity.kt` / `ComponentListActivity.kt` so it is navigable.
- Verify that the component compiles cleanly without errors using `./gradlew assembleDebug` or the repository's fix scripts.

## 6. General Android Best Practices
- **Kotlin First**: Use modern Kotlin idioms and Jetpack Compose (Material 3).
- **State Hoisting**: Keep presentational components stateless by accepting state values and passing events up via lambda callbacks.
- **Preview Annotations**: Include `@Preview` composables with both light and dark backgrounds for fast design verification.
