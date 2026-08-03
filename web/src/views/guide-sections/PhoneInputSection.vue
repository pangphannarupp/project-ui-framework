<template>
  <div class="guide-section">
    <h2>Phone Input</h2>
    <p>A specialized input component for telephone numbers with country code support.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <PPPhoneInput v-model="phone" placeholder="Enter phone number" />
      <div style="margin-top: 16px; font-family: monospace;">Value: {{ phone }}</div>
    </div>
    <pre class="code-block"><code>&lt;PPPhoneInput v-model="phone" placeholder="Enter phone number" /&gt;</code></pre>

    <h3 style="margin-top: 24px;">Formatted Input</h3>
    <p class="guide-desc">Use the <code>format</code> prop to automatically format the number as the user types (e.g. <code>### ### ###</code> or <code>### ### ####</code>).</p>
    <div class="demo-box">
      <PPPhoneInput v-model="formattedPhone" format="### ### ###" placeholder="e.g. 012 345 678" />
      <div style="margin-top: 16px; font-family: monospace;">Value: {{ formattedPhone }}</div>
    </div>
    <pre class="code-block"><code>&lt;PPPhoneInput v-model="phone" format="### ### ###" /&gt;</code></pre>

    <h3 style="margin-top: 24px;">Variants</h3>
    <div class="demo-box" style="display: flex; flex-direction: column; gap: 16px;">
      <PPPhoneInput v-model="phone" variant="outline" placeholder="Outline (Default)" />
      <PPPhoneInput v-model="phone" variant="filled" placeholder="Filled" />
      <PPPhoneInput v-model="phone" variant="underlined" placeholder="Underlined" />
    </div>
    
    <h3 style="margin-top: 24px;">Sizes & Shapes</h3>
    <div class="demo-box" style="display: flex; flex-direction: column; gap: 16px;">
      <PPPhoneInput v-model="phone" size="sm" placeholder="Small (sm)" />
      <PPPhoneInput v-model="phone" size="md" placeholder="Medium (md) - Default" />
      <PPPhoneInput v-model="phone" size="lg" placeholder="Large (lg)" />
      <div style="margin-top: 8px;"></div>
      <PPPhoneInput v-model="phone" rounded placeholder="Rounded Pill Style" />
      <PPPhoneInput v-model="phone" variant="filled" rounded placeholder="Rounded Filled" />
    </div>
    <pre class="code-block"><code>&lt;PPPhoneInput variant="outline|filled|underlined" size="sm|md|lg" rounded /&gt;</code></pre>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPPhoneInput } from '@phanna/ui-framework';

const phone = ref('');
const formattedPhone = ref('');
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
