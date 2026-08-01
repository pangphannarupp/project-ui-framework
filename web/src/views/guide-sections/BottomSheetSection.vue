<template>
  <div class="component-section">
    <h2>Bottom Sheet</h2>
    <p>A modal that slides up from the bottom of the screen, typically used for mobile layouts to present actions or information.</p>

    <div class="demo-box" style="margin-top: 32px; display: flex; gap: 16px; align-items: center; justify-content: center; height: 160px; background: #f8fafc; border-radius: 8px;">
      <PPButton @click="showDefault = true">Default Bottom Sheet</PPButton>
      <PPButton variant="secondary" @click="showBlur = true">Blur Backdrop</PPButton>
    </div>

    <!-- Default Bottom Sheet -->
    <PPBottomSheet v-model="showDefault" title="Settings">
      <div style="padding: 16px;">
        <p style="margin-bottom: 24px; color: #475569;">Configure your preferences below.</p>
        <div style="display: flex; flex-direction: column; gap: 12px;">
          <PPButton variant="outline" block @click="showDefault = false">Option 1</PPButton>
          <PPButton variant="outline" block @click="showDefault = false">Option 2</PPButton>
        </div>
      </div>
    </PPBottomSheet>

    <!-- Blur Backdrop Bottom Sheet -->
    <PPBottomSheet v-model="showBlur" backdropType="blur">
      <div style="padding: 24px; text-align: center;">
        <h3 style="margin-top: 0; color: #1e293b;">Blurred Background</h3>
        <p style="color: #64748b; margin-bottom: 32px;">This sheet uses a blurred backdrop for a frosted glass effect.</p>
        <PPButton block @click="showBlur = false">Close</PPButton>
      </div>
    </PPBottomSheet>

    <!-- Usage Section -->
    <div style="margin-top: 40px;">
      <h3>Usage Example</h3>
      <pre class="code-block" style="background: #1e293b; color: #e2e8f0; padding: 16px; border-radius: 8px; overflow-x: auto;"><code>&lt;template&gt;
  &lt;PPButton @click="isOpen = true"&gt;Open Sheet&lt;/PPButton&gt;

  &lt;PPBottomSheet v-model="isOpen" backdropType="blur"&gt;
    &lt;div style="padding: 24px;"&gt;
      &lt;h3&gt;Sheet Content&lt;/h3&gt;
      &lt;p&gt;This is a sliding bottom sheet.&lt;/p&gt;
    &lt;/div&gt;
  &lt;/PPBottomSheet&gt;
&lt;/template&gt;

&lt;script setup&gt;
import { ref } from 'vue';
import { PPBottomSheet, PPButton } from '@phanna/ui-framework';

const isOpen = ref(false);
&lt;/script&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPBottomSheet, PPButton } from '@phanna/ui-framework';

const showDefault = ref(false);
const showBlur = ref(false);
</script>
