<script setup lang="ts">
import type { MiniAppCategory } from '../../data/mockData'

defineProps<{
  category: MiniAppCategory
}>()

const emit = defineEmits<{
  (e: 'toggleStatus', category: MiniAppCategory): void
  (e: 'edit', category: MiniAppCategory): void
  (e: 'delete', id: string): void
}>()
</script>

<template>
  <div
    class="category-card glass-panel"
    :style="{ '--accent-color': category.color }"
  >
    <div class="card-top">
      <div class="icon-avatar" :style="{ backgroundColor: `${category.color}20`, borderColor: `${category.color}50` }">
        <svg viewBox="0 0 24 24" width="22" height="22" fill="none" :stroke="category.color" stroke-width="2"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
      </div>
      <div class="card-meta">
        <div class="order-badge">#{{ category.order }}</div>
        <PPChip
          :label="category.status.toUpperCase()"
          :color="category.status === 'active' ? 'success' : 'default'"
          size="sm"
          variant="soft"
        />
      </div>
    </div>

    <div class="card-body">
      <h3 class="category-name">{{ category.name }}</h3>
      <code class="slug-tag">slug: {{ category.slug }}</code>
      <div class="category-description" v-html="category.description"></div>
    </div>

    <div class="card-footer">
      <div class="app-count-tag">
        <span class="dot" :style="{ backgroundColor: category.color }"></span>
        <strong>{{ category.appCount }}</strong> Mini Apps
      </div>

      <div class="card-actions">
        <button @click="emit('toggleStatus', category)" class="btn-icon" :title="category.status === 'active' ? 'Deactivate' : 'Activate'">
          <svg v-if="category.status === 'active'" viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
          <svg v-else viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect><path d="M7 11V7a5 5 0 0 1 10 0v4"></path></svg>
        </button>
        <button @click="emit('edit', category)" class="btn-icon edit" title="Edit Category">
          <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20h9"></path><path d="M16.5 3.5a2.121 2.121 0 0 1 3 3L7 19l-4 1 1-4L16.5 3.5z"></path></svg>
        </button>
        <button @click="emit('delete', category.id)" class="btn-icon delete" title="Delete Category">
          <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
        </button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.category-card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 22px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  position: relative;
  overflow: hidden;
  transition: transform 0.2s, border-color 0.2s;
}

.category-card:hover {
  transform: translateY(-2px);
  border-color: #374151;
}

.card-top {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
  margin-bottom: 16px;
}

.icon-avatar {
  width: 48px;
  height: 48px;
  border-radius: 14px;
  border: 1px solid;
  display: flex;
  align-items: center;
  justify-content: center;
}

.card-meta {
  display: flex;
  align-items: center;
  gap: 8px;
}

.order-badge {
  font-size: 11px;
  font-weight: 700;
  color: #64748b;
  background: #0f172a;
  padding: 3px 8px;
  border-radius: 6px;
  border: 1px solid #1f2937;
}

.card-body {
  flex: 1;
}

.category-name {
  font-size: 17px;
  font-weight: 700;
  color: #fff;
  margin-bottom: 4px;
}

.slug-tag {
  font-size: 11px;
  color: #60a5fa;
  background: rgba(59, 130, 246, 0.1);
  padding: 2px 6px;
  border-radius: 4px;
  display: inline-block;
  margin-bottom: 12px;
}

.category-description {
  font-size: 13px;
  color: #94a3b8;
  line-height: 1.5;
  margin-bottom: 16px;
}

.card-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 14px;
  border-top: 1px solid #1f2937;
}

.app-count-tag {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 12px;
  color: #cbd5e1;
}

.dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
}

.card-actions {
  display: flex;
  gap: 6px;
}

.btn-icon {
  background: #1e293b;
  border: 1px solid #374151;
  color: #94a3b8;
  width: 30px;
  height: 30px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}

.btn-icon:hover {
  background: #334155;
  color: #fff;
}

.btn-icon.edit:hover {
  color: #60a5fa;
}

.btn-icon.delete:hover {
  color: #ef4444;
}
</style>
