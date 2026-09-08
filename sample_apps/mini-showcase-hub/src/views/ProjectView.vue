<template>
  <div class="project-view">
    <!-- Header Controls -->
    <div class="project-top-bar glass-panel">
      <div class="bar-info">
        <h1>Project Directory & Plugin Map</h1>
        <p>Browse decentralized mini applications and examine their component architecture.</p>
      </div>

      <div class="search-box">
        <PPSearch
          v-model="searchQuery"
          :placeholder="t.searchProjects"
          style="width: 100%;"
        />
      </div>
    </div>

    <!-- Category Segments -->
    <div class="category-tabs">
      <PPSegment v-model="selectedCategory" variant="pill">
        <PPSegmentButton value="All">All Projects</PPSegmentButton>
        <PPSegmentButton value="Food & Beverage">F&B</PPSegmentButton>
        <PPSegmentButton value="Entertainment & Ticketing">Entertainment</PPSegmentButton>
        <PPSegmentButton value="Mobility">Mobility</PPSegmentButton>
        <PPSegmentButton value="Finance">Finance</PPSegmentButton>
      </PPSegment>
    </div>

    <!-- Projects List -->
    <div class="projects-list-container">
      <div class="projects-count">
        <span>Showing {{ filteredProjects.length }} of {{ mockProjects.length }} projects</span>
      </div>

      <div v-if="filteredProjects.length > 0">
        <ProjectCard
          v-for="project in filteredProjects"
          :key="project.id"
          :project="project"
          :plugins="getProjectPlugins(project.pluginIds)"
          :initiallyExpanded="project.id === 'proj-smart-hub'"
          @selectPlugin="onSelectPlugin"
        />
      </div>

      <div v-else class="empty-box glass-panel">
        <PPNoResult
          title="No Projects Found"
          description="Try modifying your project search keyword or category filter."
        />
      </div>
    </div>

    <!-- Plugin Detail Sheet from Project -->
    <PPBottomSheet v-model="showPluginSheet">
      <div class="detail-sheet-content" v-if="activePlugin">
        <div class="detail-header">
          <div class="detail-icon" :style="{ backgroundColor: `${activePlugin.color || 'var(--pp-primary)'}20`, color: activePlugin.color || 'var(--pp-primary)' }">
            <ion-icon :icon="activePlugin.icon" class="detail-icon-el"></ion-icon>
          </div>
          <div>
            <h3>{{ activePlugin.title }}</h3>
            <code>{{ activePlugin.name }}</code>
          </div>
        </div>

        <p class="detail-desc">{{ activePlugin.description }}</p>

        <div class="detail-info-grid glass-panel">
          <div class="info-row">
            <span>Category:</span>
            <strong>{{ activePlugin.category }}</strong>
          </div>
          <div class="info-row">
            <span>Framework:</span>
            <strong>@phanna/ui-framework</strong>
          </div>
          <div class="info-row">
            <span>Status:</span>
            <PPChip :label="activePlugin.status || 'stable'" size="sm" variant="soft" color="success" />
          </div>
        </div>

        <PPButton variant="primary" style="width: 100%; margin-top: 16px;" @click="showPluginSheet = false">
          {{ t.close }}
        </PPButton>
      </div>
    </PPBottomSheet>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { PPSearch, PPSegment, PPSegmentButton, PPBottomSheet, PPButton, PPChip, PPNoResult } from '@phanna/ui-framework'
import { mockProjects, mockPlugins } from '../data/mockData'
import { useAppState } from '../stores/appState'
import ProjectCard from '../components/project/ProjectCard.vue'
import type { PluginItem } from '../types'

const { t } = useAppState()

const searchQuery = ref('')
const selectedCategory = ref('All')
const activePlugin = ref<PluginItem | null>(null)
const showPluginSheet = ref(false)

const getProjectPlugins = (pluginIds: string[]) => {
  return mockPlugins.filter(p => pluginIds.includes(p.id))
}

const filteredProjects = computed(() => {
  return mockProjects.filter(p => {
    const matchesCategory =
      selectedCategory.value === 'All' ||
      p.category.toLowerCase().includes(selectedCategory.value.toLowerCase())
    
    const query = searchQuery.value.toLowerCase().trim()
    const matchesSearch =
      !query ||
      p.name.toLowerCase().includes(query) ||
      p.description.toLowerCase().includes(query) ||
      p.category.toLowerCase().includes(query) ||
      p.author.toLowerCase().includes(query)

    return matchesCategory && matchesSearch
  })
})

const onSelectPlugin = (plugin: PluginItem) => {
  activePlugin.value = plugin
  showPluginSheet.value = true
}
</script>

<style scoped>
.project-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.project-top-bar {
  padding: 24px;
  border-radius: var(--radius-lg);
  border: 1px solid var(--border-color);
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
}

.bar-info h1 {
  font-size: 20px;
  font-weight: 800;
  color: var(--text-main);
  margin-bottom: 4px;
}

.bar-info p {
  font-size: 13px;
  color: var(--text-muted);
}

.search-box {
  min-width: 260px;
}

.category-tabs {
  overflow-x: auto;
  padding-bottom: 2px;
}

.projects-count {
  font-size: 12px;
  color: var(--text-sub);
  margin-bottom: 12px;
}

.empty-box {
  padding: 30px;
  border-radius: var(--radius-md);
}

.detail-sheet-content {
  padding: 20px 24px 32px 24px;
}

.detail-header {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-bottom: 14px;
}

.detail-icon {
  width: 46px;
  height: 46px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.detail-icon-el {
  font-size: 24px;
}

.detail-header h3 {
  font-size: 17px;
  font-weight: 700;
  color: var(--text-main);
}

.detail-header code {
  font-size: 11px;
  color: var(--text-sub);
}

.detail-desc {
  font-size: 13px;
  color: var(--text-muted);
  line-height: 1.5;
  margin-bottom: 16px;
}

.detail-info-grid {
  border-radius: var(--radius-sm);
  padding: 14px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.info-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 12px;
}

.info-row span {
  color: var(--text-muted);
}

.info-row strong {
  color: var(--text-main);
}
</style>
