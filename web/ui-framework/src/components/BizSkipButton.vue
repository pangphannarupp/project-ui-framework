<template>
  <button class="biz-skip-btn" @click="$emit('click')">
    <slot>Got it (Skip)</slot>
  </button>
</template>

<script setup lang="ts">
defineEmits(['click']);
</script>

<style scoped>
.biz-skip-btn {
  background-color: white;
  border: 1px solid #eaeaea;
  color: var(--biz-primary-variant, #1a2a5e);
  font-size: 15px;
  font-weight: 600;
  padding: 14px;
  border-radius: 12px;
  width: 100%;
  cursor: pointer;
  transition: background-color 0.2s;
}

.biz-skip-btn:active {
  background-color: #f9f9f9;
}
</style>
