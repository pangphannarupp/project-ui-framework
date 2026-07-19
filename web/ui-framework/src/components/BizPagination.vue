<template>
  <div class="biz-pagination" :class="[`biz-pagination--${size}`]">
    <div v-if="showSizeChanger && sizeChangerPosition === 'left'" class="biz-pagination-size-changer is-left">
      <select :value="pageSize" @change="onPageSizeChange" class="biz-pagination-select">
        <option v-for="sizeOption in pageSizes" :key="sizeOption" :value="sizeOption">
          {{ sizeOption }} / page
        </option>
      </select>
    </div>

    <button v-if="showFirstLast" class="biz-pagination-btn" :class="[`is-${variant}`, `is-${shape}`]" :disabled="currentPage === 1" @click="changePage(1)">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="11 17 6 12 11 7"></polyline>
        <polyline points="18 17 13 12 18 7"></polyline>
      </svg>
    </button>
    <button class="biz-pagination-btn" :class="[`is-${variant}`, `is-${shape}`]" :disabled="currentPage === 1" @click="changePage(currentPage - 1)">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="15 18 9 12 15 6"></polyline>
      </svg>
    </button>
    
    <div class="biz-pagination-pages">
      <button 
        v-for="page in pages" 
        :key="page" 
        class="biz-pagination-page" 
        :class="[{ 'is-active': page === currentPage, 'is-ellipsis': page === '...' }, `is-${variant}`, `is-${shape}`]"
        :disabled="page === '...'"
        @click="typeof page === 'number' ? changePage(page) : null"
      >
        {{ page }}
      </button>
    </div>

    <button class="biz-pagination-btn" :class="[`is-${variant}`, `is-${shape}`]" :disabled="currentPage === totalPages" @click="changePage(currentPage + 1)">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="9 18 15 12 9 6"></polyline>
      </svg>
    </button>
    <button v-if="showFirstLast" class="biz-pagination-btn" :class="[`is-${variant}`, `is-${shape}`]" :disabled="currentPage === totalPages" @click="changePage(totalPages)">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="13 17 18 12 13 7"></polyline>
        <polyline points="6 17 11 12 6 7"></polyline>
      </svg>
    </button>

    <div v-if="showSizeChanger && sizeChangerPosition === 'right'" class="biz-pagination-size-changer is-right">
      <select :value="pageSize" @change="onPageSizeChange" class="biz-pagination-select">
        <option v-for="sizeOption in pageSizes" :key="sizeOption" :value="sizeOption">
          {{ sizeOption }} / page
        </option>
      </select>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps({
  total: { type: Number, required: true },
  pageSize: { type: Number, default: 10 },
  currentPage: { type: Number, default: 1 },
  variant: { type: String, default: 'outline' }, // outline, solid, ghost
  shape: { type: String, default: 'rounded' }, // rounded, circle
  size: { type: String, default: 'normal' }, // small, normal, large
  showSizeChanger: { type: Boolean, default: false },
  pageSizes: { type: Array as () => number[], default: () => [10, 20, 50, 100] },
  sizeChangerPosition: { type: String, default: 'left' }, // left, right
  showFirstLast: { type: Boolean, default: false }
});

const emit = defineEmits(['update:currentPage', 'update:pageSize', 'change']);

const totalPages = computed(() => Math.ceil(props.total / props.pageSize) || 1);

const pages = computed(() => {
  const current = props.currentPage;
  const last = totalPages.value;
  const delta = 2;
  const left = current - delta;
  const right = current + delta + 1;
  const range = [];
  const rangeWithDots = [];
  let l;

  for (let i = 1; i <= last; i++) {
    if (i === 1 || i === last || (i >= left && i < right)) {
      range.push(i);
    }
  }

  for (let i of range) {
    if (l) {
      if (i - l === 2) {
        rangeWithDots.push(l + 1);
      } else if (i - l !== 1) {
        rangeWithDots.push('...');
      }
    }
    rangeWithDots.push(i);
    l = i;
  }

  return rangeWithDots;
});

const changePage = (page: number) => {
  if (page >= 1 && page <= totalPages.value && page !== props.currentPage) {
    emit('update:currentPage', page);
    emit('change', page);
  }
};

const onPageSizeChange = (event: Event) => {
  const target = event.target as HTMLSelectElement;
  const newSize = parseInt(target.value, 10);
  emit('update:pageSize', newSize);
  // Optional: reset to page 1 when size changes
  emit('update:currentPage', 1);
};
</script>

<style scoped>
.biz-pagination {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-wrap: wrap;
}
.biz-pagination-size-changer.is-left {
  margin-right: 8px;
}
.biz-pagination-size-changer.is-right {
  margin-left: 8px;
}
.biz-pagination-select {
  padding: 4px 8px;
  border-radius: 4px;
  border: 1px solid #e0e0e0;
  background: white;
  color: #333;
  font-size: 14px;
  height: 32px;
  outline: none;
  cursor: pointer;
}
.biz-pagination-select:focus {
  border-color: var(--biz-primary-variant, #1a2a5e);
}

.biz-pagination-btn, .biz-pagination-page {
  display: flex;
  align-items: center;
  justify-content: center;
  min-width: 32px;
  height: 32px;
  background: white;
  cursor: pointer;
  color: #333;
  font-size: 14px;
  transition: all 0.2s;
  padding: 0 4px;
}

/* Sizes */
.biz-pagination--small .biz-pagination-btn, .biz-pagination--small .biz-pagination-page {
  min-width: 28px;
  height: 28px;
  font-size: 12px;
}
.biz-pagination--large .biz-pagination-btn, .biz-pagination--large .biz-pagination-page {
  min-width: 40px;
  height: 40px;
  font-size: 16px;
}

/* Shapes */
.biz-pagination-btn.is-rounded, .biz-pagination-page.is-rounded {
  border-radius: 4px;
}
.biz-pagination-btn.is-circle, .biz-pagination-page.is-circle {
  border-radius: 50%;
  padding: 0;
}

/* Variants: Outline */
.biz-pagination-btn.is-outline, .biz-pagination-page.is-outline {
  border: 1px solid #e0e0e0;
}
.biz-pagination-btn.is-outline:hover:not(:disabled), .biz-pagination-page.is-outline:hover:not(.is-active):not(.is-ellipsis) {
  border-color: var(--biz-primary-variant, #1a2a5e);
  color: var(--biz-primary-variant, #1a2a5e);
}
.biz-pagination-page.is-outline.is-active {
  background: var(--biz-primary-variant, #1a2a5e);
  border-color: var(--biz-primary-variant, #1a2a5e);
  color: white;
}

/* Variants: Solid */
.biz-pagination-btn.is-solid, .biz-pagination-page.is-solid {
  border: none;
  background: #f4f5f8;
}
.biz-pagination-btn.is-solid:hover:not(:disabled), .biz-pagination-page.is-solid:hover:not(.is-active):not(.is-ellipsis) {
  background: #e6f0ff;
  color: var(--biz-primary-variant, #1a2a5e);
}
.biz-pagination-page.is-solid.is-active {
  background: var(--biz-primary-variant, #1a2a5e);
  color: white;
}

/* Variants: Ghost */
.biz-pagination-btn.is-ghost, .biz-pagination-page.is-ghost {
  border: none;
  background: transparent;
}
.biz-pagination-btn.is-ghost:hover:not(:disabled), .biz-pagination-page.is-ghost:hover:not(.is-active):not(.is-ellipsis) {
  background: #f4f5f8;
  color: var(--biz-primary-variant, #1a2a5e);
}
.biz-pagination-page.is-ghost.is-active {
  font-weight: bold;
  color: var(--biz-primary-variant, #1a2a5e);
}

.biz-pagination-btn:disabled {
  opacity: 0.5;
  cursor: not-allowed;
  background: #f5f5f5 !important;
  border-color: #e0e0e0 !important;
  color: #999 !important;
}

.biz-pagination-page.is-ellipsis {
  border: none !important;
  background: transparent !important;
  cursor: default;
}
.biz-pagination-pages {
  display: flex;
  gap: 4px;
}
.biz-pagination-btn svg {
  width: 16px;
  height: 16px;
}
</style>
