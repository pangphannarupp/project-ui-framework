<script setup lang="ts">
import AdminLayout from '../layouts/AdminLayout.vue'
import { useTagsViewModel } from '../viewmodels/useTagsViewModel'
import TagHeaderStats from '../components/tags/TagHeaderStats.vue'
import TagToolbar from '../components/tags/TagToolbar.vue'
import TagCard from '../components/tags/TagCard.vue'
import TagModal from '../components/tags/TagModal.vue'

const {
  tags,
  isLoading,
  searchQuery,
  selectedFilter,
  showModal,
  isEditing,
  tagForm,
  colorPalette,
  availableIcons,
  filteredTags,
  totalTagsCount,
  featuredTagsCount,
  showDeleteConfirm,
  openCreateModal,
  openEditModal,
  handleSaveTag,
  requestDeleteTag,
  confirmDeleteTag,
  cancelDeleteTag,
  toggleFeatured
} = useTagsViewModel()

const handleNameInput = () => {
  if (!isEditing.value && tagForm.value.name) {
    tagForm.value.slug = tagForm.value.name
      .toLowerCase()
      .trim()
      .replace(/[^\w\s-]/g, '')
      .replace(/[\s_-]+/g, '-')
      .replace(/^-+|-+$/g, '')
  }
}
</script>

<template>
  <AdminLayout>
    <div class="tags-view">
      <!-- Stateless Header Stats -->
      <TagHeaderStats
        :total-tags="totalTagsCount"
        :featured-count="featuredTagsCount"
      />

      <!-- Stateless Toolbar -->
      <TagToolbar
        :total-count="totalTagsCount"
        :featured-count="featuredTagsCount"
        v-model:selected-filter="selectedFilter"
        v-model:search-query="searchQuery"
        @open-create="openCreateModal"
      />

      <!-- PPSkeleton Loading State -->
      <PPSkeleton :loading="isLoading" :animated="true">
        <template #template>
          <div class="tags-grid">
            <div v-for="i in 6" :key="i" class="skeleton-card">
              <div style="display: flex; justify-content: space-between;">
                <PPSkeletonItem variant="rect" width="100px" height="28px" style="border-radius: 8px;" />
                <PPSkeletonItem variant="rect" width="60px" height="20px" style="border-radius: 6px;" />
              </div>
              <PPSkeletonItem variant="text" width="50%" height="14px" />
              <PPSkeletonItem variant="text" width="95%" />
              <PPSkeletonItem variant="text" width="70%" />
              <div style="display: flex; justify-content: space-between; margin-top: 10px; border-top: 1px solid #1f2937; padding-top: 12px;">
                <PPSkeletonItem variant="text" width="80px" />
                <PPSkeletonItem variant="rect" width="70px" height="24px" style="border-radius: 6px;" />
              </div>
            </div>
          </div>
        </template>

        <!-- Stateless Tags Grid -->
        <div class="tags-grid">
          <TagCard
            v-for="t in filteredTags"
            :key="t.id"
            :tag="t"
            @toggle-featured="toggleFeatured"
            @edit="openEditModal"
            @delete="requestDeleteTag"
          />
        </div>
      </PPSkeleton>

      <!-- Stateless Create / Edit Modal -->
      <TagModal
        :show="showModal"
        :is-editing="isEditing"
        :color-palette="colorPalette"
        :available-icons="availableIcons"
        :tag-form="tagForm"
        @close="showModal = false"
        @submit="handleSaveTag"
        @name-input="handleNameInput"
      />

      <!-- UI Framework Confirmation Dialog -->
      <PPConfirm
        v-model="showDeleteConfirm"
        title="Delete Tag"
        message="Are you sure you want to delete this search tag? It will be removed from all linked applications."
        confirm-text="Delete"
        cancel-text="Cancel"
        confirm-color="danger"
        @confirm="confirmDeleteTag"
        @cancel="cancelDeleteTag"
      />
    </div>
  </AdminLayout>
</template>

<style scoped>
.tags-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.tags-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(290px, 1fr));
  gap: 20px;
}
</style>
