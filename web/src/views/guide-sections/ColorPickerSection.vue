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
    <div class="variant-group">
      <h3>Color Picker Sheet</h3>
      <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPColorPickerSheet&gt;</code></p>
      <div class="demo-box">
        <PPButton @click="showColorPickerSheet = true">Open Color Sheet</PPButton>
        <PPColorPickerSheet 
          v-model="showColorPickerSheet"
          v-model:colorValue="color"
          title="Select a Theme Color"
        />
      </div>
      <pre class="code-block"><code>&lt;PPColorPickerSheet v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
    </div>

    <div class="variant-group">
      <h3>Color Picker Island Popup</h3>
      <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPColorPickerIsland&gt;</code></p>
      <div class="demo-box">
        <PPButton @click="showColorPickerIsland = true">Open Color Picker Island</PPButton>
        <PPColorPickerIsland 
          v-model="showColorPickerIsland"
          v-model:colorValue="color"
          title="Select a Theme Color"
        />
      </div>
      <pre class="code-block"><code>&lt;PPColorPickerIsland v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
    </div>

    <div class="variant-group">
      <h3>Color Picker Alert</h3>
      <p class="custom-guide"><strong>Component:</strong> <code>&lt;PPColorPickerAlert&gt;</code></p>
      <div class="demo-box">
        <PPButton @click="showColorPickerAlert = true">Open Color Alert</PPButton>
        <PPColorPickerAlert 
          v-model="showColorPickerAlert"
          v-model:colorValue="color"
          title="Select a Theme Color"
        />
      </div>
      <pre class="code-block"><code>&lt;PPColorPickerAlert v-model="isOpen" v-model:colorValue="color" title="Select a Theme Color" /&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPColorPicker, PPButton, PPColorPickerSheet, PPColorPickerIsland, PPColorPickerAlert } from '@phanna/ui-framework';

const color = ref('#3880ff');
const showColorPickerSheet = ref(false);
const showColorPickerIsland = ref(false);
const showColorPickerAlert = ref(false);
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
