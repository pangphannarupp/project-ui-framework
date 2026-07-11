<template>
  <div class="biz-button-group" :class="{ 'biz-button-group--vertical': vertical }">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  vertical?: boolean;
}>();
</script>

<style scoped>
.biz-button-group {
  display: inline-flex;
  align-items: center;
}

.biz-button-group--vertical {
  flex-direction: column;
  align-items: stretch;
}

/* Horizontal Group */
.biz-button-group:not(.biz-button-group--vertical) :deep(.biz-button) {
  border-radius: 0;
  margin-left: -1px; /* Avoid double borders for outline buttons */
}

.biz-button-group:not(.biz-button-group--vertical) :deep(.biz-button:first-child) {
  border-top-left-radius: 12px;
  border-bottom-left-radius: 12px;
  margin-left: 0;
}

.biz-button-group:not(.biz-button-group--vertical) :deep(.biz-button:last-child) {
  border-top-right-radius: 12px;
  border-bottom-right-radius: 12px;
}

/* Vertical Group */
.biz-button-group--vertical :deep(.biz-button) {
  border-radius: 0;
  margin-top: -1px;
}

.biz-button-group--vertical :deep(.biz-button:first-child) {
  border-top-left-radius: 12px;
  border-top-right-radius: 12px;
  margin-top: 0;
}

.biz-button-group--vertical :deep(.biz-button:last-child) {
  border-bottom-left-radius: 12px;
  border-bottom-right-radius: 12px;
}

/* Hover states stacking */
.biz-button-group :deep(.biz-button:hover),
.biz-button-group :deep(.biz-button:focus),
.biz-button-group :deep(.biz-button:active) {
  z-index: 1;
}
</style>
