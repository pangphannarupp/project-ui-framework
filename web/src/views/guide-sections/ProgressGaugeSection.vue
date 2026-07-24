<template>
  <div class="guide-section">
    <h2>Progress Gauge</h2>
    <p>A circular gauge to display progress or completion percentage.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box" style="display: flex; flex-direction: column; gap: 24px;">
      <div style="display: flex; gap: 32px; flex-wrap: wrap;">
        <PPProgressGauge :value="25" :size="120" color="#3880ff" />
        <PPProgressGauge :value="75" :size="120" color="#2dd36f" />
        <PPProgressGauge :value="100" :size="120" color="#eb445a" />
      </div>
      <pre class="code-block" style="margin: 0;"><code>&lt;PPProgressGauge :value="25" :size="120" color="#3880ff" /&gt;
&lt;PPProgressGauge :value="75" :size="120" color="#2dd36f" /&gt;
&lt;PPProgressGauge :value="100" :size="120" color="#eb445a" /&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPProgressGauge } from '@phanna/ui-framework';
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
