---
name: "android-dev"
description: "Workflow for Android native development and Jetpack Compose component creation with Web UI-Framework parity"
---

# Android Native Development Workflow

This skill outlines the workflow for developing Android components in `android/ui-framework-sample/ui-framework/` with strict parity to `web/ui-framework/`.

## Core Principle: Web UI-Framework as SSOT
Whenever you create or update an Android component, `web/ui-framework/src/components/PP<Name>.vue` is the Single Source of Truth (SSOT). The Android component must match the web component in **name**, **usage (API/props/events/slots)**, and **style (tokens, colors, dimensions, corner radius, states)**.

---

## Step-by-Step Component Creation Workflow

### Step 1: Inspect the Reference Web Component
1. Open and inspect `web/ui-framework/src/components/PP<Name>.vue`.
2. Extract the complete component contract:
   - **Props**: Identify all props, types, and default values (e.g., `variant`, `size`, `block`, `disabled`, `loading`, `rounded`).
   - **Events**: Note all `defineEmits` events (`@click`, `@update:modelValue`, `@change`, `@complete`).
   - **Slots**: Note default slot and named slots (`iconLeft`, `iconRight`, etc.).
   - **Styles & Tokens**: Check `<style scoped>` for CSS variables (`--pp-primary-variant`, `--pp-primary`, padding, height, border radius, transitions).

### Step 2: Formulate the Kotlin Jetpack Compose Contract
1. Create the component file in:
   `android/ui-framework-sample/ui-framework/src/main/java/kh/mcnc/lib/components/Biz<Name>.kt`
2. Declare any variant/size enums:
   ```kotlin
   enum class Biz<Name>Variant {
       Primary, Secondary, Outline, Ghost, Danger, Success, OutlineDanger
   }
   ```
3. Define the composable function signature:
   ```kotlin
   @Composable
   fun Biz<Name>(
       modifier: Modifier = Modifier,
       variant: Biz<Name>Variant = Biz<Name>Variant.Primary,
       enabled: Boolean = true,
       loading: Boolean = false,
       // ... other mapped props
       onClick: () -> Unit = {}
   ) { ... }
   ```
4. **MANDATORY Web Alias**: Always provide a matching `PP<Name>` composable wrapper:
   ```kotlin
   @Composable
   fun PP<Name>(
       modifier: Modifier = Modifier,
       variant: Biz<Name>Variant = Biz<Name>Variant.Primary,
       enabled: Boolean = true,
       loading: Boolean = false,
       onClick: () -> Unit = {}
   ) {
       Biz<Name>(
           modifier = modifier,
           variant = variant,
           enabled = enabled,
           loading = loading,
           onClick = onClick
       )
   }
   ```

### Step 3: Implement Visual Styling Matching Web Design Tokens
Apply the exact design tokens used in web:
- **Colors**:
  - Primary Variant (Navy): `Color(0xFF1A2A5E)`
  - Primary Brand (Blue): `Color(0xFF003399)`
  - Primary Hover/Pressed: `Color(0xFF121E42)`
  - Secondary: `Color(0xFFF1F5F9)` / `Color(0xFFE0E0E0)`
  - Danger: `Color(0xFFEF4444)` / `Color(0xFFD32F2F)`
  - Success: `Color(0xFF10B981)`
  - Warning: `Color(0xFFF59E0B)`
  - Border: `Color(0xFFCCCCCC)` / `Color(0xFFCBD5E1)`
  - Disabled: Background `Color(0xFFC0C0C0)`, Content `Color.White`
- **Shapes & Radii**:
  - `RoundedCornerShape(12.dp)` for cards, buttons, dialogs, sheets.
  - `RoundedCornerShape(8.dp)` for chips/badges.
  - `CircleShape` for rounded/pill variants.
- **Dimensions**:
  - Default min height: `56.dp` for large, `44.dp`-`48.dp` for medium, `32.dp`-`36.dp` for small.
  - Sizing padding: `24.dp` horizontal (large), `16.dp` (medium), `12.dp` (small).
- **Interactive States**:
  - Loading: Render a `CircularProgressIndicator` (size ~20-24.dp) when `loading == true`.
  - Disabled: Adjust alpha or use disabled color tokens when `enabled == false`.

### Step 4: Register in Gallery & Demo Screens
1. Navigate to:
   `android/ui-framework-sample/ui-framework/src/main/java/kh/mcnc/lib/ui/ComponentGalleryScreen.kt`
2. Add a showcase section demonstrating:
   - Default / Primary state
   - Secondary / Outline / Ghost variants
   - Disabled and Loading states
   - Icon integration (`iconLeft` / `iconRight`)
3. Register the component in `ComponentDetailActivity.kt` / `ComponentListActivity.kt` if applicable.

### Step 5: Verify & Build
1. Run Gradle to compile and verify:
   ```bash
   cd android/ui-framework-sample
   ./gradlew :ui-framework:assembleDebug
   ```
2. If compilation or lint errors occur, inspect and resolve them, or leverage repository utility scripts (`fix_kt_errors.py`, etc.).
