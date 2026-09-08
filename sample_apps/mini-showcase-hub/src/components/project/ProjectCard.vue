<template>
  <div class="project-card glass-panel" :class="{ 'is-expanded': isExpanded }">
    <!-- Project Main Header Block -->
    <div class="project-header" @click="toggleExpand">
      <img :src="project.icon" :alt="project.name" class="project-icon-img" />
      
      <div class="project-meta">
        <div class="meta-row">
          <h3 class="project-name">{{ project.name }}</h3>
          <span class="version-badge">{{ project.version }}</span>
        </div>
        <span class="project-category">{{ project.category }} • {{ project.author }}</span>
        <p class="project-desc">{{ project.description }}</p>
      </div>

      <div class="expand-btn">
        <div class="badge-count">
          <svg viewBox="0 0 24 24" width="13" height="13" stroke="currentColor" stroke-width="2" fill="none" style="margin-right:4px;">
            <polygon points="12 2 2 7 12 12 22 7 12 2"></polygon>
            <polyline points="2 17 12 22 22 17"></polyline>
            <polyline points="2 12 12 17 22 12"></polyline>
          </svg>
          <span>{{ plugins.length }}</span>
        </div>
        <div class="arrow-icon" :class="{ 'rotate-180': isExpanded }">
          <svg viewBox="0 0 24 24" width="18" height="18" stroke="currentColor" stroke-width="2" fill="none">
            <polyline points="6 9 12 15 18 9"></polyline>
          </svg>
        </div>
      </div>
    </div>

    <!-- Expanded Nested Plugins List -->
    <transition name="expand">
      <div v-if="isExpanded" class="plugins-drawer">
        <div class="drawer-header">
          <div class="drawer-title">
            <span>Integrated Framework Plugins & Components</span>
            <small>Directly utilized within this project codebase</small>
          </div>
          <a v-if="project.liveUrl" :href="project.liveUrl" target="_blank" class="launch-link" @click.stop>
            <span>Live Demo</span>
            <svg viewBox="0 0 24 24" width="13" height="13" stroke="currentColor" stroke-width="2" fill="none">
              <path d="M18 13v6a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h6"></path>
              <polyline points="15 3 21 3 21 9"></polyline>
              <line x1="10" y1="14" x2="21" y2="3"></line>
            </svg>
          </a>
        </div>

        <div class="plugins-grid">
          <div 
            v-for="p in plugins" 
            :key="p.id" 
            class="plugin-sub-item"
            @click="$emit('selectPlugin', p)"
          >
            <div class="sub-icon" :style="{ backgroundColor: `${p.color || 'var(--pp-primary)'}18`, color: p.color || 'var(--pp-primary)' }">
              <ion-icon :icon="p.icon" class="sub-icon-el"></ion-icon>
            </div>
            <div class="sub-details">
              <div class="sub-title-row">
                <span class="sub-title">{{ p.title }}</span>
                <span class="sub-name">{{ p.name.split(' ')[0] }}</span>
              </div>
              <p class="sub-desc">{{ p.description }}</p>
            </div>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import type { ProjectItem, PluginItem } from '../../types'

const props = defineProps<{
  project: ProjectItem
  plugins: PluginItem[]
  initiallyExpanded?: boolean
}>()

defineEmits<{
  (e: 'selectPlugin', plugin: PluginItem): void
}>()

const isExpanded = ref(props.initiallyExpanded || false)

const toggleExpand = () => {
  isExpanded.value = !isExpanded.value
}
</script>

<style scoped>
.project-card {
  border-radius: var(--radius-lg);
  border: 1px solid var(--border-color);
  margin-bottom: 16px;
  overflow: hidden;
  transition: all 0.3s ease;
}

.project-card:hover {
  border-color: var(--pp-primary);
}

.project-header {
  padding: 18px 20px;
  display: flex;
  align-items: center;
  gap: 16px;
  cursor: pointer;
  user-select: none;
}

.project-icon-img {
  width: 52px;
  height: 52px;
  border-radius: 14px;
  object-fit: cover;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  flex-shrink: 0;
}

.project-meta {
  flex: 1;
  min-width: 0;
}

.meta-row {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 2px;
}

.project-name {
  font-size: 16px;
  font-weight: 700;
  color: var(--text-main);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.version-badge {
  font-size: 10px;
  font-weight: 700;
  padding: 2px 6px;
  border-radius: 6px;
  background: var(--pp-primary-light);
  color: var(--pp-primary);
  font-family: monospace;
}

.project-category {
  font-size: 11px;
  font-weight: 500;
  color: var(--text-sub);
  display: block;
  margin-bottom: 4px;
}

.project-desc {
  font-size: 12px;
  color: var(--text-muted);
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.expand-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-shrink: 0;
}

.badge-count {
  display: flex;
  align-items: center;
  font-size: 12px;
  font-weight: 700;
  padding: 4px 10px;
  border-radius: 20px;
  background: var(--bg-main);
  border: 1px solid var(--border-color);
  color: var(--text-main);
}

.arrow-icon {
  color: var(--text-muted);
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  display: flex;
  align-items: center;
}

.arrow-icon.rotate-180 {
  transform: rotate(180deg);
  color: var(--pp-primary);
}

/* Drawer Section */
.plugins-drawer {
  padding: 0 20px 20px 20px;
  border-top: 1px solid var(--border-color);
  background: rgba(0, 0, 0, 0.02);
}

[data-theme="dark"] .plugins-drawer {
  background: rgba(0, 0, 0, 0.2);
}

.drawer-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 14px 0 12px 0;
}

.drawer-title span {
  font-size: 13px;
  font-weight: 700;
  color: var(--text-main);
  display: block;
}

.drawer-title small {
  font-size: 11px;
  color: var(--text-sub);
}

.launch-link {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  font-weight: 600;
  color: var(--pp-primary);
  text-decoration: none;
  padding: 4px 10px;
  border-radius: 8px;
  background: var(--pp-primary-light);
}

.plugins-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 10px;
}

.plugin-sub-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 12px;
  background: var(--bg-card);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition: all 0.2s ease;
}

.plugin-sub-item:hover {
  transform: translateY(-2px);
  border-color: var(--pp-primary);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
}

.sub-icon {
  width: 36px;
  height: 36px;
  border-radius: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.sub-icon-el {
  font-size: 20px;
}

.sub-details {
  flex: 1;
  min-width: 0;
}

.sub-title-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 2px;
}

.sub-title {
  font-size: 13px;
  font-weight: 700;
  color: var(--text-main);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.sub-name {
  font-size: 10px;
  font-family: monospace;
  color: var(--text-sub);
}

.sub-desc {
  font-size: 11px;
  color: var(--text-muted);
  line-height: 1.35;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

/* Animations */
.expand-enter-active,
.expand-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  max-height: 800px;
  opacity: 1;
}

.expand-enter-from,
.expand-leave-to {
  max-height: 0;
  opacity: 0;
  overflow: hidden;
}
</style>
