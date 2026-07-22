<template>
<div class="guide-section">
        <h2>Framework Usage Guide</h2>
        <p class="custom-guide">
          This library can be used as standard Vue components OR as framework-agnostic Web Components.
        </p>
        
        <div class="variant-group">
          <h3>1. Vue 3 (Default)</h3>
          <p class="custom-guide">Import the plugin and install it in your main app instance.</p>
          <pre class="code-block"><code>import { createApp } from 'vue';
import App from './App.vue';
import UIFramework from '@phanna/ui-framework';
import '@phanna/ui-framework/style.css';

const app = createApp(App);
app.use(UIFramework);
app.mount('#app');</code></pre>
        </div>

        <div class="variant-group">
          <h3>2. React (Using Web Components)</h3>
          <p class="custom-guide">Import the Web Component bundle and register it.</p>
          <pre class="code-block"><code>import React from 'react';
import { registerWebComponents } from '@phanna/ui-framework/web-components';
import '@phanna/ui-framework/style.css';

// Register elements once
registerWebComponents();

export default function App() {
  return &lt;pp-button variant="primary"&gt;React Button&lt;/pp-button&gt;;
}</code></pre>
        </div>

        <div class="variant-group">
          <h3>3. Angular (Using Web Components)</h3>
          <p class="custom-guide">Register components in `main.ts` and add `CUSTOM_ELEMENTS_SCHEMA` to your module.</p>
          <pre class="code-block"><code>import { registerWebComponents } from '@phanna/ui-framework/web-components';
// Register elements
registerWebComponents();

// In your app.module.ts:
import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
@NgModule({
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class AppModule { }</code></pre>
        </div>

        <div class="variant-group">
          <h3>4. Plain HTML / Vanilla JS</h3>
          <p class="custom-guide">Load the script as a module and use the tags directly.</p>
          <pre class="code-block"><code>&lt;html&gt;
&lt;head&gt;
  &lt;link rel="stylesheet" href="path/to/ui-framework/dist/style.css"&gt;
  &lt;script type="module"&gt;
    import { registerWebComponents } from './path/to/wc/ui-framework-wc.es.js';
    registerWebComponents();
  &lt;/script&gt;
&lt;/head&gt;
&lt;body&gt;
  &lt;pp-button variant="primary"&gt;Native Button&lt;/pp-button&gt;
&lt;/body&gt;
&lt;/html&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
</script>
