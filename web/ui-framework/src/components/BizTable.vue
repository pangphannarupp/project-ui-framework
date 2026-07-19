<template>
  <div class="biz-table-wrapper">
    <div class="biz-table-container">
      <table 
        class="biz-table" 
        :class="{ 
          'is-striped': striped, 
          'is-bordered': bordered, 
          'is-hoverable': hover,
          'is-compact': compact
        }"
      >
        <thead>
          <tr>
            <th v-if="selectable" style="width: 40px; text-align: center;">
              <input v-if="multiple" type="checkbox" :checked="isAllSelected" @change="toggleAll" class="biz-table-checkbox">
            </th>
            <th v-if="expandable" style="width: 40px; text-align: center;"></th>
            <th 
              v-for="col in columns" 
              :key="col.key" 
              :style="{ width: col.width, textAlign: col.align || 'left', cursor: col.sortable ? 'pointer' : 'default' }"
              :class="{ 'is-sortable': col.sortable }"
              @click="col.sortable && handleSort(col.key)"
            >
              <div class="biz-table-th-content">
                {{ col.title }}
                <span v-if="col.sortable" class="biz-table-sort-icon">
                  <svg v-if="sortKey !== col.key || !sortOrder" viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="icon-sort"><path d="M7 15l5 5 5-5"/><path d="M7 9l5-5 5 5"/></svg>
                  <svg v-else-if="sortOrder === 'asc'" viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="icon-sort-active"><path d="M7 15l5 5 5-5"/><path d="M7 9l5-5 5 5"/><path d="M7 9l5-5 5 5" stroke="#1a2a5e"/></svg>
                  <svg v-else viewBox="0 0 24 24" width="14" height="14" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round" class="icon-sort-active"><path d="M7 15l5 5 5-5"/><path d="M7 9l5-5 5 5"/><path d="M7 15l5 5 5-5" stroke="#1a2a5e"/></svg>
                </span>
              </div>
            </th>
          </tr>
        </thead>
        <tbody>
          <template v-if="loading">
            <tr v-for="i in skeletonRows" :key="`skeleton-${i}`">
              <td v-if="selectable" style="text-align: center;">
                <div class="biz-skeleton-box biz-skeleton-checkbox"></div>
              </td>
              <td v-for="col in columns" :key="`skeleton-col-${col.key}`">
                <div class="biz-skeleton-box" :style="{ width: col.width || '80%' }"></div>
              </td>
            </tr>
          </template>
          <template v-else>
            <tr v-if="!paginatedData.length">
              <td :colspan="selectable ? columns.length + 1 : columns.length" class="biz-table-empty">
                No data available
              </td>
            </tr>
            <template v-for="(row, index) in paginatedData" :key="row[rowKey] || index">
              <tr 
                :class="{ 'is-selected': isRowSelected(row), 'is-expanded': isRowExpanded(row) }"
                @click="handleRowClick(row)"
              >
                <td v-if="selectable" style="text-align: center;" @click.stop>
                <input 
                  :type="multiple ? 'checkbox' : 'radio'" 
                  :name="multiple ? '' : 'biz-table-radio'"
                  :checked="isRowSelected(row)" 
                  @change="toggleRowSelection(row)"
                  class="biz-table-checkbox"
                >
              </td>
              <td v-if="expandable" style="text-align: center;" @click.stop="toggleRowExpand(row)">
                <div class="biz-table-expand-icon" :class="{ 'is-expanded': isRowExpanded(row) }">
                  <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round"><polyline points="9 18 15 12 9 6"></polyline></svg>
                </div>
              </td>
              <template v-for="(col, colIndex) in columns" :key="col.key">
                <td 
                  v-if="getCellSpan(row, col, index, colIndex).rowspan !== 0 && getCellSpan(row, col, index, colIndex).colspan !== 0"
                  :rowspan="getCellSpan(row, col, index, colIndex).rowspan"
                  :colspan="getCellSpan(row, col, index, colIndex).colspan"
                  :style="{ textAlign: col.align || 'left' }"
                >
                  <slot :name="col.key" :row="row" :index="index">
                    {{ row[col.key] }}
                  </slot>
                </td>
              </template>
            </tr>
            <tr 
              v-if="expandable && isRowExpanded(row)" 
              class="biz-table-expanded-row"
            >
              <td :colspan="totalColumnsCount" class="biz-table-expanded-cell">
                <slot name="expanded" :row="row" :index="index"></slot>
              </td>
            </tr>
          </template>
        </template>
        </tbody>
      </table>
    </div>
    
    <div v-if="pagination && data.length > 0" class="biz-table-pagination" :class="`is-align-${paginationAlign}`">
      <BizPagination 
        :total="data.length" 
        :pageSize="internalPageSize" 
        :currentPage="currentPage" 
        :variant="paginationVariant"
        :shape="paginationShape"
        :size="paginationSize"
        :showSizeChanger="showSizeChanger"
        :pageSizes="pageSizes"
        :sizeChangerPosition="sizeChangerPosition"
        :showFirstLast="showFirstLast"
        @update:currentPage="currentPage = $event"
        @update:pageSize="handlePageSizeChange"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import BizPagination from './BizPagination.vue';

const props = defineProps({
  columns: {
    type: Array as () => Array<{ key: string, title: string, width?: string, align?: 'left' | 'center' | 'right', sortable?: boolean }>,
    required: true
  },
  data: {
    type: Array as () => Array<any>,
    default: () => []
  },
  pagination: {
    type: Boolean,
    default: false
  },
  pageSize: {
    type: Number,
    default: 10
  },
  striped: { type: Boolean, default: false },
  bordered: { type: Boolean, default: false },
  hover: { type: Boolean, default: true },
  compact: { type: Boolean, default: false },
  paginationVariant: { type: String, default: 'outline' },
  paginationShape: { type: String, default: 'rounded' },
  paginationSize: { type: String, default: 'normal' },
  showSizeChanger: { type: Boolean, default: false },
  pageSizes: { type: Array as () => number[], default: () => [5, 10, 20, 50, 100] },
  paginationAlign: { type: String, default: 'right' }, // left, center, right
  sizeChangerPosition: { type: String, default: 'left' }, // left, right
  showFirstLast: { type: Boolean, default: false },
  selectable: { type: Boolean, default: false },
  multiple: { type: Boolean, default: false },
  rowKey: { type: String, default: 'id' },
  modelValue: { type: Array as () => any[], default: () => [] },
  loading: { type: Boolean, default: false },
  skeletonRows: { type: Number, default: 5 },
  expandable: { type: Boolean, default: false },
  spanMethod: { type: Function, default: undefined }
});

const emit = defineEmits(['update:pageSize', 'update:modelValue', 'selection-change', 'row-click', 'sort-change', 'expand-change']);

const currentPage = ref(1);
const internalPageSize = ref(props.pageSize);
const internalSelected = ref<any[]>([...props.modelValue]);
const expandedRowKeys = ref<any[]>([]);

const sortKey = ref('');
const sortOrder = ref<'asc'|'desc'|''>('');

// Watch for prop changes in case parent updates it
import { watch } from 'vue';
watch(() => props.pageSize, (newVal) => {
  internalPageSize.value = newVal;
});
watch(() => props.modelValue, (newVal) => {
  internalSelected.value = [...newVal];
});

const handlePageSizeChange = (newSize: number) => {
  internalPageSize.value = newSize;
  emit('update:pageSize', newSize);
};

const totalColumnsCount = computed(() => {
  let count = props.columns.length;
  if (props.selectable) count++;
  if (props.expandable) count++;
  return count;
});

const isRowExpanded = (row: any) => {
  return expandedRowKeys.value.includes(row[props.rowKey]);
};

const toggleRowExpand = (row: any) => {
  const key = row[props.rowKey];
  const index = expandedRowKeys.value.indexOf(key);
  if (index > -1) {
    expandedRowKeys.value.splice(index, 1);
  } else {
    expandedRowKeys.value.push(key);
  }
  emit('expand-change', { row, expanded: expandedRowKeys.value.includes(key), expandedRows: expandedRowKeys.value });
};

const isRowSelected = (row: any) => {
  return internalSelected.value.some(item => item[props.rowKey] === row[props.rowKey]);
};

const toggleRowSelection = (row: any) => {
  if (!props.selectable) return;
  
  if (props.multiple) {
    const index = internalSelected.value.findIndex(item => item[props.rowKey] === row[props.rowKey]);
    if (index > -1) {
      internalSelected.value.splice(index, 1);
    } else {
      internalSelected.value.push(row);
    }
  } else {
    internalSelected.value = [row];
  }
  
  emit('update:modelValue', internalSelected.value);
  emit('selection-change', internalSelected.value);
};

const handleRowClick = (row: any) => {
  emit('row-click', row);
  if (props.selectable) {
    toggleRowSelection(row);
  }
};

const isAllSelected = computed(() => {
  if (!props.data.length || !paginatedData.value.length) return false;
  return paginatedData.value.every(row => isRowSelected(row));
});

const toggleAll = (event: Event) => {
  if (!props.selectable || !props.multiple) return;
  
  const target = event.target as HTMLInputElement;
  const isChecked = target.checked;
  
  if (isChecked) {
    // Add all current page items that aren't already selected
    paginatedData.value.forEach(row => {
      if (!isRowSelected(row)) {
        internalSelected.value.push(row);
      }
    });
  } else {
    // Remove all current page items
    const pageKeys = paginatedData.value.map(row => row[props.rowKey]);
    internalSelected.value = internalSelected.value.filter(
      item => !pageKeys.includes(item[props.rowKey])
    );
  }
  
  emit('update:modelValue', internalSelected.value);
  emit('selection-change', internalSelected.value);
};

const handleSort = (key: string) => {
  if (sortKey.value === key) {
    if (sortOrder.value === 'asc') sortOrder.value = 'desc';
    else if (sortOrder.value === 'desc') sortOrder.value = '';
    else sortOrder.value = 'asc';
  } else {
    sortKey.value = key;
    sortOrder.value = 'asc';
  }
  
  if (!sortOrder.value) {
    sortKey.value = '';
  }
  
  emit('sort-change', { key: sortKey.value, order: sortOrder.value });
  // Reset to page 1 when sorting changes
  if (props.pagination) currentPage.value = 1;
};

const sortedData = computed(() => {
  if (!sortKey.value || !sortOrder.value) return props.data;
  
  return [...props.data].sort((a, b) => {
    const valA = a[sortKey.value];
    const valB = b[sortKey.value];
    
    if (valA === valB) return 0;
    
    const modifier = sortOrder.value === 'asc' ? 1 : -1;
    
    if (typeof valA === 'number' && typeof valB === 'number') {
      return (valA - valB) * modifier;
    }
    
    return String(valA).localeCompare(String(valB)) * modifier;
  });
});

const getCellSpan = (row: any, column: any, rowIndex: number, columnIndex: number) => {
  if (typeof props.spanMethod === 'function') {
    const result = props.spanMethod({ row, column, rowIndex, columnIndex });
    if (Array.isArray(result)) {
      return { rowspan: result[0], colspan: result[1] };
    } else if (typeof result === 'object' && result !== null) {
      return {
        rowspan: result.rowspan !== undefined ? result.rowspan : 1,
        colspan: result.colspan !== undefined ? result.colspan : 1
      };
    }
  }
  return { rowspan: 1, colspan: 1 };
};

const paginatedData = computed(() => {
  const dataToUse = sortedData.value;
  if (!props.pagination) return dataToUse;
  const start = (currentPage.value - 1) * internalPageSize.value;
  const end = start + internalPageSize.value;
  return dataToUse.slice(start, end);
});
</script>

<style scoped>
.biz-table-wrapper {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.biz-table-container {
  width: 100%;
  overflow-x: auto;
  border-radius: 8px;
  border: 1px solid #e0e0e0;
}

.biz-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
  font-size: 14px;
}

.biz-table th {
  background-color: #f4f5f8;
  color: #333;
  font-weight: 600;
  padding: 12px 16px;
  border-bottom: 1px solid #e0e0e0;
}

.biz-table td {
  padding: 12px 16px;
  border-bottom: 1px solid #e0e0e0;
  color: #333;
}

.biz-table tbody tr:last-child td {
  border-bottom: none;
}

.biz-table tbody tr:hover {
  background-color: #fafafa;
}

.biz-table tbody tr.is-selected {
  background-color: #e6f0ff;
}

.biz-table-expanded-cell {
  padding: 16px;
  background-color: #fdfdfd;
  border-bottom: 1px solid #e0e0e0;
}

.biz-table-expand-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: #999;
  transition: transform 0.2s;
  width: 24px;
  height: 24px;
  border-radius: 4px;
  margin: 0 auto;
}
.biz-table-expand-icon:hover {
  background-color: #f0f0f0;
}
.biz-table-expand-icon.is-expanded {
  transform: rotate(90deg);
}

.biz-table-empty {
  text-align: center;
  padding: 32px 16px;
  color: #999;
}

/* Skeleton Loading */
.biz-skeleton-box {
  height: 16px;
  background: #f0f0f0;
  border-radius: 4px;
  animation: biz-skeleton-pulse 1.5s infinite ease-in-out;
}
.biz-skeleton-checkbox {
  width: 16px;
  height: 16px;
  margin: 0 auto;
}
@keyframes biz-skeleton-pulse {
  0% { opacity: 0.6; }
  50% { opacity: 1; }
  100% { opacity: 0.6; }
}

/* Styles */
.biz-table.is-striped tbody tr:nth-child(even) {
  background-color: #f9f9f9;
}

.biz-table.is-hoverable tbody tr:hover {
  background-color: #f4f5f8;
}

.biz-table.is-bordered th, 
.biz-table.is-bordered td {
  border: 1px solid #e0e0e0;
}
.biz-table.is-bordered {
  border-top: none;
}

.biz-table.is-compact th, 
.biz-table.is-compact td {
  padding: 8px 12px;
  font-size: 13px;
}

.biz-table-checkbox {
  cursor: pointer;
  width: 16px;
  height: 16px;
}

.biz-table-th-content {
  display: flex;
  align-items: center;
  gap: 4px;
}
.biz-table-sort-icon {
  display: flex;
  align-items: center;
  color: #ccc;
  transition: color 0.2s;
}
.biz-table th.is-sortable:hover {
  background-color: #f4f5f8;
}
.biz-table th.is-sortable:hover .icon-sort {
  color: #999;
}
.biz-table-sort-icon .icon-sort-active {
  color: #999; /* Base color for unselected arrow */
}

.biz-table-pagination {
  display: flex;
}
.biz-table-pagination.is-align-left {
  justify-content: flex-start;
}
.biz-table-pagination.is-align-center {
  justify-content: center;
}
.biz-table-pagination.is-align-right {
  justify-content: flex-end;
}
</style>
