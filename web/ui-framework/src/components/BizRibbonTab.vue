<template>
  <div v-show="isActive" class="biz-ribbon-tab-content">
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { inject, computed, onMounted } from 'vue';

const props = defineProps<{
  title: string;
  color?: string; // e.g. 'primary' for a colored tab like "FILE"
  id?: string;
}>();

const tabId = props.id || props.title.toLowerCase().replace(/\s+/g, '-');

const registerTab = inject('bizRibbonRegisterTab') as ((tab: any) => void);
const activeTabId = inject('bizRibbonActiveTab') as { value: string };

onMounted(() => {
  if (registerTab) {
    registerTab({ id: tabId, title: props.title, color: props.color });
  }
});

const isActive = computed(() => activeTabId?.value === tabId);

</script>

<style scoped>
.biz-ribbon-tab-content {
  display: flex;
  align-items: stretch;
  gap: 8px;
  width: 100%;
}
</style>
