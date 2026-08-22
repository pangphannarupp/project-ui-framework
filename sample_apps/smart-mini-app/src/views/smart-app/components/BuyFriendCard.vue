<template>
  <div class="card buy-friend-card">
    <div class="card-content">
      <h3>Buy for your friend & Family?</h3>
      <PPButton variant="primary" style="--pp-primary-variant: var(--smart-green);">
        <span class="icon">🛒</span> Buy new eSIM
      </PPButton>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPButton } from '@phanna/ui-framework';
</script>

<style scoped>
.card {
  background: white;
  border-radius: 12px;
  padding: 1rem;
  box-shadow: 0 2px 8px rgba(0,0,0,0.05);
}

.buy-friend-card {
  border-radius: 16px;
}

.buy-friend-card .card-content {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.buy-friend-card h3 {
  margin: 0;
  font-size: 1rem;
  max-width: 60%;
  color: var(--text-main);
}
</style>
