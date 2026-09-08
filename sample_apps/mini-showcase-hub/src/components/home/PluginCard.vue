<template>
  <div class="plugin-card glass-panel" @click="$emit('select', plugin)">
    <div class="card-top">
      <div class="icon-avatar" :style="{ backgroundColor: `${plugin.color || 'var(--pp-primary)'}18`, color: plugin.color || 'var(--pp-primary)' }">
        <ion-icon :icon="plugin.icon" class="plugin-icon"></ion-icon>
      </div>
      <div class="badge-wrapper" v-if="plugin.tag">
        <PPChip :label="plugin.tag" size="sm" variant="soft" :style="{ color: plugin.color, borderColor: `${plugin.color}33` }" />
      </div>
    </div>
    
    <div class="card-body">
      <h3 class="plugin-title">{{ plugin.title }}</h3>
      <span class="plugin-name">{{ plugin.name }}</span>
      <p class="plugin-desc">{{ plugin.description }}</p>
    </div>

    <div class="card-footer">
      <span class="category-text">{{ plugin.category }}</span>
      <div class="action-arrow">
        <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none">
          <polyline points="9 18 15 12 9 6"></polyline>
        </svg>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { PPChip } from '@phanna/ui-framework'
import type { PluginItem } from '../../types'

defineProps<{
  plugin: PluginItem
}>()

defineEmits<{
  (e: 'select', plugin: PluginItem): void
}>()
</script>

<style scoped>
.plugin-card {
  border-radius: var(--radius-md);
  padding: 16px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  cursor: pointer;
  transition: all 0.25s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
}

.plugin-card:hover {
  transform: translateY(-3px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
  border-color: var(--pp-primary);
}

.card-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.icon-avatar {
  width: 44px;
  height: 44px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.plugin-icon {
  font-size: 24px;
}

.card-body {
  flex: 1;
}

.plugin-title {
  font-size: 15px;
  font-weight: 700;
  color: var(--text-main);
  margin-bottom: 2px;
  line-height: 1.3;
}

.plugin-name {
  font-size: 11px;
  font-weight: 600;
  color: var(--text-sub);
  font-family: monospace;
  display: block;
  margin-bottom: 6px;
}

.plugin-desc {
  font-size: 12px;
  line-height: 1.45;
  color: var(--text-muted);
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 14px;
  padding-top: 10px;
  border-top: 1px solid var(--border-color);
}

.category-text {
  font-size: 11px;
  font-weight: 600;
  color: var(--text-sub);
}

.action-arrow {
  color: var(--text-sub);
  display: flex;
  align-items: center;
  transition: transform 0.2s ease;
}

.plugin-card:hover .action-arrow {
  color: var(--pp-primary);
  transform: translateX(3px);
}
</style>
