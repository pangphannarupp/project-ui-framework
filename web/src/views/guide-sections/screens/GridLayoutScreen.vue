<template>
  <div style="height: 600px; width: 100%; max-width: 400px; border: 1px solid var(--pp-border, #e2e8f0); border-radius: 12px; overflow: hidden; position: relative; margin: 0 auto; display: flex; flex-direction: column;">
    <PPAppBar title="Gallery" />
    
    <div style="flex: 1; overflow-y: auto; padding: 2px;">
      <div style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 2px;">
        <div v-for="i in 18" :key="i" style="aspect-ratio: 1; position: relative; background: #e2e8f0; overflow: hidden;">
          <img :src="`https://picsum.photos/200/200?random=${i + 10}`" style="width: 100%; height: 100%; object-fit: cover;" alt="Gallery Image" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPAppBar } from '@phanna/ui-framework';
</script>
