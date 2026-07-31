<template>
  <div v-show="isActive" class="pp-tab-panel" role="tabpanel">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { inject, computed } from 'vue';

const props = defineProps<{
  value: string | number;
}>();

const tabsContext = inject('ppTabsContext') as any;

const isActive = computed(() => {
  return tabsContext?.activeTab.value === props.value;
});
</script>

<style scoped>
.pp-tab-panel {
  width: 100%;
  animation: fadeIn 0.3s ease;
}

@keyframes fadeIn {
  from { opacity: 0; transform: translateY(5px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>
