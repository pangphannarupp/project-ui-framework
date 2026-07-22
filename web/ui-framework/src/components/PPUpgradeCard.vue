<template>
  <div class="pp-upgrade-card">
    <div class="item-icon bg-blue">
      <slot name="icon"></slot>
    </div>
    <div class="item-text">
      <h3>{{ title }}</h3>
      <p v-if="description">{{ description }}</p>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  title: { type: String, required: true },
  description: { type: String, default: '' }
});
</script>

<style scoped>
.pp-upgrade-card {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  margin-bottom: 8px;
}

.item-icon {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.item-icon.bg-blue {
  background-color: #3b63cc;
  color: white;
}

:deep(.item-icon svg) {
  width: 20px;
  height: 20px;
}

.item-text h3 {
  font-size: 15px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  margin: 2px 0 4px 0;
}

.item-text p {
  font-size: 13px;
  color: #555;
  margin: 0;
  line-height: 1.4;
}
</style>
