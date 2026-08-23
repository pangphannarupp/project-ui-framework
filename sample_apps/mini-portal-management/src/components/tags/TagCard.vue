<script setup lang="ts">
import type { MiniAppTag } from '../../data/mockData'

defineProps<{
  tag: MiniAppTag
}>()

const emit = defineEmits<{
  (e: 'toggleFeatured', tag: MiniAppTag): void
  (e: 'edit', tag: MiniAppTag): void
  (e: 'delete', id: string): void
}>()
</script>

<template>
  <div class="tag-card glass-panel">
    <div class="tag-card-top">
      <div class="tag-badge-preview" :style="{ borderColor: tag.color, backgroundColor: 'rgba(15, 23, 42, 0.8)' }">
        <span class="tag-icon-svg" :style="{ color: tag.color }">
          <svg v-if="tag.icon === 'qr-code'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
          <svg v-else-if="tag.icon === 'coffee'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M18 8h1a4 4 0 0 1 0 8h-1"></path><path d="M2 8h16v9a4 4 0 0 1-4 4H6a4 4 0 0 1-4-4V8z"></path><line x1="6" y1="1" x2="6" y2="4"></line><line x1="10" y1="1" x2="10" y2="4"></line><line x1="14" y1="1" x2="14" y2="4"></line></svg>
          <svg v-else-if="tag.icon === 'flash'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
          <svg v-else-if="tag.icon === 'cube'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path><polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline><line x1="12" y1="22.08" x2="12" y2="12"></line></svg>
          <svg v-else-if="tag.icon === 'film'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><rect x="2" y="2" width="20" height="20" rx="2.18" ry="2.18"></rect><line x1="7" y1="2" x2="7" y2="22"></line><line x1="17" y1="2" x2="17" y2="22"></line><line x1="2" y1="12" x2="22" y2="12"></line><line x1="2" y1="7" x2="7" y2="7"></line><line x1="2" y1="17" x2="7" y2="17"></line><line x1="17" y1="17" x2="22" y2="17"></line><line x1="17" y1="7" x2="22" y2="7"></line></svg>
          <svg v-else-if="tag.icon === 'battery-charging'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 18H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h3.19M15 6h2a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2h-3.19"></path><line x1="23" y1="13" x2="23" y2="11"></line><polyline points="11 6 7 12 13 12 9 18"></polyline></svg>
          <svg v-else-if="tag.icon === 'sparkles'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"></path></svg>
          <svg v-else-if="tag.icon === 'card'" viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect><line x1="1" y1="10" x2="23" y2="10"></line></svg>
          <svg v-else viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M20.59 13.41l-7.17 7.17a2 2 0 0 1-2.83 0L2 12V2h10l8.59 8.59a2 2 0 0 1 0 2.82z"></path><line x1="7" y1="7" x2="7.01" y2="7"></line></svg>
        </span>
        <strong :style="{ color: tag.color }">{{ tag.name }}</strong>
      </div>
      <PPChip
        :label="tag.isFeatured ? 'FEATURED' : 'STANDARD'"
        :color="tag.isFeatured ? 'warning' : 'default'"
        size="sm"
        variant="soft"
      />
    </div>

    <div class="tag-slug-row">
      <code>#{{ tag.slug }}</code>
      <span class="color-dot" :style="{ backgroundColor: tag.color }"></span>
    </div>

    <div class="tag-desc" v-html="tag.description || '<span class=\'no-desc\'>No description provided.</span>'"></div>

    <div class="tag-card-footer">
      <span class="app-count-label">
        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" style="display:inline; vertical-align:text-bottom; margin-right:4px;"><rect x="5" y="2" width="14" height="20" rx="2" ry="2"></rect><line x1="12" y1="18" x2="12.01" y2="18"></line></svg>
        <strong>{{ tag.appCount }}</strong> Linked Apps
      </span>
      <div class="tag-actions">
        <button class="icon-btn-action" @click="emit('toggleFeatured', tag)" :title="tag.isFeatured ? 'Unmark Featured' : 'Mark Featured'">
          <svg v-if="tag.isFeatured" viewBox="0 0 24 24" width="14" height="14" fill="#f59e0b" stroke="#f59e0b" stroke-width="1"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
          <svg v-else viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon></svg>
        </button>
        <button class="icon-btn-action" @click="emit('edit', tag)" title="Edit Tag">
          <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
        </button>
        <button class="icon-btn-action delete" @click="emit('delete', tag.id)" title="Delete Tag">
          <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.tag-card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 20px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  transition: transform 0.2s, border-color 0.2s;
}

.tag-card:hover {
  transform: translateY(-2px);
  border-color: #374151;
}

.tag-card-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.tag-badge-preview {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 6px 12px;
  border-radius: 8px;
  border: 1px solid;
}

.tag-badge-preview strong {
  font-size: 14px;
}

.tag-icon-svg {
  display: flex;
  align-items: center;
}

.tag-slug-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 10px;
}

.tag-slug-row code {
  font-size: 11px;
  color: #64748b;
  background: #0f172a;
  padding: 2px 6px;
  border-radius: 4px;
}

.color-dot {
  width: 10px;
  height: 10px;
  border-radius: 50%;
}

.tag-desc {
  font-size: 13px;
  color: #94a3b8;
  line-height: 1.5;
  margin-bottom: 16px;
  flex: 1;
}

:deep(.no-desc) {
  color: #64748b;
  font-style: italic;
}

.tag-card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 14px;
  border-top: 1px solid #1f2937;
}

.app-count-label {
  font-size: 12px;
  color: #cbd5e1;
}

.tag-actions {
  display: flex;
  gap: 4px;
}

.icon-btn-action {
  background: #1e293b;
  border: 1px solid #374151;
  color: #94a3b8;
  width: 28px;
  height: 28px;
  border-radius: 6px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}

.icon-btn-action:hover {
  background: #334155;
  color: #fff;
}

.icon-btn-action.delete:hover {
  color: #ef4444;
}
</style>
