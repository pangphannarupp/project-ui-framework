<template>
  <div class="pp-verification-card">
    <div class="item-icon-small">
      <slot name="icon"></slot>
    </div>
    <div class="item-text">
      <h4><slot name="title">{{ title }}</slot></h4>
      <p><slot name="description">{{ description }}</slot></p>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  title: { type: String, default: '' },
  description: { type: String, default: '' }
});
</script>

<style scoped>
.pp-verification-card {
  position: relative;
  display: flex;
  gap: 12px;
}

.item-icon-small {
  width: 24px;
  height: 24px;
  background-color: #f0f5ff;
  color: #3b63cc;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  position: absolute;
  left: -41px;
  top: 0;
  border: 4px solid white;
}

:deep(.item-icon-small svg) {
  width: 12px;
  height: 12px;
}

.item-text h4 {
  font-size: 14px;
  font-weight: 600;
  color: var(--pp-primary-variant, #1a2a5e);
  margin: 0 0 4px 0;
  line-height: 1.3;
}

.item-text p {
  font-size: 13px;
  color: #555;
  margin: 0;
  line-height: 1.4;
}
</style>
