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
          <pre class="code-block"><code>&lt;PPButton variant="gradient"&gt;Gradient&lt;/PPButton&gt;
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
          <pre class="code-block"><code>&lt;PPButton size="small"&gt;Small&lt;/PPButton&gt;
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
          <pre class="code-block"><code>&lt;PPButton variant="primary"&gt;
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
          <pre class="code-block"><code>&lt;PPButton loading&gt;Saving...&lt;/PPButton&gt;
&lt;PPButton disabled&gt;Disabled&lt;/PPButton&gt;</code></pre>
        </div>

        <div class="variant-group">
          <h3>Block Buttons</h3>
          <div class="component-demo" style="display: flex; flex-direction: column; gap: 12px; padding: 24px;">
            <PPButton variant="primary" block>Primary Block</PPButton>
            <PPButton variant="secondary" block>Secondary Block</PPButton>
          </div>
          <pre class="code-block"><code>&lt;PPButton variant="primary" block&gt;Block Button&lt;/PPButton&gt;</code></pre>
        </div>
      </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

import { PPButton } from '@phanna/ui-framework';
</script>
