<template>
  <div class="biz-account-reorder-list" ref="listRef">
    <div 
      v-for="(item, index) in internalAccounts" 
      :key="item.id || item.accountNumber" 
      class="reorder-item"
      :class="{ 'is-dragging': draggedIndex === index }"
      :style="getItemStyle(index)"
    >
      <slot 
        name="item" 
        :item="item" 
        :index="index"
        :is-reorder-mode="isReorderMode"
        :on-update-hidden="(val: boolean) => onUpdateHidden(index, val)"
        :drag-listeners="{
          touchstart: (e: TouchEvent) => onTouchStart(e, index),
          mousedown: (e: MouseEvent) => onMouseDown(e, index)
        }"
      >
        <BizAccountListCard 
          :accountName="item.accountName || item.name"
          :accountNumber="item.accountNumber || item.number"
          :balance="item.balance"
          :currency="item.currency"
          :type="item.type"
          :isHidden="item.isHidden"
          @update:isHidden="val => onUpdateHidden(index, val)"
          @action-click="() => !isReorderMode && $emit('action-click', item)"
          @click="() => !isReorderMode && $emit('item-click', item)"
        >
          <template #action>
            <div 
              v-if="isReorderMode" 
              class="drag-handle" 
              @touchstart.stop.prevent="(e) => onTouchStart(e, index)"
              @mousedown.stop.prevent="(e) => onMouseDown(e, index)"
            >
              <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="4" y1="12" x2="20" y2="12"></line>
                <line x1="4" y1="6" x2="20" y2="6"></line>
                <line x1="4" y1="18" x2="20" y2="18"></line>
              </svg>
            </div>
            <button v-else class="action-btn" @click.stop="$emit('action-click', item)">
              <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <circle cx="12" cy="5" r="1"></circle>
                <circle cx="12" cy="12" r="1"></circle>
                <circle cx="12" cy="19" r="1"></circle>
              </svg>
            </button>
          </template>
        </BizAccountListCard>
      </slot>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import BizAccountListCard from './BizAccountListCard.vue';

const props = defineProps({
  accounts: {
    type: Array as () => any[],
    required: true
  },
  isReorderMode: {
    type: Boolean,
    default: false
  }
});

const emit = defineEmits(['update:accounts', 'item-click', 'action-click']);

const internalAccounts = ref([...props.accounts]);

watch(() => props.accounts, (newVal) => {
  internalAccounts.value = [...newVal];
}, { deep: true });

const onUpdateHidden = (index: number, isHidden: boolean) => {
  internalAccounts.value[index].isHidden = isHidden;
  emit('update:accounts', [...internalAccounts.value]);
};

const listRef = ref<HTMLElement | null>(null);
const draggedIndex = ref<number | null>(null);
const hoverIndex = ref<number | null>(null);
const dragDeltaY = ref(0);

let startY = 0;
let itemHeight = 0;

const getItemStyle = (index: number) => {
  if (draggedIndex.value === null || hoverIndex.value === null) return {};
  
  if (index === draggedIndex.value) {
    return {
      transform: `translateY(${dragDeltaY.value}px)`,
      zIndex: 100,
    };
  }
  
  if (draggedIndex.value < hoverIndex.value && index > draggedIndex.value && index <= hoverIndex.value) {
    return { transform: `translateY(-${itemHeight}px)`, transition: 'transform 0.2s' };
  }
  
  if (draggedIndex.value > hoverIndex.value && index < draggedIndex.value && index >= hoverIndex.value) {
    return { transform: `translateY(${itemHeight}px)`, transition: 'transform 0.2s' };
  }
  
  return { transition: 'transform 0.2s' };
};

const onDragStart = (clientY: number, index: number) => {
  draggedIndex.value = index;
  hoverIndex.value = index;
  startY = clientY;
  dragDeltaY.value = 0;
  
  const items = listRef.value?.querySelectorAll('.reorder-item');
  if (items && items[index]) {
    itemHeight = (items[index] as HTMLElement).offsetHeight + 12; // card height + bottom margin
  }
};

const onTouchStart = (e: TouchEvent, index: number) => {
  onDragStart(e.touches[0].clientY, index);
  document.addEventListener('touchmove', onTouchMove, { passive: false });
  document.addEventListener('touchend', onDragEnd);
};

const onMouseDown = (e: MouseEvent, index: number) => {
  onDragStart(e.clientY, index);
  document.addEventListener('mousemove', onMouseMove);
  document.addEventListener('mouseup', onDragEnd);
};

const onMove = (clientY: number) => {
  if (draggedIndex.value === null) return;
  
  dragDeltaY.value = clientY - startY;
  
  const offsetItems = Math.round(dragDeltaY.value / (itemHeight || 100));
  let newHoverIndex = draggedIndex.value + offsetItems;
  newHoverIndex = Math.max(0, Math.min(internalAccounts.value.length - 1, newHoverIndex));
  
  hoverIndex.value = newHoverIndex;
};

const onTouchMove = (e: TouchEvent) => {
  e.preventDefault(); // prevent scrolling while dragging
  onMove(e.touches[0].clientY);
};

const onMouseMove = (e: MouseEvent) => {
  e.preventDefault();
  onMove(e.clientY);
};

const onDragEnd = () => {
  document.removeEventListener('touchmove', onTouchMove);
  document.removeEventListener('touchend', onDragEnd);
  document.removeEventListener('mousemove', onMouseMove);
  document.removeEventListener('mouseup', onDragEnd);
  
  if (draggedIndex.value !== null && hoverIndex.value !== null && draggedIndex.value !== hoverIndex.value) {
    const newAccs = [...internalAccounts.value];
    const [removed] = newAccs.splice(draggedIndex.value, 1);
    newAccs.splice(hoverIndex.value, 0, removed);
    
    internalAccounts.value = newAccs;
    emit('update:accounts', newAccs);
  }
  
  draggedIndex.value = null;
  hoverIndex.value = null;
  dragDeltaY.value = 0;
};
</script>

<style scoped>
.biz-account-reorder-list {
  position: relative;
}

.reorder-item {
  width: 100%;
}

.drag-handle {
  color: #999;
  cursor: grab;
  padding: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.drag-handle:active {
  cursor: grabbing;
}

.is-dragging {
  opacity: 0.9;
  z-index: 100;
  position: relative;
  /* transform is handled dynamically in JS */
}

.action-btn {
  background: transparent;
  border: none;
  color: #999;
  padding: 0;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}
</style>
