<template>
  <div class="guide-section">
    <h2>No Result</h2>
    <p>An empty state component to display when a search or filter yields no results.</p>

    <h3>Basic Usage</h3>
    <div class="demo-box">
      <PPNoResult 
        title="No matches found" 
        description="Try adjusting your filters or search query."
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPNoResult } from '@phanna/ui-framework';
</script>

<style scoped>
.guide-section { display: flex; flex-direction: column; gap: 24px; }
.demo-box { border: 1px solid #e5e7eb; border-radius: 8px; padding: 24px; background: #f9fafb; }
</style>
