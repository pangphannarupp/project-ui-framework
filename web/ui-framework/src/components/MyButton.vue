<template>
  <button class="my-btn" @click="$emit('click')">
    <slot></slot>
  </button>
</template>

<script setup lang="ts">
defineEmits(['click'])
</script>

<style scoped>
.my-btn {
  padding: 8px 16px;
  border-radius: 4px;
  background-color: #007bff;
  color: white;
  border: none;
  cursor: pointer;
  font-weight: bold;
  transition: background-color 0.2s;
}

.my-btn:hover {
  background-color: #0056b3;
}
</style>
