<script setup lang="ts">
import { RouterView } from 'vue-router'
</script>

<template>
  <div class="portal-root">
    <RouterView />
  </div>
</template>

<style scoped>
.portal-root {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
}
</style>
