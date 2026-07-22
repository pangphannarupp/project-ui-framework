<template>
  <div class="pp-button-group" :class="{ 'pp-button-group--vertical': vertical }">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  vertical?: boolean;
}>();
</script>

<style scoped>
.pp-button-group {
  display: inline-flex;
  align-items: center;
}

.pp-button-group--vertical {
  flex-direction: column;
  align-items: stretch;
}

/* Horizontal Group */
.pp-button-group:not(.pp-button-group--vertical) :deep(.pp-button) {
  border-radius: 0;
  margin-left: -1px; /* Avoid double borders for outline buttons */
}

.pp-button-group:not(.pp-button-group--vertical) :deep(.pp-button:first-child) {
  border-top-left-radius: 12px;
  border-bottom-left-radius: 12px;
  margin-left: 0;
}

.pp-button-group:not(.pp-button-group--vertical) :deep(.pp-button:last-child) {
  border-top-right-radius: 12px;
  border-bottom-right-radius: 12px;
}

/* Vertical Group */
.pp-button-group--vertical :deep(.pp-button) {
  border-radius: 0;
  margin-top: -1px;
}

.pp-button-group--vertical :deep(.pp-button:first-child) {
  border-top-left-radius: 12px;
  border-top-right-radius: 12px;
  margin-top: 0;
}

.pp-button-group--vertical :deep(.pp-button:last-child) {
  border-bottom-left-radius: 12px;
  border-bottom-right-radius: 12px;
}

/* Hover states stacking */
.pp-button-group :deep(.pp-button:hover),
.pp-button-group :deep(.pp-button:focus),
.pp-button-group :deep(.pp-button:active) {
  z-index: 1;
}
</style>
