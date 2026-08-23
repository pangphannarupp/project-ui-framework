---
name: "vue.md"
description: "Rules for Vue development in web/ui-framework, web/ and sample_apps/"
---

# Vue.js Rules

1. **Composition API**: Use the Vue 3 Composition API (`<script setup>`) for all new components.
2. **Styling**: Use scoped styling (`<style scoped>`) to avoid CSS conflicts across the mini-apps and framework.
3. **Component Structure & Architecture (STRICT STATEFUL VS STATELESS SEPARATION)**:
   - **All screens, views, and complex layouts MUST separate logic and presentation into Stateful (Smart / Container) and Stateless (Dumb / Presentational) components**:
     - **Stateful Components / Views (`src/views/`, Containers)**:
       - Responsible for data fetching, stores (Pinia / reactive state), lifecycle hooks (`onMounted`), business logic, form submissions, and orchestration.
       - Pass data down to child components via `props` and listen to user actions via `emits` / events.
       - Should avoid monolithic inline HTML markup for complex UI widgets and instead delegate rendering to dedicated subcomponents.
     - **Stateless Components (`src/components/`, Pure Presentational)**:
       - Pure, reusable presentational components that depend exclusively on typed `props` and communicate upward via `defineEmits`.
       - Must NOT fetch external network data directly or perform side effects outside their explicit prop contract.
       - Highly predictable, easily testable, and reusable across multiple screens or layouts.
   - Place reusable framework components in `web/ui-framework/src/components/` and presentational app components in `src/components/`.
4. **Naming**: Use PascalCase for component filenames (e.g., `DataPackSheet.vue`, `MiniAppGridCard.vue`, `TagFilterBar.vue`).
5. **UI Framework Usage (STRICT MANDATORY REQUIREMENT - ZERO NATIVE FALLBACK)**:
   - All web apps, portal management apps, sample apps, and mini-apps inside `sample_apps/` and `web/` MUST utilize components from `@phanna/ui-framework` wherever applicable instead of writing raw HTML elements (`<input>`, `<select>`, `<button>`, `<table>`, `<dialog>`, raw checkboxes, etc.).
   - Standard mapping of components:
     - **Buttons**: Use `PPButton`, `PPIconButton`, `PPButtonGroup`, `PPSkipButton`, `PPToggleButton`.
     - **Inputs & Fields**: Use `PPInput`, `PPTextField`, `PPPhoneInput`, `PPOtpInput`, `PPSearch`, `PPAutocomplete`, `PPTagInput`, `PPNumberSpinner`.
     - **Selections & Dropdowns**: Use `PPSelect`, `PPDropdown`, `PPTreeSelect`, `PPSegment`, `PPSegmentButton`, `PPScrollSegment`.
     - **Pickers**: Use `PPDatePicker`, `PPDateRangePicker`, `PPMonthPicker`, `PPYearPicker`, `PPQuarterPicker`, `PPTimePicker`, `PPKhmerDatePicker`, `PPKhmerCalendar`, `PPColorPicker`.
     - **Controls & Switches**: Use `PPSwitch`, `PPSlider`, `PPCheckbox`, `PPCheckboxGroup`, `PPRadio`, `PPRadioGroup`, `PPRating`.
     - **Content & Text**: Use `PPRichTextEditor`, `PPBadge`, `PPChip`, `PPAvatar`, `PPAvatarGroup`, `PPDivider`, `PPBreadcrumb`, `PPTagInput`.
     - **Overlays, Modals & Sheets**: Use `PPBottomSheet`, `PPAlert`, `PPConfirm`, `PPInputDialog`, `PPConfirmSheet`, `PPFeedbackSheet`, `PPFilterSheet`, `PPSortSheet`, `PPToast`, `PPWebToast`, `PPTooltip`.
     - **Navigation & Layout**: Use `PPAppBar`, `PPHeaderBar`, `PPBottomBar`, `PPBottomNav`, `PPNavigationDrawer`, `PPNavigationRail`, `PPSidebarNavigation`, `PPTabs`, `PPTabList`, `PPTab`, `PPTabPanels`, `PPTabPanel`, `PPScrollArea`, `PPStepper`, `PPCollapsingToolbar`.
     - **Data Display & Tables**: Use `PPTable`, `PPPagination`, `PPDraggableGrid`, `PPMonthPicker`, `PPMasonry`, `PPTimeline`, `PPTree`, `PPCollapse`, `PPKanbanBoard`.
     - **Charts & Telemetry**: Use `PPBarChart`, `PPLineChart`, `PPDonutChart`, `PPPieChart`, `PPRadarChart`, `PPScatterChart`, `PPFunnelChart`, `PPProgressGauge`.
     - **Media & File Handling**: Use `PPFileUpload`, `PPImageCropper`, `PPImagePreview`, `PPPdfViewer`, `PPFilePreview`, `PPAudioRecorder`, `PPAudioWave`, `PPCameraCapture`, `PPVideoPlayer`, `PPSignaturePad`, `PPQRCode`.
     - **Loading & Empty States**: Use `PPSkeleton`, `PPSkeletonItem`, `PPSkeletonList`, `PPSkeletonDetail`, `PPNoResult`.
6. **Unique, Bespoke UI & Domain-Specific Templates (STRICT REQUIREMENT)**:
   - **Never reuse identical layouts or copy-paste template structures** across sample apps.
   - Each mini app template must possess a **distinct, tailored visual and interaction paradigm** suited to its industry domain (e.g. 3D canvas sculptors, architectural floor plans, conveyor tunnel tracks, metallic locker hardware kiosks, cyber HUD telemetry, editorial magazine spreads).
7. **Atmospheric Immersion & Distinct Themes**: Every sample app must establish a custom color theme, unique typography hierarchy, custom ambient background gradients, and tailored micro-animations appropriate for its domain.
