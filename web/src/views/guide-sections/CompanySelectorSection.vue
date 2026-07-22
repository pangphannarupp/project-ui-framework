<template>
  <div class="guide-section">
    <h2>Company Selector</h2>
    <p>A specialized dropdown for selecting companies or business entities.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <PPCompanySelector v-model="company" :options="companies" />
      <div style="margin-top: 16px; font-family: monospace;">Selected: {{ company }}</div>
    </div>
    <pre class="code-block"><code>&lt;PPCompanySelector v-model="company" :options="companies" /&gt;</code></pre>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPCompanySelector } from '@phanna/ui-framework';

const company = ref('');
const companies = [
  { id: '1', name: 'Acme Corp' },
  { id: '2', name: 'Stark Industries' },
  { id: '3', name: 'Wayne Enterprises' }
];
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
