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

2. **Running & Building Sample Apps**:
   - Navigate to `web/` (for the main ui-framework-sample) or a specific sample in `sample_apps/` (e.g., `sample_apps/mini-portal-management/`, `sample_apps/mini-cinema/`, etc.).
   - Use `npm install` and `npm run dev` to start the local development server.
   - **MANDATORY**: Use components from `@phanna/ui-framework` across all views and forms (e.g., `PPButton`, `PPIconButton`, `PPInput`, `PPTextField`, `PPSelect`, `PPDatePicker`, `PPTimePicker`, `PPRichTextEditor`, `PPTable`, `PPPagination`, `PPBottomSheet`, `PPAlert`, `PPConfirm`, `PPQRCode`, `PPSwitch`, `PPSegment`, `PPSegmentButton`, `PPChip`, `PPBadge`, `PPAvatar`, `PPToast`, etc.) instead of raw HTML elements (`<input>`, `<select>`, `<button>`, `<table>`, raw toggles, etc.).
   - **MANDATORY UI DIVERSITY**: When creating or updating a sample app, avoid using boilerplate card lists or identical headers. Design custom interaction models (such as 3D canvas builders, architectural floor plans, conveyor simulators, editorial magazine spreads, or cyber HUDs) tailored to the application's domain.

3. **Adding a new view or component (Stateful vs Stateless Architecture)**:
   - **MANDATORY**: Separate all screen architectures into **Stateful Containers** and **Stateless Presentational Components**:
     - **Stateful Views (`src/views/`)**: Handle route parameters, data fetching, reactive state (`ref`, `reactive`, Pinia), and event handlers.
     - **Stateless Components (`src/components/`)**: Receive data solely through typed `props` and emit events upward via `defineEmits`. No side effects or direct API calls.
   - Ensure the routing is updated in the router configuration.
   - Always compose screens using framework components and bespoke visual designs rather than generic repetitive cards.

4. **State and Props**:
   - Use standard Vue 3 `ref` and `reactive` for local state.
   - For global state, check if Pinia is configured and use stores.
   - Pass state down to dumb/stateless presentational components via props, and bubble user interactions back up via emits.
