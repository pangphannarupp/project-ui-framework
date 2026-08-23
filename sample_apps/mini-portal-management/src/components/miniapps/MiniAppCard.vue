<script setup lang="ts">
import type { MiniApp } from '../../data/mockData'

defineProps<{
  app: MiniApp
  index: number
  isReorderMode: boolean
  isFirst: boolean
  isLast: boolean
}>()

const emit = defineEmits<{
  (e: 'toggleStatus', app: MiniApp): void
  (e: 'moveOrder', index: number, direction: 'up' | 'down'): void
}>()
</script>

<template>
  <div class="app-card glass-panel" :class="{ 'reorder-active-card': isReorderMode }">
    <!-- Card Banner Attachment -->
    <div class="card-banner-wrapper">
      <img :src="app.banner || 'https://images.unsplash.com/photo-1550745165-9bc0b252726f?w=800&h=300&fit=crop'" class="app-banner-img" alt="App Banner" />
      
      <!-- Reorder overlay controls -->
      <div v-if="isReorderMode" class="card-reorder-overlay">
        <span class="order-badge">Rank #{{ app.order || (index + 1) }}</span>
        <div class="reorder-btns">
          <button
            type="button"
            class="reorder-btn"
            :disabled="isFirst"
            @click="emit('moveOrder', index, 'up')"
            title="Move Up"
          >
            ▲
          </button>
          <button
            type="button"
            class="reorder-btn"
            :disabled="isLast"
            @click="emit('moveOrder', index, 'down')"
            title="Move Down"
          >
            ▼
          </button>
        </div>
      </div>
    </div>

    <div class="app-card-header">
      <!-- App Icon Attachment -->
      <div class="app-icon-wrapper">
        <img :src="app.icon" class="app-icon-img" :alt="app.name" />
      </div>
      <div class="app-title-area">
        <div class="app-title-row">
          <h3>{{ app.name }}</h3>
          <PPChip
            :label="app.status.toUpperCase()"
            :color="app.status === 'active' ? 'success' : 'warning'"
            size="sm"
            variant="soft"
          />
        </div>
        <div class="app-sub-meta">
          <span class="cat-tag">{{ app.category }}</span>
          <code>{{ app.slug }}</code>
        </div>
      </div>
    </div>

    <!-- App Discoverability Tags -->
    <div v-if="app.tags && app.tags.length > 0" class="app-tags-row">
      <PPChip
        v-for="tag in app.tags"
        :key="tag"
        :label="tag"
        color="default"
        variant="outline"
        size="sm"
      />
    </div>

    <div class="app-desc" v-html="app.description"></div>

    <div class="app-metrics">
      <div class="metric">
        <small>Package Type</small>
        <span class="pkg-badge" :class="app.packageType">
          <span v-if="app.packageType === 'zip'">Zip Bundle</span>
          <span v-else-if="app.packageType === 'web_url'">Web URL</span>
          <span v-else-if="app.packageType === 'native_aar'">Native AAR</span>
          <span v-else>Partner API</span>
        </span>
      </div>
      <div class="metric">
        <small>Active Users</small>
        <strong>{{ (app.usersCount).toLocaleString() }}</strong>
      </div>
      <div class="metric">
        <small>Total Views</small>
        <strong class="text-cyan">
          <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" style="display:inline; vertical-align:text-bottom; margin-right:3px;"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
          {{ (app.viewCount || 0).toLocaleString() }}
        </strong>
      </div>
    </div>

    <!-- Package / Asset Link display -->
    <div class="app-package-info">
      <template v-if="app.packageType === 'zip'">
        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:4px;"><path d="M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z"></path></svg>
        <code class="truncate">{{ app.fileName || `${app.slug}-v1.0.zip` }} ({{ app.fileSize || '4.8 MB' }})</code>
      </template>
      <template v-else-if="app.packageType === 'web_url'">
        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:4px;"><circle cx="12" cy="12" r="10"></circle><line x1="2" y1="12" x2="22" y2="12"></line><path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path></svg>
        <code class="truncate">https://cdn.miniportal.io/apps/{{ app.slug }}/index.html</code>
      </template>
      <template v-else-if="app.packageType === 'native_aar'">
        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:4px;"><rect x="5" y="2" width="14" height="20" rx="2" ry="2"></rect><line x1="12" y1="18" x2="12.01" y2="18"></line></svg>
        <code class="truncate">{{ app.androidPackageName || `com.miniportal.${app.slug}` }}</code>
      </template>
      <template v-else>
        <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="#60a5fa" stroke-width="2" style="margin-right:4px;"><polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline></svg>
        <code class="truncate text-cyan">{{ app.apiConfig?.baseUrl || 'https://api.partner.com/v1' }}{{ app.apiConfig?.endpoints?.[0]?.path || `/${app.slug}` }} ({{ app.apiConfig?.endpoints?.length || 1 }} endpoints)</code>
      </template>
    </div>

    <div class="app-card-footer">
      <PPButton
        size="small"
        :variant="app.status === 'active' ? 'outline' : 'primary'"
        @click="emit('toggleStatus', app)"
      >
        <span>{{ app.status === 'active' ? 'Deactivate' : 'Publish Live' }}</span>
      </PPButton>

      <a :href="`https://pangphannarupp.github.io/project-ui-framework${app.path}`" target="_blank" style="text-decoration:none;">
        <PPButton size="small" variant="primary">
          <span>Launch Webview ↗</span>
        </PPButton>
      </a>
    </div>
  </div>
</template>

<style scoped>
.app-card {
  display: flex;
  flex-direction: column;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  overflow: hidden;
  transition: transform 0.2s ease, border-color 0.2s ease;
}

.app-card:hover {
  transform: translateY(-2px);
  border-color: #374151;
}

.reorder-active-card {
  border-color: #3b82f6 !important;
  box-shadow: 0 0 15px rgba(59, 130, 246, 0.2);
}

.card-banner-wrapper {
  position: relative;
  width: 100%;
  height: 120px;
  overflow: hidden;
  background: #0f172a;
}

.app-banner-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  opacity: 0.85;
}

.card-reorder-overlay {
  position: absolute;
  top: 8px;
  right: 8px;
  display: flex;
  align-items: center;
  gap: 8px;
  background: rgba(15, 23, 42, 0.85);
  backdrop-filter: blur(8px);
  padding: 4px 8px;
  border-radius: 8px;
  border: 1px solid rgba(59, 130, 246, 0.4);
}

.order-badge {
  font-size: 11px;
  font-weight: 700;
  color: #60a5fa;
}

.reorder-btns {
  display: flex;
  gap: 2px;
}

.reorder-btn {
  background: #1e293b;
  border: 1px solid #374151;
  color: #f8fafc;
  width: 22px;
  height: 22px;
  border-radius: 4px;
  font-size: 10px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.reorder-btn:disabled {
  opacity: 0.4;
  cursor: not-allowed;
}

.app-card-header {
  padding: 16px 20px 0;
  display: flex;
  gap: 14px;
  align-items: flex-start;
}

.app-icon-wrapper {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  overflow: hidden;
  border: 1px solid #374151;
  background: #1e293b;
  flex-shrink: 0;
  margin-top: -24px;
  position: relative;
  z-index: 2;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
}

.app-icon-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.app-title-area {
  flex: 1;
}

.app-title-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 8px;
}

.app-title-row h3 {
  font-size: 16px;
  font-weight: 700;
  color: #fff;
}

.app-sub-meta {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-top: 4px;
}

.cat-tag {
  font-size: 12px;
  color: #60a5fa;
  font-weight: 600;
}

.app-sub-meta code {
  font-size: 11px;
  color: #64748b;
  background: #0f172a;
  padding: 1px 6px;
  border-radius: 4px;
}

.app-tags-row {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  padding: 10px 20px 0;
}

.app-desc {
  padding: 12px 20px;
  font-size: 13px;
  color: #94a3b8;
  line-height: 1.5;
  flex: 1;
}

.app-metrics {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  padding: 12px 20px;
  background: rgba(15, 23, 42, 0.5);
  border-top: 1px solid #1f2937;
  border-bottom: 1px solid #1f2937;
  gap: 8px;
}

.metric {
  display: flex;
  flex-direction: column;
}

.metric small {
  font-size: 11px;
  color: #64748b;
}

.metric strong {
  font-size: 13px;
  color: #f8fafc;
  margin-top: 2px;
}

.text-cyan {
  color: #38bdf8 !important;
}

.pkg-badge {
  font-size: 11px;
  font-weight: 600;
  color: #a78bfa;
}

.app-package-info {
  display: flex;
  align-items: center;
  padding: 8px 20px;
  font-size: 12px;
  color: #94a3b8;
  background: #0d1321;
}

.truncate {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.app-card-footer {
  padding: 14px 20px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}
</style>
