<script setup lang="ts">
import AdminLayout from '../layouts/AdminLayout.vue'
import { useCategoriesViewModel } from '../viewmodels/useCategoriesViewModel'
import CategoryHeaderStats from '../components/categories/CategoryHeaderStats.vue'
import CategoryToolbar from '../components/categories/CategoryToolbar.vue'
import CategoryCard from '../components/categories/CategoryCard.vue'
import CategoryModal from '../components/categories/CategoryModal.vue'

const {
  categories,
  isLoading,
  searchQuery,
  selectedStatus,
  showCreateModal,
  editingCategory,
  categoryForm,
  availableColors,
  filteredCategories,
  activeCategoriesCount,
  totalApps,
  showDeleteConfirm,
  openCreateModal,
  openEditModal,
  handleSaveCategory,
  toggleCategoryStatus,
  requestDeleteCategory,
  confirmDeleteCategory,
  cancelDeleteCategory
} = useCategoriesViewModel()
</script>

<template>
  <AdminLayout>
    <div class="categories-view">
      <!-- Stateless Header Stats -->
      <CategoryHeaderStats
        :total-categories="categories.length"
        :active-count="activeCategoriesCount"
        :total-apps="totalApps"
      />

      <!-- Stateless Toolbar -->
      <CategoryToolbar
        :total-count="categories.length"
        :active-count="activeCategoriesCount"
        v-model:selected-status="selectedStatus"
        v-model:search-query="searchQuery"
        @open-create="openCreateModal"
      />

      <!-- PPSkeleton Loading State -->
      <PPSkeleton :loading="isLoading" :animated="true">
        <template #template>
          <div class="category-grid">
            <div v-for="i in 6" :key="i" class="skeleton-card">
              <div style="display: flex; justify-content: space-between;">
                <PPSkeletonItem variant="rect" width="48px" height="48px" style="border-radius: 12px;" />
                <PPSkeletonItem variant="rect" width="60px" height="24px" style="border-radius: 12px;" />
              </div>
              <PPSkeletonItem variant="text" width="65%" height="20px" />
              <PPSkeletonItem variant="text" width="40%" height="12px" />
              <PPSkeletonItem variant="text" width="95%" />
              <PPSkeletonItem variant="text" width="80%" />
              <div style="display: flex; justify-content: space-between; margin-top: 10px; border-top: 1px solid #1f2937; padding-top: 12px;">
                <PPSkeletonItem variant="text" width="90px" />
                <PPSkeletonItem variant="rect" width="60px" height="24px" style="border-radius: 6px;" />
              </div>
            </div>
          </div>
        </template>

        <!-- Stateless Category Grid -->
        <div class="category-grid">
          <CategoryCard
            v-for="cat in filteredCategories"
            :key="cat.id"
            :category="cat"
            @toggle-status="toggleCategoryStatus"
            @edit="openEditModal"
            @delete="requestDeleteCategory"
          />
        </div>
      </PPSkeleton>

      <!-- Stateless Create / Edit Modal -->
      <CategoryModal
        :show="showCreateModal"
        :is-editing="!!editingCategory"
        :available-colors="availableColors"
        :category-form="categoryForm"
        @close="showCreateModal = false"
        @submit="handleSaveCategory"
      />

      <!-- UI Framework Confirmation Dialog -->
      <PPConfirm
        v-model="showDeleteConfirm"
        title="Delete Category"
        message="Are you sure you want to delete this category? Linked mini apps will be unassigned."
        confirm-text="Delete"
        cancel-text="Cancel"
        confirm-color="danger"
        @confirm="confirmDeleteCategory"
        @cancel="cancelDeleteCategory"
      />
    </div>
  </AdminLayout>
</template>

<style scoped>
.categories-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.category-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 20px;
}
</style>
