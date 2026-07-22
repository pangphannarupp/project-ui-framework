<template>
  <div class="pp-kanban-board">
    <div 
      v-for="(column, colIndex) in modelValue" 
      :key="column.id" 
      class="pp-kanban-column"
      @dragover.prevent="onDragOverColumn(colIndex)"
      @drop.prevent="onDropColumn(colIndex)"
    >
      <div class="pp-kanban-column-header">
        <h3 class="pp-kanban-column-title">{{ column.title }}</h3>
        <span class="pp-kanban-column-count">{{ column.cards.length }}</span>
      </div>

      <div class="pp-kanban-column-content">
        <transition-group name="kanban-list" tag="div" class="pp-kanban-list">
          <div
            v-for="(card, cardIndex) in column.cards"
            :key="card.id"
            class="pp-kanban-card-wrapper"
            draggable="true"
            @dragstart="onDragStart($event, colIndex, cardIndex)"
            @dragenter.prevent="onDragEnterCard(colIndex, cardIndex)"
            @dragover.prevent
            @drop.stop="onDropCard(colIndex, cardIndex)"
            @dragend="onDragEnd"
          >
            <!-- Allows completely custom cards -->
            <slot name="card" :card="card" :column="column">
              <div class="pp-kanban-default-card">
                {{ card.title || card.text || 'Card' }}
              </div>
            </slot>
          </div>
        </transition-group>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

export interface KanbanCard {
  id: string | number;
  [key: string]: any;
}

export interface KanbanColumn {
  id: string | number;
  title: string;
  cards: KanbanCard[];
  [key: string]: any;
}

const props = defineProps({
  modelValue: {
    type: Array as () => KanbanColumn[],
    required: true
  }
});

const emit = defineEmits(['update:modelValue', 'move-card']);

// Drag State
const draggedColIndex = ref<number | null>(null);
const draggedCardIndex = ref<number | null>(null);
const draggedCardData = ref<KanbanCard | null>(null);

const targetColIndex = ref<number | null>(null);
const targetCardIndex = ref<number | null>(null);

const onDragStart = (e: DragEvent, colIndex: number, cardIndex: number) => {
  if (e.dataTransfer) {
    e.dataTransfer.effectAllowed = 'move';
    // Firefox requires some data to be set
    e.dataTransfer.setData('text/plain', 'card');
    
    // Slight delay to allow DOM to render dragged ghost before hiding actual element
    setTimeout(() => {
      const el = e.target as HTMLElement;
      if (el && el.classList) el.classList.add('is-dragging');
    }, 0);
  }
  
  draggedColIndex.value = colIndex;
  draggedCardIndex.value = cardIndex;
  draggedCardData.value = props.modelValue[colIndex].cards[cardIndex];
};

const onDragEnterCard = (colIndex: number, cardIndex: number) => {
  if (draggedColIndex.value === null || draggedCardIndex.value === null) return;
  targetColIndex.value = colIndex;
  targetCardIndex.value = cardIndex;
  
  // Real-time swap for immediate feedback
  if (draggedColIndex.value === colIndex && draggedCardIndex.value === cardIndex) return;

  const newBoard = [...props.modelValue];
  const card = newBoard[draggedColIndex.value].cards.splice(draggedCardIndex.value, 1)[0];
  newBoard[colIndex].cards.splice(cardIndex, 0, card);

  draggedColIndex.value = colIndex;
  draggedCardIndex.value = cardIndex;

  emit('update:modelValue', newBoard);
};

const onDragOverColumn = (colIndex: number) => {
  if (draggedColIndex.value === null || draggedCardIndex.value === null) return;
  targetColIndex.value = colIndex;
  
  // If hovering over an empty column or the bottom of a column
  const column = props.modelValue[colIndex];
  if (column.cards.length === 0 || draggedColIndex.value !== colIndex) {
    const newBoard = [...props.modelValue];
    const card = newBoard[draggedColIndex.value].cards.splice(draggedCardIndex.value, 1)[0];
    newBoard[colIndex].cards.push(card);
    
    draggedColIndex.value = colIndex;
    draggedCardIndex.value = newBoard[colIndex].cards.length - 1;
    
    emit('update:modelValue', newBoard);
  }
};

const onDropCard = (_colIndex: number, _cardIndex: number) => {
  // Logic is handled in dragEnter for real-time swapping, 
  // but we emit move-card event on drop
  finishDrag();
};

const onDropColumn = (_colIndex: number) => {
  finishDrag();
};

const onDragEnd = (e: DragEvent) => {
  const el = e.target as HTMLElement;
  if (el && el.classList) el.classList.remove('is-dragging');
  finishDrag();
};

const finishDrag = () => {
  if (draggedCardData.value) {
    emit('move-card', {
      card: draggedCardData.value,
      toColumnId: targetColIndex.value !== null ? props.modelValue[targetColIndex.value]?.id : null
    });
  }
  draggedColIndex.value = null;
  draggedCardIndex.value = null;
  draggedCardData.value = null;
  targetColIndex.value = null;
  targetCardIndex.value = null;
};

</script>

<style scoped>
.pp-kanban-board {
  display: flex;
  gap: 16px;
  overflow-x: auto;
  padding-bottom: 8px;
  align-items: flex-start;
}

.pp-kanban-column {
  flex: 0 0 300px;
  background-color: #f3f4f6;
  border-radius: 8px;
  display: flex;
  flex-direction: column;
  max-height: 100%;
}

.pp-kanban-column-header {
  padding: 12px 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #e5e7eb;
}

.pp-kanban-column-title {
  margin: 0;
  font-size: 14px;
  font-weight: 600;
  color: #374151;
}

.pp-kanban-column-count {
  font-size: 12px;
  color: #6b7280;
  background: #e5e7eb;
  padding: 2px 8px;
  border-radius: 999px;
  font-weight: 500;
}

.pp-kanban-column-content {
  padding: 12px;
  overflow-y: auto;
  flex: 1;
  min-height: 100px;
}

.pp-kanban-list {
  display: flex;
  flex-direction: column;
  gap: 12px;
  min-height: 50px;
}

.pp-kanban-card-wrapper {
  cursor: grab;
  user-select: none;
}

.pp-kanban-card-wrapper:active {
  cursor: grabbing;
}

.pp-kanban-card-wrapper.is-dragging {
  opacity: 0.4;
}

.pp-kanban-default-card {
  background: white;
  padding: 12px 16px;
  border-radius: 6px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
  font-size: 14px;
  color: #1f2937;
  border: 1px solid #e5e7eb;
}

/* Animations */
.kanban-list-move {
  transition: transform 0.25s cubic-bezier(0.2, 0.8, 0.2, 1);
}
</style>
