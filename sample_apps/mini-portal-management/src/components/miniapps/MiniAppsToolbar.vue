<script setup lang="ts">
defineProps<{
  categories: string[]
  selectedCategory: string
  searchQuery: string
  isReorderMode: boolean
  viewMode: 'grid' | 'table'
}>()

const emit = defineEmits<{
  (e: 'update:selectedCategory', val: string): void
  (e: 'update:searchQuery', val: string): void
  (e: 'update:viewMode', val: 'grid' | 'table'): void
  (e: 'toggleReorder'): void
  (e: 'openCreate'): void
}>()
</script>

<template>
  <div class="toolbar glass-panel">
    <div class="toolbar-left">
      <div class="category-filter-select">
        <PPSelect
          :model-value="selectedCategory"
          :options="categories.map(c => ({ label: c === 'All' ? 'All Categories' : c, value: c }))"
          placeholder="Filter by Category"
          @update:model-value="(val: string) => emit('update:selectedCategory', val)"
        />
      </div>
    </div>

    <div class="toolbar-right">
      <div class="search-box">
        <PPInput
          :model-value="searchQuery"
          placeholder="Filter mini apps or tags..."
          @update:model-value="(val: string) => emit('update:searchQuery', val)"
        />
      </div>

      <PPButton
        :variant="isReorderMode ? 'primary' : 'outline'"
        size="small"
        @click="emit('toggleReorder')"
      >
        <span>{{ isReorderMode ? '✓ Done Reordering' : '⇅ Reorder Apps' }}</span>
      </PPButton>

      <div class="view-switch">
        <button :class="{ 'active': viewMode === 'grid' }" @click="emit('update:viewMode', 'grid')">▦</button>
        <button :class="{ 'active': viewMode === 'table' }" @click="emit('update:viewMode', 'table')">☰</button>
      </div>

      <PPButton variant="primary" size="small" @click="emit('openCreate')">
        <span>+ Register New App</span>
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
  position: relative;
  z-index: 50;
}

.toolbar-left {
  display: flex;
  align-items: center;
  position: relative;
  z-index: 55;
}

.category-filter-select {
  width: 220px;
  position: relative;
  z-index: 60;
}

.toolbar-right {
  display: flex;
  align-items: center;
  gap: 12px;
}

.search-box {
  width: 240px;
}

.view-switch {
  display: flex;
  background: #0f172a;
  padding: 3px;
  border-radius: 8px;
  border: 1px solid #1f2937;
  gap: 2px;
}

.view-switch button {
  background: transparent;
  border: none;
  color: #94a3b8;
  padding: 6px 12px;
  border-radius: 6px;
  cursor: pointer;
  font-size: 14px;
  transition: all 0.2s;
}

.view-switch button.active {
  background: #1f2937;
  color: #60a5fa;
}
</style>
