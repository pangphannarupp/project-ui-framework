---
name: "vue-dev"
description: "Workflow for developing the Web UI Framework and Vue sample apps"
---

# Vue Development Workflow

This skill outlines the workflow for developing the Vue-based `web/ui-framework` and sample apps (like `web/`, `sample_apps/smart-mini-app`, etc.).

## Workflow Steps

1. **Web UI Framework**:
   - The core framework is in `web/ui-framework/`.
   - Add new reusable components here and ensure they are exported correctly.
   - Use `npm install` and `npm run build` as needed.

2. **Running Sample Apps locally**:
   - Navigate to `web/` (for the main ui-framework-sample) or a specific sample in `sample_apps/` (e.g., `sample_apps/mini-bus-ticket/`, `sample_apps/mini-cinema/`, etc.).
   - Use `npm install` and `npm run dev` to start the local development server.
   - **MANDATORY**: Use components from `@phanna/ui-framework` across all views (e.g. `PPDatePicker`, `PPTimePicker`, `PPButton`, `PPSelect`, `PPInput`, `PPBottomSheet`, `PPAlert`, `PPConfirm`, `PPQRCode`, `PPSpinWheel`, `PPProgressGauge`, `PPStepper`, `PPChip`, `PPSegment`, `PPSwitch`, `PPSlider`, `PPToast`).
   - **MANDATORY UI DIVERSITY**: When creating or updating a sample app, avoid using boilerplate card lists or identical headers. Design custom interaction models (such as 3D canvas builders, architectural floor plans, conveyor simulators, editorial magazine spreads, or cyber HUDs) tailored to the application's domain.

3. **Adding a new view to an app**:
   - Add new screens/views to `src/views/` or similar routing directories in the specific app.
   - Ensure the routing is updated in the router configuration.
   - Always compose screens using framework components and bespoke visual designs rather than generic repetitive cards.

4. **State and Props**:
   - Use standard Vue 3 `ref` and `reactive` for local state.
   - For global state, check if Pinia is configured and use stores.
