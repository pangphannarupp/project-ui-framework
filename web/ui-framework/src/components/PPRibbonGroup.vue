<template>
  <div class="pp-ribbon-group">
    <div class="pp-ribbon-group-content">
      <slot></slot>
    </div>
    <div class="pp-ribbon-group-title">
      {{ title }}
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  title: string;
}>();
</script>

<style scoped>
.pp-ribbon-group {
  display: flex;
  flex-direction: column;
  border-right: 1px solid #d1d5db;
  padding-right: 8px;
  position: relative;
  min-height: 80px;
}

.pp-ribbon-group:last-child {
  border-right: none;
}

.pp-ribbon-group-content {
  display: flex;
  flex-grow: 1;
  gap: 4px;
  align-items: stretch;
  padding-bottom: 20px; /* Space for the title */
}

.pp-ribbon-group-title {
  position: absolute;
  bottom: 2px;
  left: 0;
  right: 0;
  text-align: center;
  font-size: 11px;
  color: #6b7280;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  padding: 0 4px;
}
</style>
