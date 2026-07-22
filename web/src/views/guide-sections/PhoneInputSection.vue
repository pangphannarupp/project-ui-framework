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
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPPhoneInput } from '@phanna/ui-framework';

const phone = ref('');
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
