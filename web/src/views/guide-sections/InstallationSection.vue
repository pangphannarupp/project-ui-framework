<template>
<div class="guide-section">
        <h2>Installation & Package Setup</h2>
        <p class="custom-guide">
          Install <code>@phanna/ui-framework</code> directly from GitHub Releases or Git tags without needing public npm.
        </p>

        <div class="variant-group">
          <h3>📦 1. Installation (GitHub Release)</h3>
          <p class="custom-guide">Install the pre-built release package directly into your project:</p>
          <pre class="code-block" v-pre><code># Direct GitHub Release URL (.tgz)
npm install https://github.com/pangphannarupp/project-ui-framework/releases/download/v1.0.11/phanna-ui-framework-1.0.11.tgz

# Or via Git Repository Tag
npm install git+https://github.com/pangphannarupp/project-ui-framework.git#v1.0.11</code></pre>
        </div>

        <h2 style="margin-top: 32px;">Framework Usage Guide</h2>
        <p class="custom-guide">
          This library can be used as standard Vue components OR as framework-agnostic Web Components.
        </p>
        
        <div class="variant-group">
          <h3>1. Vue 3 (Default)</h3>
          <p class="custom-guide">Import the plugin and install it in your main app instance.</p>
          <pre class="code-block" v-pre><code>import { createApp } from 'vue';
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
          <pre class="code-block" v-pre><code>import React from 'react';
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
          <pre class="code-block" v-pre><code>import { registerWebComponents } from '@phanna/ui-framework/web-components';
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
          <pre class="code-block" v-pre><code>&lt;html&gt;
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

        <div class="variant-group">
          <h3>5. Customizing CSS Variables</h3>
          <p class="custom-guide">You can override the framework's design tokens globally by redefining CSS variables in your own stylesheet. We use the <code>--pp-</code> prefix for all variables to prevent conflicts.</p>
          
          <h4 style="margin-top: 16px; margin-bottom: 8px;">Global Colors & Surface</h4>
          <pre class="code-block" v-pre><code>/* main.css or App.vue &lt;style&gt; */
:root {
  /* Brand Colors */
  --pp-primary: #10b981;
  --pp-primary-variant: #047857; /* Darker primary for hover/active */
  --pp-primary-light: #d1fae5;
  
  /* Semantic Colors */
  --pp-danger-color: #ef4444;
  --pp-success-color: #10b981;
  --pp-warning-color: #f59e0b;

  /* Surfaces & Backgrounds */
  --pp-background: #f8fafc;
  --pp-background-alt: #f1f5f9;
  --pp-surface: #ffffff;
  
  /* Typography & Borders */
  --pp-text-color: #1e293b;
  --pp-border-color: #e2e8f0;
  --pp-border-radius: 8px;
}</code></pre>

          <h4 style="margin-top: 24px; margin-bottom: 8px;">Component-Specific Overrides</h4>
          <p class="custom-guide" style="margin-bottom: 12px;">Many components have their own specific variables that you can target if you only want to customize that component.</p>
          <pre class="code-block" v-pre><code>:root {
  /* Bottom Sheet */
  --pp-bottom-sheet-bg: #ffffff;
  --pp-bottom-sheet-radius: 24px 24px 0 0;
  --pp-bottom-sheet-backdrop: rgba(0, 0, 0, 0.4);
  
  /* App Bar */
  --pp-app-bar-bg: #ffffff;
  --pp-app-bar-color: #1e293b;
  --pp-app-bar-height: 60px;
  
  /* Navigation Drawer / Rail */
  --pp-drawer-bg: #ffffff;
  --pp-drawer-active-bg: #f1f5f9;
  --pp-drawer-active-color: var(--pp-primary);
  
  /* Calendar */
  --pp-calendar-bg: #ffffff;
  --pp-calendar-selected-bg: var(--pp-primary);
  --pp-calendar-selected-text: #ffffff;
  --pp-calendar-sunday-color: var(--pp-danger-color);
  
  /* Dynamic Island */
  --pp-island-bg: #000000;
  --pp-island-color: #ffffff;
  --pp-island-accent: var(--pp-primary);
}</code></pre>

          <h4 style="margin-top: 24px; margin-bottom: 8px;">Dark Mode Customization</h4>
          <p class="custom-guide" style="margin-bottom: 12px;">If you apply a <code>.dark</code> class to your app's body, you can easily define dark mode specific variables:</p>
          <pre class="code-block" v-pre><code>.dark {
  --pp-background: #0f172a;
  --pp-background-alt: #1e293b;
  --pp-surface: #1e293b;
  --pp-text-color: #f8fafc;
  --pp-border-color: #334155;
  
  /* Component-specific dark overrides */
  --pp-bottom-sheet-bg: #1e293b;
  --pp-drawer-bg: #0f172a;
  --pp-calendar-bg: #1e293b;
}</code></pre>
        </div>
      </div>
<!-- FULL_SOURCE_CODE_START -->
    <div class="variant-group" style="margin-top: 40px;">
      <h3>Full Page Source Code</h3>
      <p class="custom-guide">Complete source code for this section.</p>
      <pre class="code-block" style="max-height: 500px; overflow-y: auto;" v-pre><code>&lt;template&gt;
&lt;div class="guide-section"&gt;
        &lt;h2&gt;Framework Usage Guide&lt;/h2&gt;
        &lt;p class="custom-guide"&gt;
          This library can be used as standard Vue components OR as framework-agnostic Web Components.
        &lt;/p&gt;
        
        &lt;div class="variant-group"&gt;
          &lt;h3&gt;1. Vue 3 (Default)&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Import the plugin and install it in your main app instance.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;import { createApp } from 'vue';
import App from './App.vue';
import UIFramework from '@phanna/ui-framework';
import '@phanna/ui-framework/style.css';

const app = createApp(App);
app.use(UIFramework);
app.mount('#app');&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;2. React (Using Web Components)&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Import the Web Component bundle and register it.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;import React from 'react';
import { registerWebComponents } from '@phanna/ui-framework/web-components';
import '@phanna/ui-framework/style.css';

// Register elements once
registerWebComponents();

export default function App() {
  return &amp;lt;pp-button variant="primary"&amp;gt;React Button&amp;lt;/pp-button&amp;gt;;
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;3. Angular (Using Web Components)&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Register components in `main.ts` and add `CUSTOM_ELEMENTS_SCHEMA` to your module.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;import { registerWebComponents } from '@phanna/ui-framework/web-components';
// Register elements
registerWebComponents();

// In your app.module.ts:
import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
@NgModule({
  schemas: [CUSTOM_ELEMENTS_SCHEMA]
})
export class AppModule { }&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;4. Plain HTML / Vanilla JS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;Load the script as a module and use the tags directly.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;html&amp;gt;
&amp;lt;head&amp;gt;
  &amp;lt;link rel="stylesheet" href="path/to/ui-framework/dist/style.css"&amp;gt;
  &amp;lt;script type="module"&amp;gt;
    import { registerWebComponents } from './path/to/wc/ui-framework-wc.es.js';
    registerWebComponents();
  &amp;lt;/script&amp;gt;
&amp;lt;/head&amp;gt;
&amp;lt;body&amp;gt;
  &amp;lt;pp-button variant="primary"&amp;gt;Native Button&amp;lt;/pp-button&amp;gt;
&amp;lt;/body&amp;gt;
&amp;lt;/html&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;5. Customizing CSS Variables&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the framework's design tokens globally by redefining CSS variables in your own stylesheet. We use the &lt;code&gt;--pp-&lt;/code&gt; prefix for all variables to prevent conflicts.&lt;/p&gt;
          
          &lt;h4 style="margin-top: 16px; margin-bottom: 8px;"&gt;Global Colors &amp; Surface&lt;/h4&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* main.css or App.vue &amp;lt;style&amp;gt; */
:root {
  /* Brand Colors */
  --pp-primary: #10b981;
  --pp-primary-variant: #047857; /* Darker primary for hover/active */
  --pp-primary-light: #d1fae5;
  
  /* Semantic Colors */
  --pp-danger-color: #ef4444;
  --pp-success-color: #10b981;
  --pp-warning-color: #f59e0b;

  /* Surfaces &amp; Backgrounds */
  --pp-background: #f8fafc;
  --pp-background-alt: #f1f5f9;
  --pp-surface: #ffffff;
  
  /* Typography &amp; Borders */
  --pp-text-color: #1e293b;
  --pp-border-color: #e2e8f0;
  --pp-border-radius: 8px;
}&lt;/code&gt;&lt;/pre&gt;

          &lt;h4 style="margin-top: 24px; margin-bottom: 8px;"&gt;Component-Specific Overrides&lt;/h4&gt;
          &lt;p class="custom-guide" style="margin-bottom: 12px;"&gt;Many components have their own specific variables that you can target if you only want to customize that component.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;:root {
  /* Bottom Sheet */
  --pp-bottom-sheet-bg: #ffffff;
  --pp-bottom-sheet-radius: 24px 24px 0 0;
  --pp-bottom-sheet-backdrop: rgba(0, 0, 0, 0.4);
  
  /* App Bar */
  --pp-app-bar-bg: #ffffff;
  --pp-app-bar-color: #1e293b;
  --pp-app-bar-height: 60px;
  
  /* Navigation Drawer / Rail */
  --pp-drawer-bg: #ffffff;
  --pp-drawer-active-bg: #f1f5f9;
  --pp-drawer-active-color: var(--pp-primary);
  
  /* Calendar */
  --pp-calendar-bg: #ffffff;
  --pp-calendar-selected-bg: var(--pp-primary);
  --pp-calendar-selected-text: #ffffff;
  --pp-calendar-sunday-color: var(--pp-danger-color);
  
  /* Dynamic Island */
  --pp-island-bg: #000000;
  --pp-island-color: #ffffff;
  --pp-island-accent: var(--pp-primary);
}&lt;/code&gt;&lt;/pre&gt;

          &lt;h4 style="margin-top: 24px; margin-bottom: 8px;"&gt;Dark Mode Customization&lt;/h4&gt;
          &lt;p class="custom-guide" style="margin-bottom: 12px;"&gt;If you apply a &lt;code&gt;.dark&lt;/code&gt; class to your app's body, you can easily define dark mode specific variables:&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;.dark {
  --pp-background: #0f172a;
  --pp-background-alt: #1e293b;
  --pp-surface: #1e293b;
  --pp-text-color: #f8fafc;
  --pp-border-color: #334155;
  
  /* Component-specific dark overrides */
  --pp-bottom-sheet-bg: #1e293b;
  --pp-drawer-bg: #0f172a;
  --pp-calendar-bg: #1e293b;
}&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;
      &lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref, computed } from 'vue';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
</script>
