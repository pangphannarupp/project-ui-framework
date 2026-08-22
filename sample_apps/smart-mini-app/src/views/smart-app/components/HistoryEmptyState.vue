<template>
  <div class="empty-state">
    <div class="icon-wrapper">
      <svg viewBox="0 0 24 24" width="64" height="64" stroke="#68b49f" stroke-width="2" fill="none">
        <path d="M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8"></path>
        <path d="M3 3v5h5"></path>
        <path d="M12 7v5l4 2"></path>
      </svg>
    </div>
    <h3 class="title">Looks like it's empty for now.</h3>
    <p class="subtitle">You haven't done anything yet. <br>let's get started!</p>
  </div>
</template>

<script setup lang="ts">
</script>

<style scoped>
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  margin-top: 2rem;
}

.icon-wrapper {
  margin-bottom: 1rem;
  background-color: #e6f4f1;
  border-radius: 50%;
  padding: 1rem;
}

.title {
  color: var(--smart-green);
  margin: 0 0 0.5rem 0;
  font-size: 1.1rem;
}

.subtitle {
  color: var(--text-secondary);
  font-size: 0.9rem;
  margin: 0;
  line-height: 1.5;
}
</style>
