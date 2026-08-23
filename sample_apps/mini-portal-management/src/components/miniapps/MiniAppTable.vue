<script setup lang="ts">
import type { MiniApp } from '../../data/mockData'

defineProps<{
  apps: MiniApp[]
  isReorderMode: boolean
}>()

const emit = defineEmits<{
  (e: 'toggleStatus', app: MiniApp): void
  (e: 'moveOrder', index: number, direction: 'up' | 'down'): void
}>()
</script>

<template>
  <div class="table-container glass-panel">
    <table class="apps-table">
      <thead>
        <tr>
          <th v-if="isReorderMode">ORDER</th>
          <th>MINI APP</th>
          <th>BANNER PREVIEW</th>
          <th>CATEGORY</th>
          <th>TAGS</th>
          <th>PACKAGE TYPE</th>
          <th>STATUS</th>
          <th>VIEWS</th>
          <th>MAU</th>
          <th>ACTIONS</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(app, index) in apps" :key="app.id">
          <td v-if="isReorderMode">
            <div class="table-reorder-controls">
              <span class="order-num">#{{ app.order || (index + 1) }}</span>
              <button class="table-arrow-btn" :disabled="index === 0" @click="emit('moveOrder', index, 'up')">▲</button>
              <button class="table-arrow-btn" :disabled="index === apps.length - 1" @click="emit('moveOrder', index, 'down')">▼</button>
            </div>
          </td>
          <td>
            <div class="table-app-info">
              <img :src="app.icon" class="table-icon-thumb" :alt="app.name" />
              <div>
                <strong>{{ app.name }}</strong>
                <code class="text-muted block font-mono">{{ app.slug }}</code>
              </div>
            </div>
          </td>
          <td>
            <div class="table-banner-thumb-wrapper">
              <img :src="app.banner" class="table-banner-thumb" alt="Banner" v-if="app.banner" />
              <span v-else class="no-banner-text">No banner</span>
            </div>
          </td>
          <td><span class="category-pill">{{ app.category }}</span></td>
          <td>
            <div class="table-tags-cell">
              <PPChip
                v-for="t in (app.tags || []).slice(0, 2)"
                :key="t"
                :label="t"
                size="sm"
                variant="outline"
              />
              <small v-if="(app.tags || []).length > 2" class="text-muted">+{{ (app.tags || []).length - 2 }}</small>
            </div>
          </td>
          <td>
            <span class="pkg-badge" :class="app.packageType">
              {{ app.packageType === 'zip' ? 'Zip Bundle' : app.packageType === 'web_url' ? 'Web URL' : app.packageType === 'native_aar' ? 'Native AAR' : 'Partner API' }}
            </span>
          </td>
          <td>
            <PPChip
              :label="app.status.toUpperCase()"
              :color="app.status === 'active' ? 'success' : 'warning'"
              size="sm"
              variant="soft"
            />
          </td>
          <td class="font-medium text-cyan">
            <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" style="display:inline; vertical-align:text-bottom; margin-right:3px;"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
            {{ (app.viewCount || 0).toLocaleString() }}
          </td>
          <td class="font-medium">{{ app.usersCount.toLocaleString() }}</td>
          <td>
            <div class="table-actions">
              <PPButton size="small" variant="outline" @click="emit('toggleStatus', app)">
                <span>Toggle</span>
              </PPButton>
              <a :href="`https://pangphannarupp.github.io/project-ui-framework${app.path}`" target="_blank" style="text-decoration:none;">
                <PPButton size="small" variant="primary">
                  <span>Launch</span>
                </PPButton>
              </a>
            </div>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<style scoped>
.table-container {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  overflow-x: auto;
}

.apps-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
}

.apps-table th {
  font-size: 11px;
  letter-spacing: 0.5px;
  color: #64748b;
  padding: 14px 18px;
  border-bottom: 1px solid #1f2937;
  background: #0d1321;
}

.apps-table td {
  padding: 14px 18px;
  font-size: 13px;
  border-bottom: 1px solid #1f2937;
  color: #e2e8f0;
}

.table-reorder-controls {
  display: flex;
  align-items: center;
  gap: 6px;
}

.order-num {
  font-size: 12px;
  font-weight: 700;
  color: #60a5fa;
  min-width: 24px;
}

.table-arrow-btn {
  background: #1e293b;
  border: 1px solid #374151;
  color: #f8fafc;
  width: 22px;
  height: 22px;
  border-radius: 4px;
  font-size: 10px;
  cursor: pointer;
}

.table-arrow-btn:disabled {
  opacity: 0.3;
  cursor: not-allowed;
}

.table-app-info {
  display: flex;
  align-items: center;
  gap: 12px;
}

.table-icon-thumb {
  width: 36px;
  height: 36px;
  border-radius: 8px;
  object-fit: cover;
  border: 1px solid #374151;
}

.table-banner-thumb-wrapper {
  width: 90px;
  height: 36px;
  border-radius: 6px;
  overflow: hidden;
  background: #1e293b;
  border: 1px solid #374151;
  display: flex;
  align-items: center;
  justify-content: center;
}

.table-banner-thumb {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.no-banner-text {
  font-size: 10px;
  color: #64748b;
}

.category-pill {
  background: #1e293b;
  color: #94a3b8;
  padding: 3px 8px;
  border-radius: 6px;
  font-size: 12px;
}

.table-tags-cell {
  display: flex;
  align-items: center;
  gap: 4px;
  flex-wrap: wrap;
}

.pkg-badge {
  font-size: 11px;
  font-weight: 600;
  color: #a78bfa;
}

.text-cyan {
  color: #38bdf8 !important;
}

.table-actions {
  display: flex;
  gap: 6px;
}
</style>
