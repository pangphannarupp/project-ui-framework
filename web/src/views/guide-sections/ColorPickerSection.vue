<template>
  <div class="guide-section">
    <h2>Color Picker</h2>
    <p>A color picker component that allows users to select colors using HEX, RGB, or HSL.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <PPColorPicker v-model="color" />
      <div style="margin-top: 16px;">
        Selected Color: <span :style="{ color: color, fontWeight: 'bold' }">{{ color }}</span>
      </div>
    </div>
    <pre class="code-block"><code>&lt;PPColorPicker v-model="color" /&gt;</code></pre>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPColorPicker } from '@phanna/ui-framework';

const color = ref('#3880ff');
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
