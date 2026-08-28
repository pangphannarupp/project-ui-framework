# Sample Projects Configuration Rules

When creating a new sample web/portal project in the `sample_apps/` directory, always adhere to the following rules:

## Tech Stack
1. **Framework**: ALWAYS use **Vue 3** with Composition API (`<script setup lang="ts">`). Do NOT use React, Angular, or vanilla JS.
2. **Language**: ALWAYS use **TypeScript**.
3. **Build Tool**: Use **Vite**.

## Scaffolding & Setup
1. **Dependencies**: 
   - Ensure `@phanna/ui-framework` is linked in `package.json` (`"file:../../web/ui-framework"`).
   - Ensure `vue`, `vue-router`, and any required icons (e.g., `ionicons`) are installed.
2. **TypeScript Config**: 
   - Provide standard `tsconfig.json` and `tsconfig.node.json` for Vue + Vite.
3. **Styles & UI Framework**:
   - In `src/main.ts`, you MUST import the UI framework styles using exactly:
     `import '@phanna/ui-framework/style.css'` (Do NOT use `dist/style.css`).
   - Register the framework:
     `import UIFramework from '@phanna/ui-framework'`
     `app.use(UIFramework as any)`
   - Include Tailwind CSS via CDN in `index.html` to ensure utility classes like `p-4`, `flex`, `bg-gray-50` work out-of-the-box:
     `<script src="https://cdn.tailwindcss.com"></script>`

## Design & UI Requirements
1. **Mandatory Components**: Exclusively use components from `@phanna/ui-framework` (e.g., `PPButton`, `PPTextField`, `PPSelect`, `PPChip`) rather than building raw HTML components from scratch.
2. **Theming**: Implement unique layouts and distinct domains for each demo (e.g., dark mode cyber aesthetic, clean minimal look, bright vibrant theme). Avoid generic repeating lists without distinct flavor.
