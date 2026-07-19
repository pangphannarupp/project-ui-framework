<template>
  <div class="guide-section">
    <h2>Select</h2>
    <p>A customizable dropdown select component for choosing from a list of options.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <BizSelect
        v-model="selectedValue"
        :options="options"
        placeholder="Select an option"
      />
      <div style="margin-top: 16px; font-family: monospace;">Selected: {{ selectedValue || 'None' }}</div>
    </div>
    <pre class="code-block"><code>&lt;BizSelect v-model="selectedValue" :options="options" placeholder="Select an option" /&gt;</code></pre>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { BizSelect } from '@phanna/ui-framework';

const selectedValue = ref('');
const options = [
  { label: 'Option 1', value: 'opt1' },
  { label: 'Option 2', value: 'opt2' },
  { label: 'Option 3', value: 'opt3' }
];
</script>

<style scoped>
.guide-section {
  display: flex;
  flex-direction: column;
  gap: 24px;
}
.demo-box {
  border: 1px solid #e5e7eb;
  border-radius: 8px;
  padding: 24px;
  background: #f9fafb;
}
</style>
