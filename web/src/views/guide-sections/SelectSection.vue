<template>
  <div class="guide-section">
    <h2>Select</h2>
    <p>A customizable dropdown select component for choosing from a list of options.</p>

    <div class="variant-group">
      <h3>Variants</h3>
      <div class="demo-box" style="display: flex; flex-direction: column; gap: 24px;">
        <PPSelect
          v-model="valOutlined"
          :options="options"
          label="Outlined (Default)"
          placeholder="Select an option"
        />
        <PPSelect
          v-model="valFilled"
          :options="options"
          variant="filled"
          label="Filled"
          placeholder="Select an option"
        />
        <PPSelect
          v-model="valFlushed"
          :options="options"
          variant="flushed"
          label="Flushed"
          placeholder="Select an option"
        />
        <PPSelect
          v-model="valSoft"
          :options="options"
          variant="soft"
          label="Soft (Tonal)"
          placeholder="Select an option"
        />
      </div>
      <pre class="code-block"><code>&lt;PPSelect variant="outlined" ... /&gt;
&lt;PPSelect variant="filled" ... /&gt;
&lt;PPSelect variant="flushed" ... /&gt;
&lt;PPSelect variant="soft" ... /&gt;</code></pre>
    </div>

    <div class="variant-group">
      <h3>States & Validation</h3>
      <div class="demo-box" style="display: flex; flex-direction: column; gap: 24px;">
        <PPSelect
          v-model="valError"
          :options="options"
          label="Error State"
          error="Please select a valid option."
          placeholder="Invalid selection"
        />
        <PPSelect
          v-model="valDisabled"
          :options="options"
          label="Disabled State"
          disabled
          placeholder="Cannot select"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPSelect } from '@phanna/ui-framework';

const valOutlined = ref('');
const valFilled = ref('');
const valFlushed = ref('');
const valSoft = ref('');
const valError = ref('');
const valDisabled = ref('');

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
