---
name: "vue.md"
description: "Rules for Vue development in web/ui-framework, web/ and sample_apps/"
---

# Vue.js Rules

1. **Composition API**: Use the Vue 3 Composition API (`<script setup>`) for all new components.
2. **Styling**: Use scoped styling (`<style scoped>`) to avoid CSS conflicts across the mini-apps and framework.
3. **Component Structure**: Follow the standard Single File Component (SFC) pattern. Place reusable framework components in `web/ui-framework/src/components/` and views for apps in their respective `src/views/` directories.
4. **Naming**: Use PascalCase for component filenames (e.g., `DataPackSheet.vue`).
5. **UI Framework Usage (STRICT REQUIREMENT)**: All sample apps, mini-apps, and demo projects inside `sample_apps/` and `web/` MUST utilize components from `@phanna/ui-framework` wherever applicable (e.g., `PPButton`, `PPInput`, `PPTextField`, `PPSelect`, `PPDatePicker`, `PPTimePicker`, `PPBottomSheet`, `PPAlert`, `PPConfirm`, `PPQRCode`, `PPSpinWheel`, `PPProgressGauge`, `PPStepper`, `PPBadge`, `PPChip`, `PPSegment`, `PPSwitch`, `PPSlider`, `PPToast`, etc.) instead of raw unstyled HTML elements (`<input>`, `<select>`, `<button>`, etc.).
6. **Zero Plain Fallback for Standard Controls**: Always replace native `<input type="date">` with `PPDatePicker`, native buttons with `PPButton`, native inputs/selects with `PPInput`/`PPSelect`, and modal/dialog elements with `PPAlert`/`PPConfirm`/`PPBottomSheet`.
7. **Unique, Bespoke UI & Domain-Specific Templates (STRICT REQUIREMENT)**:
   - **Never reuse identical layouts or copy-paste template structures** across sample apps (e.g. avoid repeating the same generic card lists, identical header buttons, or standard bottom bars across different mini apps).
   - Each mini app template must possess a **distinct, tailored visual and interaction paradigm** suited to its industry domain. Examples:
     - *Artisan/F&B*: 3D visual drink sculptors, liquid brew customizers, horizontal aroma ribbons.
     - *Gym/Fitness/Sports*: Tactical cyber HUD dashboards, telemetry ring gauges, matrix timetable schedules.
     - *Smart Facilities/Laundromat*: Top-down architectural floor plans, physical bay grids, rotating drum windows, cycle rotary dials.
     - *Logistics/Smart Lockers*: Physical metallic locker door matrices with ventilation slots, hardware LED status lights, industrial touchscreen numeric PIN keypads.
     - *Hospitality/Luxury*: Full-bleed editorial magazine spreads, serif typography, floating gold concierge bars, NFC keycards.
     - *Automotive/Car Wash*: Conveyor tunnel track simulators, windshield cockpit views, animated foam sprays, gloss stage meters.
     - *Gifting/Celebration*: 3D interactive unboxing studios, foil texture swatch palettes, tactile denomination capsules.
     - *Live Events/Arenas*: Stadium seating perspective maps, spotlight beam stages, color-coded sector visualizers.
8. **Atmospheric Immersion & Distinct Themes**: Every sample app must establish a custom color theme, unique typography hierarchy, custom ambient background gradients, and tailored micro-animations appropriate for its domain.
