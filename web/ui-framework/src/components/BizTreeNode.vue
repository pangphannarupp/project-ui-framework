<template>
  <div class="biz-tree-node">
    <div 
      class="biz-tree-node__content" 
      :class="{ 'is-selected': isSelected, 'is-selectable': treeOptions?.selectable }"
      :style="{ paddingLeft: `${level * 16}px` }"
      @click="handleSelect"
    >
      <div 
        class="biz-tree-node__expand-icon"
        :class="{ 'is-leaf': isLeaf, 'is-expanded': isExpanded }"
        @click.stop="toggleExpand"
      >
        <svg v-if="!isLeaf" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="9 18 15 12 9 6"></polyline>
        </svg>
      </div>
      
      <div v-if="node.icon" class="biz-tree-node__icon">
        <ion-icon :icon="node.icon"></ion-icon>
      </div>

      <div class="biz-tree-node__label">
        <slot name="default" :node="node">{{ node.label }}</slot>
      </div>
    </div>
    
    <div v-if="isExpanded && !isLeaf" class="biz-tree-node__children">
      <BizTreeNode 
        v-for="child in node.children" 
        :key="child.id" 
        :node="child" 
        :level="level + 1"
        @toggle="$emit('toggle', $event, $event.expanded)"
        @select="$emit('select', $event)"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, inject, onMounted } from 'vue';
import { IonIcon } from '@ionic/vue';

const props = defineProps({
  node: {
    type: Object,
    required: true
  },
  level: {
    type: Number,
    default: 0
  }
});

const emit = defineEmits(['toggle', 'select']);

const treeOptions = inject('bizTreeOptions', {
  expandAll: false,
  selectable: true,
  selectedId: ref(null)
} as any);

const isExpanded = ref(props.node.expanded || false);

onMounted(() => {
  if (treeOptions.expandAll) {
    isExpanded.value = true;
  }
});

const isLeaf = computed(() => {
  return !props.node.children || props.node.children.length === 0;
});

const isSelected = computed(() => {
  return treeOptions.selectedId.value === props.node.id;
});

const toggleExpand = () => {
  if (isLeaf.value) return;
  isExpanded.value = !isExpanded.value;
  emit('toggle', props.node, isExpanded.value);
};

const handleSelect = () => {
  if (treeOptions.selectable) {
    emit('select', props.node);
  } else {
    toggleExpand();
  }
};
</script>

<style scoped>
.biz-tree-node {
  outline: none;
}

.biz-tree-node__content {
  display: flex;
  align-items: center;
  height: 36px;
  cursor: pointer;
  border-radius: 4px;
  transition: background-color 0.2s;
}

.biz-tree-node__content:hover {
  background-color: #f4f5f8;
}

.biz-tree-node__content.is-selected {
  background-color: #e6f0ff;
  color: #003399;
  font-weight: 500;
}

.biz-tree-node__expand-icon {
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
  transition: transform 0.2s;
  cursor: pointer;
}

.biz-tree-node__expand-icon.is-leaf {
  color: transparent;
  pointer-events: none;
}

.biz-tree-node__expand-icon.is-expanded {
  transform: rotate(90deg);
}

.biz-tree-node__icon {
  margin-right: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
}
.biz-tree-node__content.is-selected .biz-tree-node__icon {
  color: #003399;
}

.biz-tree-node__label {
  font-size: 14px;
  user-select: none;
}
</style>
