<script setup lang="ts">
defineProps<{
  totalCount: number
  activeCount: number
  selectedStatus: 'All' | 'active' | 'inactive'
  searchQuery: string
}>()

const emit = defineEmits<{
  (e: 'update:selectedStatus', val: 'All' | 'active' | 'inactive'): void
  (e: 'update:searchQuery', val: string): void
  (e: 'openCreate'): void
}>()
</script>

<template>
  <div class="toolbar glass-panel">
    <div class="toolbar-left">
      <div class="category-segment-wrapper">
        <PPSegment
          :model-value="selectedStatus"
          variant="pill"
          @update:model-value="(val: any) => emit('update:selectedStatus', val)"
        >
          <PPSegmentButton value="All">
            All ({{ totalCount }})
          </PPSegmentButton>
          <PPSegmentButton value="active">
            Active ({{ activeCount }})
          </PPSegmentButton>
          <PPSegmentButton value="inactive">
            Inactive
          </PPSegmentButton>
        </PPSegment>
      </div>
    </div>

    <div class="toolbar-right">
      <div class="search-box">
        <PPInput
          :model-value="searchQuery"
          placeholder="Search categories..."
          @update:model-value="(val: string) => emit('update:searchQuery', val)"
        />
      </div>

      <PPButton variant="primary" size="small" @click="emit('openCreate')">
        <span>+ Register Category</span>
      </PPButton>
    </div>
  </div>
</template>

<style scoped>
.toolbar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 14px;
  gap: 16px;
}

.toolbar-left {
  display: flex;
  align-items: center;
}

.category-segment-wrapper :deep(.pp-segment) {
  background-color: #0f172a !important;
  border: 1px solid #1f2937 !important;
  padding: 3px !important;
}

.category-segment-wrapper :deep(.pp-segment-button) {
  padding: 6px 14px !important;
  font-size: 13px !important;
  color: #94a3b8 !important;
  border-radius: 20px !important;
}

.category-segment-wrapper :deep(.pp-segment-button--active) {
  color: #ffffff !important;
  font-weight: 600 !important;
}

.category-segment-wrapper :deep(.pp-segment-indicator) {
  background-color: #2563eb !important;
  border-radius: 20px !important;
  box-shadow: 0 2px 8px rgba(37, 99, 235, 0.4) !important;
}

.toolbar-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.search-box {
  width: 240px;
}
</style>
