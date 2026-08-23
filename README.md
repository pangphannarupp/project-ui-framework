# Project UI Framework

Cross-platform UI Component Library and Multi-App Ecosystem across **Web (Vue 3)**, **Flutter**, **Android**, and **iOS**.

---

## 📦 Web UI Framework Installation (`@phanna/ui-framework`)

You can install `@phanna/ui-framework` directly from GitHub releases without needing public npm.

### Quick Install:

```bash
# Recommended: Install directly from GitHub Release
npm install https://github.com/pangphannarupp/project-ui-framework/releases/download/v1.0.11/phanna-ui-framework-1.0.11.tgz
```

### Or via Git Repository Tag:

```bash
npm install git+https://github.com/pangphannarupp/project-ui-framework.git#v1.0.11
```

---

## 🚀 Quick Setup in Vue 3

### 1. Register Plugin & Styles

In your `main.ts`:

```typescript
import { createApp } from 'vue'
import App from './App.vue'

// Import UI Framework & Styles
import UIFramework from '@phanna/ui-framework'
import '@phanna/ui-framework/style.css'

import { IonicVue } from '@ionic/vue'
import '@ionic/vue/css/core.css'

const app = createApp(App)
app.use(IonicVue)
app.use(UIFramework)
app.mount('#app')
```

### 2. Component Usage

```vue
<template>
  <PPButton variant="primary" size="small" @click="onSubmit">
    <span>Save Configuration</span>
  </PPButton>

  <PPInput v-model="appName" placeholder="App name..." />

  <PPSkeleton :loading="isLoading" :animated="true">
    <template #template>
      <PPSkeletonItem variant="rect" height="48px" />
    </template>
    <div>Loaded content</div>
  </PPSkeleton>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const appName = ref('')
const isLoading = ref(false)
const onSubmit = () => console.log('Saved!')
</script>
```

---

## 📱 Multi-Platform Architecture

- **Web**: `web/ui-framework` (Vue 3, TypeScript, Web Components)
- **Flutter**: `flutter_ui_framework`
- **Android**: `android/`
- **iOS**: `ios/`
- **Sample Portal App**: `sample_apps/mini-portal-management`