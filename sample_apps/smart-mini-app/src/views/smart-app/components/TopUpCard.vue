<template>
  <div class="card">
    <h3 class="card-title">Top up for your friend & family?</h3>
    <div class="input-group">
      <PPTextField
        label="Enter ID Number"
        placeholder="e.g 9620xx"
        variant="filled"
        icon-right="person-outline"
        style="--pp-primary-variant: var(--smart-green);"
      />
    </div>
    <PPButton variant="primary" block disabled style="--pp-primary-variant: var(--smart-green);">↗ Top up now</PPButton>
  </div>
</template>

<script setup lang="ts">
import { PPTextField, PPButton } from '@phanna/ui-framework';
</script>

<style scoped>
.card {
  background: white;
  border-radius: 12px;
  padding: 1rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.card-title {
  margin: 0 0 1rem 0;
  font-size: 1rem;
  color: var(--text-main);
}

.input-group {
  margin-bottom: 1rem;
}
</style>
