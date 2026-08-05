<template>
<div class="guide-section">
        <h2>Button Component</h2>
        <p class="custom-guide">A versatile button component supporting multiple variants, sizes, icons, and loading states.</p>

        <div class="variant-group">
          <h3>Variants</h3>
          <div class="component-demo" style="display: flex; flex-wrap: wrap; gap: 12px; padding: 24px;">
            <PPButton variant="primary">Primary</PPButton>
            <PPButton variant="secondary">Secondary</PPButton>
            <PPButton variant="success">Success</PPButton>
            <PPButton variant="danger">Danger</PPButton>
            <PPButton variant="outline">Outline</PPButton>
            <PPButton variant="outline-danger">Outline Danger</PPButton>
            <PPButton variant="ghost">Ghost</PPButton>
            
            <PPButton variant="gradient">Gradient</PPButton>
            <PPButton variant="elevated">Elevated (3D)</PPButton>
            <PPButton variant="soft">Soft (Tonal)</PPButton>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPButton variant="gradient"&gt;Gradient&lt;/PPButton&gt;
&lt;PPButton variant="elevated"&gt;Elevated&lt;/PPButton&gt;
&lt;PPButton variant="soft"&gt;Soft&lt;/PPButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Sizes & Shapes</h3>
          <div class="component-demo" style="display: flex; flex-wrap: wrap; align-items: center; gap: 16px; padding: 24px;">
            <PPButton variant="primary" size="small">Small</PPButton>
            <PPButton variant="primary" size="medium">Medium</PPButton>
            <PPButton variant="primary" size="large">Large</PPButton>
            <PPButton variant="primary" rounded>Rounded</PPButton>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPButton size="small"&gt;Small&lt;/PPButton&gt;
&lt;PPButton size="large" rounded&gt;Large Rounded&lt;/PPButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Icons</h3>
          <div class="component-demo" style="display: flex; flex-wrap: wrap; gap: 12px; padding: 24px;">
            <PPButton variant="primary">
              <template #iconLeft>
                <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
              </template>
              Send
            </PPButton>
            <PPButton variant="outline">
              Settings
              <template #iconRight>
                <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="3"></circle><path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"></path></svg>
              </template>
            </PPButton>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPButton variant="primary"&gt;
  &lt;template #iconLeft&gt;
    &lt;svg&gt;...&lt;/svg&gt;
  &lt;/template&gt;
  Send
&lt;/PPButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>States</h3>
          <div class="component-demo" style="display: flex; flex-wrap: wrap; gap: 12px; padding: 24px;">
            <PPButton variant="primary" loading>Saving...</PPButton>
            <PPButton variant="success" loading>Verifying</PPButton>
            <PPButton variant="outline" disabled>Disabled</PPButton>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPButton loading&gt;Saving...&lt;/PPButton&gt;
&lt;PPButton disabled&gt;Disabled&lt;/PPButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Block Buttons</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 12px; padding: 24px;">
            <PPButton variant="primary" block>Primary Block</PPButton>
            <PPButton variant="secondary" block>Secondary Block</PPButton>
          </div>
          <pre class="code-block" v-pre><code>&lt;PPButton variant="primary" block&gt;Block Button&lt;/PPButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Customizing CSS</h3>
          <p class="custom-guide">You can override the button's appearance globally via CSS variables or by targeting the <code>.pp-btn</code> class and its specific variant classes like <code>.pp-btn-primary</code>.</p>
          <pre class="code-block" v-pre><code>/* Override globally for all primary buttons */
:root {
  --pp-primary: #8b5cf6; /* Changes primary button background */
  --pp-primary-variant: #7c3aed; /* Changes hover state */
}

/* Or target specific buttons using scoped CSS or custom classes */
.my-custom-btn {
  background-color: #ff5722 !important;
  border-radius: 99px !important;
  box-shadow: 0 4px 6px rgba(255, 87, 34, 0.3);
}</code></pre>
          <div class="component-demo" style="display: flex; gap: 12px; padding: 24px;">
            <PPButton class="my-custom-btn" style="background-color: #ff5722; color: white; border-radius: 99px; border: none; padding: 12px 24px; cursor: pointer;">
              Custom Styled Button
            </PPButton>
          </div>
        </div>
      </div>
<!-- FULL_SOURCE_CODE_START -->
    <div class="variant-group" style="margin-top: 40px;">
      <h3>Full Page Source Code</h3>
      <p class="custom-guide">Complete source code for this section.</p>
      <pre class="code-block" style="max-height: 500px; overflow-y: auto;" v-pre><code>&lt;template&gt;
&lt;div class="guide-section"&gt;
        &lt;h2&gt;Button Component&lt;/h2&gt;
        &lt;p class="custom-guide"&gt;A versatile button component supporting multiple variants, sizes, icons, and loading states.&lt;/p&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Variants&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-wrap: wrap; gap: 12px; padding: 24px;"&gt;
            &lt;PPButton variant="primary"&gt;Primary&lt;/PPButton&gt;
            &lt;PPButton variant="secondary"&gt;Secondary&lt;/PPButton&gt;
            &lt;PPButton variant="success"&gt;Success&lt;/PPButton&gt;
            &lt;PPButton variant="danger"&gt;Danger&lt;/PPButton&gt;
            &lt;PPButton variant="outline"&gt;Outline&lt;/PPButton&gt;
            &lt;PPButton variant="outline-danger"&gt;Outline Danger&lt;/PPButton&gt;
            &lt;PPButton variant="ghost"&gt;Ghost&lt;/PPButton&gt;
            
            &lt;PPButton variant="gradient"&gt;Gradient&lt;/PPButton&gt;
            &lt;PPButton variant="elevated"&gt;Elevated (3D)&lt;/PPButton&gt;
            &lt;PPButton variant="soft"&gt;Soft (Tonal)&lt;/PPButton&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPButton variant="gradient"&amp;gt;Gradient&amp;lt;/PPButton&amp;gt;
&amp;lt;PPButton variant="elevated"&amp;gt;Elevated&amp;lt;/PPButton&amp;gt;
&amp;lt;PPButton variant="soft"&amp;gt;Soft&amp;lt;/PPButton&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Sizes &amp; Shapes&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-wrap: wrap; align-items: center; gap: 16px; padding: 24px;"&gt;
            &lt;PPButton variant="primary" size="small"&gt;Small&lt;/PPButton&gt;
            &lt;PPButton variant="primary" size="medium"&gt;Medium&lt;/PPButton&gt;
            &lt;PPButton variant="primary" size="large"&gt;Large&lt;/PPButton&gt;
            &lt;PPButton variant="primary" rounded&gt;Rounded&lt;/PPButton&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPButton size="small"&amp;gt;Small&amp;lt;/PPButton&amp;gt;
&amp;lt;PPButton size="large" rounded&amp;gt;Large Rounded&amp;lt;/PPButton&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Icons&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-wrap: wrap; gap: 12px; padding: 24px;"&gt;
            &lt;PPButton variant="primary"&gt;
              &lt;template #iconLeft&gt;
                &lt;svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"&gt;&lt;path d="M5 12h14M12 5l7 7-7 7"/&gt;&lt;/svg&gt;
              &lt;/template&gt;
              Send
            &lt;/PPButton&gt;
            &lt;PPButton variant="outline"&gt;
              Settings
              &lt;template #iconRight&gt;
                &lt;svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"&gt;&lt;circle cx="12" cy="12" r="3"&gt;&lt;/circle&gt;&lt;path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z"&gt;&lt;/path&gt;&lt;/svg&gt;
              &lt;/template&gt;
            &lt;/PPButton&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPButton variant="primary"&amp;gt;
  &amp;lt;template #iconLeft&amp;gt;
    &amp;lt;svg&amp;gt;...&amp;lt;/svg&amp;gt;
  &amp;lt;/template&amp;gt;
  Send
&amp;lt;/PPButton&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;States&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-wrap: wrap; gap: 12px; padding: 24px;"&gt;
            &lt;PPButton variant="primary" loading&gt;Saving...&lt;/PPButton&gt;
            &lt;PPButton variant="success" loading&gt;Verifying&lt;/PPButton&gt;
            &lt;PPButton variant="outline" disabled&gt;Disabled&lt;/PPButton&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPButton loading&amp;gt;Saving...&amp;lt;/PPButton&amp;gt;
&amp;lt;PPButton disabled&amp;gt;Disabled&amp;lt;/PPButton&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Block Buttons&lt;/h3&gt;
          &lt;div class="component-demo" style="display: flex; flex-direction: column; gap: 12px; padding: 24px;"&gt;
            &lt;PPButton variant="primary" block&gt;Primary Block&lt;/PPButton&gt;
            &lt;PPButton variant="secondary" block&gt;Secondary Block&lt;/PPButton&gt;
          &lt;/div&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;&amp;lt;PPButton variant="primary" block&amp;gt;Block Button&amp;lt;/PPButton&amp;gt;&lt;/code&gt;&lt;/pre&gt;
        &lt;/div&gt;

        &lt;div class="variant-group"&gt;
          &lt;h3&gt;Customizing CSS&lt;/h3&gt;
          &lt;p class="custom-guide"&gt;You can override the button's appearance globally via CSS variables or by targeting the &lt;code&gt;.pp-btn&lt;/code&gt; class and its specific variant classes like &lt;code&gt;.pp-btn-primary&lt;/code&gt;.&lt;/p&gt;
          &lt;pre class="code-block"&gt;&lt;code&gt;/* Override globally for all primary buttons */
:root {
  --pp-primary: #8b5cf6; /* Changes primary button background */
  --pp-primary-variant: #7c3aed; /* Changes hover state */
}

/* Or target specific buttons using scoped CSS or custom classes */
.my-custom-btn {
  background-color: #ff5722 !important;
  border-radius: 99px !important;
  box-shadow: 0 4px 6px rgba(255, 87, 34, 0.3);
}&lt;/code&gt;&lt;/pre&gt;
          &lt;div class="component-demo" style="display: flex; gap: 12px; padding: 24px;"&gt;
            &lt;PPButton class="my-custom-btn" style="background-color: #ff5722; color: white; border-radius: 99px; border: none; padding: 12px 24px; cursor: pointer;"&gt;
              Custom Styled Button
            &lt;/PPButton&gt;
          &lt;/div&gt;
        &lt;/div&gt;
      &lt;/div&gt;
&lt;/template&gt;

&lt;script setup lang="ts"&gt;
import { ref, computed } from 'vue';

import { PPButton } from '@phanna/ui-framework';
&lt;/script&gt;
</code></pre>
    </div>
<!-- FULL_SOURCE_CODE_END -->
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPButton } from '@phanna/ui-framework';
</script>
