<template>
  <div 
    class="pp-draggable-grid" 
    :style="gridStyle"
    @dragenter.prevent
    @dragover.prevent
    @drop="onDropEmpty($event)"
  >
    <div 
      v-for="(item, index) in modelValue" 
      :key="item[itemKey] || index"
      class="pp-draggable-item"
      :class="{ 'is-dragging': dragIndex === index, 'is-drag-over': dragOverIndex === index }"
      draggable="true"
      @dragstart="onDragStart($event, index)"
      @dragenter.prevent="onDragEnter($event, index)"
      @dragover.prevent="onDragOver($event, index)"
      @dragleave="onDragLeave($event, index)"
      @drop.stop="onDrop($event, index)"
      @dragend="onDragEnd"
    >
      <slot name="item" :item="item" :index="index"></slot>
    </div>
    <div v-if="modelValue.length === 0" class="pp-draggable-empty-state">
      <slot name="empty">
        No items. Drag and drop items here.
      </slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const props = defineProps({
  modelValue: {
    type: Array as () => any[],
    default: () => []
  },
  columns: {
    type: Number,
    default: 3
  },
  gap: {
    type: String,
    default: '16px'
  },
  itemKey: {
    type: String,
    default: 'id'
  },
  acceptExternal: {
    type: Boolean,
    default: true
  }
});

const emit = defineEmits(['update:modelValue', 'drop-external']);

const dragIndex = ref<number | null>(null);
const dragOverIndex = ref<number | null>(null);

const gridStyle = computed(() => {
  return {
    display: 'grid',
    gridTemplateColumns: `repeat(${props.columns}, 1fr)`,
    gap: props.gap,
    minHeight: props.modelValue.length === 0 ? '100px' : 'auto'
  };
});

const onDragStart = (e: DragEvent, index: number) => {
  if (e.dataTransfer) {
    e.dataTransfer.effectAllowed = 'move';
    // Set a plain text marker to identify internal drags
    e.dataTransfer.setData('text/plain', `internal_${index}`);
  }
  dragIndex.value = index;
};

const onDragEnter = (_e: DragEvent, index: number) => {
  if (dragIndex.value !== index) {
    dragOverIndex.value = index;
  }
};

const onDragOver = (_e: DragEvent, index: number) => {
  if (dragIndex.value !== index) {
    dragOverIndex.value = index;
  }
};

const onDragLeave = (_e: DragEvent, index: number) => {
  if (dragOverIndex.value === index) {
    dragOverIndex.value = null;
  }
};

const onDrop = (e: DragEvent, index: number) => {
  const data = e.dataTransfer?.getData('text/plain');
  
  // Handle internal reordering
  if (data && data.startsWith('internal_')) {
    const sourceIndex = parseInt(data.replace('internal_', ''), 10);
    if (!isNaN(sourceIndex) && sourceIndex !== index) {
      const newItems = [...props.modelValue];
      const [movedItem] = newItems.splice(sourceIndex, 1);
      newItems.splice(index, 0, movedItem);
      emit('update:modelValue', newItems);
    }
  } 
  // Handle external drops
  else if (props.acceptExternal && e.dataTransfer) {
    const jsonPayload = e.dataTransfer.getData('application/json');
    if (jsonPayload) {
      try {
        const item = JSON.parse(jsonPayload);
        const newItems = [...props.modelValue];
        newItems.splice(index, 0, item);
        emit('update:modelValue', newItems);
        emit('drop-external', { item, index });
      } catch (err) {
        console.error('Failed to parse dropped data', err);
      }
    }
  }
  
  resetDragState();
};

const onDropEmpty = (e: DragEvent) => {
  if (props.modelValue.length > 0) return; // Only apply if empty
  
  if (props.acceptExternal && e.dataTransfer) {
    const jsonPayload = e.dataTransfer.getData('application/json');
    if (jsonPayload) {
      try {
        const item = JSON.parse(jsonPayload);
        const newItems = [...props.modelValue, item];
        emit('update:modelValue', newItems);
        emit('drop-external', { item, index: 0 });
      } catch (err) {
        console.error('Failed to parse dropped data', err);
      }
    }
  }
  resetDragState();
};

const onDragEnd = () => {
  resetDragState();
};

const resetDragState = () => {
  dragIndex.value = null;
  dragOverIndex.value = null;
};
</script>

<style scoped>
.pp-draggable-grid {
  position: relative;
  width: 100%;
}

.pp-draggable-item {
  cursor: grab;
  transition: transform 0.2s cubic-bezier(0.2, 0, 0, 1), opacity 0.2s;
  background: transparent;
  user-select: none;
}

.pp-draggable-item:active {
  cursor: grabbing;
}

.pp-draggable-item.is-dragging {
  opacity: 0.4;
  transform: scale(0.95);
}

.pp-draggable-item.is-drag-over {
  outline: 2px dashed #0056b3;
  outline-offset: 2px;
  border-radius: 4px;
}

.pp-draggable-empty-state {
  grid-column: 1 / -1;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px dashed #ccc;
  border-radius: 8px;
  padding: 32px;
  color: #999;
  font-size: 14px;
  background-color: #fafafa;
}
</style>
