<template>
  <div class="guide-section">
    <h2>No Result</h2>
    <p>An empty state component to display when a search or filter yields no results.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <div style="margin-bottom: 24px;">
        <PPNoResult 
          title="No matches found" 
          description="Try changing your search or filter."
        />
      </div>
      <pre class="code-block" style="margin: 0;"><code>&lt;PPNoResult 
  title="No matches found" 
  description="Try changing your search or filter."
/&gt;</code></pre>
    </div>

    <h3 style="margin-top: 32px;">Custom Icon</h3>
    <div class="demo-box">
      <div style="margin-bottom: 24px;">
        <PPNoResult 
          title="No connectivity" 
          subtitle="Please check your internet connection."
          :icon="wifiOutline"
        />
      </div>
      <pre class="code-block" style="margin: 0;"><code>&lt;PPNoResult 
  title="No connectivity" 
  subtitle="Please check your internet connection."
  :icon="wifiOutline"
/&gt;</code></pre>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPNoResult } from '@phanna/ui-framework';
import { wifiOutline } from 'ionicons/icons';
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
