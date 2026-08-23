<script setup lang="ts">
import AdminLayout from '../layouts/AdminLayout.vue'
import { useMiniAppsViewModel } from '../viewmodels/useMiniAppsViewModel'
import MiniAppsToolbar from '../components/miniapps/MiniAppsToolbar.vue'
import MiniAppCard from '../components/miniapps/MiniAppCard.vue'
import MiniAppTable from '../components/miniapps/MiniAppTable.vue'
import MiniAppCreateModal from '../components/miniapps/MiniAppCreateModal.vue'

const {
  categories,
  isLoading,
  selectedCategory,
  searchQuery,
  viewMode,
  isReorderMode,
  showCreateModal,
  newApp,
  currentPage,
  pageSize,
  totalFilteredApps,
  filteredApps,
  paginatedApps,
  handleIconSelect,
  handleBannerSelect,
  handlePackageFileSelect,
  handleCreateApp,
  toggleAppStatus,
  moveAppOrder,
  addApiEndpoint,
  removeApiEndpoint,
  addFieldMapping,
  removeFieldMapping,
  toggleTransform
} = useMiniAppsViewModel()
</script>

<template>
  <AdminLayout>
    <div class="mini-apps-view">
      <!-- Stateless Toolbar Component -->
      <MiniAppsToolbar
        :categories="categories"
        :selected-category="selectedCategory"
        :search-query="searchQuery"
        :view-mode="viewMode"
        :is-reorder-mode="isReorderMode"
        @update:selected-category="val => selectedCategory = val"
        @update:search-query="val => searchQuery = val"
        @update:view-mode="val => viewMode = val"
        @toggle-reorder="isReorderMode = !isReorderMode"
        @open-create="showCreateModal = true"
      />

      <!-- Dynamic PPSkeleton Loading States -->
      <PPSkeleton :loading="isLoading" :animated="true">
        <template #template>
          <!-- Shimmer Grid View -->
          <div v-if="viewMode === 'grid'" class="apps-grid">
            <div v-for="i in 6" :key="i" class="skeleton-card">
              <div style="padding: 20px 20px 0 20px;">
                <PPSkeletonItem variant="rect" height="110px" style="border-radius: 12px; margin-bottom: 16px;" />
                <div style="display: flex; gap: 14px; align-items: center;">
                  <PPSkeletonItem variant="rect" width="48px" height="48px" style="border-radius: 12px;" />
                  <div style="flex: 1; display: flex; flex-direction: column; gap: 6px;">
                    <PPSkeletonItem variant="text" width="60%" height="16px" />
                    <PPSkeletonItem variant="text" width="40%" height="12px" />
                  </div>
                </div>
              </div>
              <div style="padding: 16px 20px; display: flex; flex-direction: column; gap: 8px;">
                <PPSkeletonItem variant="text" width="100%" height="14px" />
                <PPSkeletonItem variant="text" width="80%" height="14px" />
              </div>
              <div style="padding: 12px 20px; border-top: 1px solid #1e293b; display: grid; grid-template-columns: repeat(3, 1fr); gap: 8px;">
                <PPSkeletonItem variant="text" height="24px" />
                <PPSkeletonItem variant="text" height="24px" />
                <PPSkeletonItem variant="text" height="24px" />
              </div>
              <div style="padding: 14px 20px; border-top: 1px solid #1e293b; display: flex; justify-content: space-between;">
                <PPSkeletonItem variant="rect" width="90px" height="32px" style="border-radius: 8px;" />
                <PPSkeletonItem variant="rect" width="110px" height="32px" style="border-radius: 8px;" />
              </div>
            </div>
          </div>

          <!-- Shimmer Table View -->
          <div v-else class="card glass-panel" style="padding: 20px;">
            <div style="display: flex; flex-direction: column; gap: 16px;">
              <PPSkeletonItem variant="rect" height="40px" style="border-radius: 8px;" />
              <PPSkeletonItem v-for="i in 5" :key="i" variant="rect" height="52px" style="border-radius: 8px;" />
            </div>
          </div>
        </template>

        <!-- Actual Content Views -->
        <!-- Stateless Grid View -->
        <div v-if="viewMode === 'grid'" class="apps-grid">
          <MiniAppCard
            v-for="(app, index) in paginatedApps"
            :key="app.id"
            :app="app"
            :index="index"
            :is-reorder-mode="isReorderMode"
            :is-first="index === 0"
            :is-last="index === paginatedApps.length - 1"
            @toggle-status="toggleAppStatus"
            @move-order="moveAppOrder"
          />
        </div>

        <!-- Stateless Table View -->
        <MiniAppTable
          v-else
          :apps="paginatedApps"
          :is-reorder-mode="isReorderMode"
          @toggle-status="toggleAppStatus"
          @move-order="moveAppOrder"
        />

        <!-- Pagination Controls -->
        <div v-if="!isReorderMode && totalFilteredApps > pageSize" class="pagination-footer glass-panel">
          <div class="pagination-info">
            <span>Showing <strong>{{ (currentPage - 1) * pageSize + 1 }}</strong> - <strong>{{ Math.min(currentPage * pageSize, totalFilteredApps) }}</strong> of <strong>{{ totalFilteredApps }}</strong> mini apps</span>
          </div>
          <PPPagination
            :total="totalFilteredApps"
            :page-size="pageSize"
            :current-page="currentPage"
            @update:current-page="(val: number) => currentPage = val"
          />
        </div>
      </PPSkeleton>

      <!-- Stateless Register Modal -->
      <MiniAppCreateModal
        :show="showCreateModal"
        :categories="categories"
        :new-app="newApp"
        @close="showCreateModal = false"
        @submit="handleCreateApp"
        @icon-select="handleIconSelect"
        @banner-select="handleBannerSelect"
        @package-file-select="handlePackageFileSelect"
        @add-api-endpoint="addApiEndpoint"
        @remove-api-endpoint="removeApiEndpoint"
        @add-field-mapping="addFieldMapping"
        @remove-field-mapping="removeFieldMapping"
        @toggle-transform="toggleTransform"
      />
    </div>
  </AdminLayout>
</template>

<style scoped>
.mini-apps-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.apps-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
  gap: 24px;
}

.pagination-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 24px;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 14px;
  margin-top: 12px;
  flex-wrap: wrap;
  gap: 16px;
}

.pagination-summary {
  font-size: 13px;
  color: #94a3b8;
}

.pagination-summary strong {
  color: #f8fafc;
}
</style>
