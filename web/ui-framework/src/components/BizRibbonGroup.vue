<template>
  <div class="biz-ribbon-group">
    <div class="biz-ribbon-group-content">
      <slot></slot>
    </div>
    <div class="biz-ribbon-group-title">
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
.biz-ribbon-group {
  display: flex;
  flex-direction: column;
  border-right: 1px solid #d1d5db;
  padding-right: 8px;
  position: relative;
  min-height: 80px;
}

.biz-ribbon-group:last-child {
  border-right: none;
}

.biz-ribbon-group-content {
  display: flex;
  flex-grow: 1;
  gap: 4px;
  align-items: stretch;
  padding-bottom: 20px; /* Space for the title */
}

.biz-ribbon-group-title {
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
