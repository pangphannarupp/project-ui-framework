<template>
  <div class="my-list">
    <div v-for="(item, index) in items" :key="index" class="my-list-item">
      {{ item }}
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps<{
  items: string[]
}>()
</script>

<style scoped>
.my-list {
  border: 1px solid #ddd;
  border-radius: 8px;
  overflow: hidden;
  background: white;
  box-shadow: 0 4px 6px rgba(0,0,0,0.1);
  margin: 16px 0;
}
.my-list-item {
  padding: 12px 16px;
  border-bottom: 1px solid #eee;
  color: #333;
  font-family: sans-serif;
  transition: background-color 0.2s;
}
.my-list-item:last-child {
  border-bottom: none;
}
.my-list-item:hover {
  background-color: #f9f9f9;
}
</style>
