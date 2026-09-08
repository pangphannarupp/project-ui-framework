<template>
  <div class="settings-section glass-panel">
    <div class="section-header" v-if="title">
      <h3 class="section-title">{{ title }}</h3>
      <span class="section-subtitle" v-if="subtitle">{{ subtitle }}</span>
    </div>
    <div class="section-content">
      <slot></slot>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  title?: string
  subtitle?: string
}>()
</script>

<style scoped>
.settings-section {
  border-radius: var(--radius-lg);
  border: 1px solid var(--border-color);
  padding: 20px;
  margin-bottom: 20px;
}

.section-header {
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid var(--border-color);
}

.section-title {
  font-size: 16px;
  font-weight: 700;
  color: var(--text-main);
  margin-bottom: 2px;
}

.section-subtitle {
  font-size: 12px;
  color: var(--text-muted);
}

.section-content {
  display: flex;
  flex-direction: column;
  gap: 14px;
}
</style>
