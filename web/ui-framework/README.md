# @phanna/ui-framework

Enterprise Cross-Platform UI Component Library built with **Vue 3**, **TypeScript**, and **Ionic Icons**.

---

## 📦 Installation Guide (Without Public npm)

You can install `@phanna/ui-framework` directly from GitHub using any of the following methods:

### Method 1: Direct GitHub Release URL (Recommended)

Install the pre-built tarball package directly from the GitHub Release:

```bash
# Using npm
npm install https://github.com/pangphannarupp/project-ui-framework/releases/download/v1.0.11/phanna-ui-framework-1.0.11.tgz

# Using yarn
yarn add https://github.com/pangphannarupp/project-ui-framework/releases/download/v1.0.11/phanna-ui-framework-1.0.11.tgz

# Using pnpm
pnpm add https://github.com/pangphannarupp/project-ui-framework/releases/download/v1.0.11/phanna-ui-framework-1.0.11.tgz
```

---

### Method 2: Direct Git Repository URL

Install directly from the GitHub repository via Git tag:

```bash
npm install git+https://github.com/pangphannarupp/project-ui-framework.git#v1.0.11
```

---

### Method 3: Download & Install Locally

1. Download `phanna-ui-framework-1.0.11.tgz` from [GitHub Releases](https://github.com/pangphannarupp/project-ui-framework/releases).
2. Place it in your project folder and run:
```bash
npm install ./phanna-ui-framework-1.0.11.tgz
```

---

## 🚀 Quick Setup & Usage in Vue 3

### 1. Peer Dependencies

Ensure your project has the required peer dependencies installed:

```bash
npm install vue@^3.3.0 @ionic/vue@^8.0.0 ionicons@^8.0.0
```

---

### 2. Register Plugin & Styles

In your `main.ts` or `main.js`:

```typescript
import { createApp } from 'vue'
import App from './App.vue'

// 1. Import UI Framework & Styles
import UIFramework from '@phanna/ui-framework'
import '@phanna/ui-framework/style.css'

// 2. Import Ionic Vue if needed
import { IonicVue } from '@ionic/vue'
import '@ionic/vue/css/core.css'

const app = createApp(App)

app.use(IonicVue)
app.use(UIFramework)

app.mount('#app')
```

---

### 3. Component Usage Example

All components are globally registered or can be imported individually:

```vue
<template>
  <div class="container">
    <!-- Buttons -->
    <PPButton variant="primary" size="normal" @click="handleClick">
      <span>Save Changes</span>
    </PPButton>

    <!-- Inputs -->
    <PPInput v-model="username" placeholder="Enter username..." />

    <!-- Select Dropdowns -->
    <PPSelect
      v-model="selectedCategory"
      :options="[
        { label: 'Services', value: 'services' },
        { label: 'Entertainment', value: 'entertainment' }
      ]"
    />

    <!-- Switches -->
    <PPSwitch v-model="isEnabled" />

    <!-- Skeletons / Shimmers -->
    <PPSkeleton :loading="isLoading" :animated="true">
      <template #template>
        <PPSkeletonItem variant="rect" width="100%" height="40px" />
      </template>
      <div>Content is loaded!</div>
    </PPSkeleton>

    <!-- Pagination -->
    <PPPagination
      :total="100"
      :page-size="10"
      :current-page="currentPage"
      @update:current-page="val => currentPage = val"
    />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'

const username = ref('')
const selectedCategory = ref('services')
const isEnabled = ref(true)
const isLoading = ref(false)
const currentPage = ref(1)

const handleClick = () => {
  console.log('Button clicked')
}
</script>
```

---

## 🌐 Web Components (Custom Elements)

To use in non-Vue projects (React, Angular, Plain HTML/JS):

```html
<script type="module" src="https://github.com/pangphannarupp/project-ui-framework/releases/download/v1.0.11/dist/wc/ui-framework-wc.es.js"></script>
<link rel="stylesheet" href="https://github.com/pangphannarupp/project-ui-framework/releases/download/v1.0.11/dist/style.css">

<!-- Use standard custom elements -->
<pp-button variant="primary">Submit</pp-button>
```

---

## 🛠 Local Development & Building

```bash
# Clone the repository
git clone https://github.com/pangphannarupp/project-ui-framework.git
cd project-ui-framework/web/ui-framework

# Install dependencies
npm install

# Run dev server
npm run dev

# Build production bundle & pack .tgz
npm run build
npm pack
```
