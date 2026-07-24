<template>
  <div class="pp-tree-node">
    <div 
      class="pp-tree-node__content" 
      :class="[
        { 'is-selected': isSelected, 'is-selectable': treeOptions?.selectable },
        `variant-${treeOptions.variant || 'standard'}`
      ]"
      :style="{ paddingLeft: `${level * 16}px` }"
      @click="handleSelect"
    >
      <div 
        class="pp-tree-node__expand-icon"
        :class="{ 'is-leaf': isLeaf, 'is-expanded': isExpanded }"
        @click.stop="toggleExpand"
      >
        <svg v-if="!isLeaf" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="9 18 15 12 9 6"></polyline>
        </svg>
      </div>
      
      <div v-if="node.icon" class="pp-tree-node__icon">
        <ion-icon :icon="node.icon"></ion-icon>
      </div>

      <div class="pp-tree-node__label">
        <slot name="default" :node="node">{{ node.label }}</slot>
      </div>
    </div>
    
    <div v-if="isExpanded && !isLeaf" class="pp-tree-node__children" :class="`children-variant-${treeOptions.variant || 'standard'}`">
      <PPTreeNode 
        v-for="(child, index) in node.children" 
        :key="child.id" 
        :node="child" 
        :level="level + 1"
        :is-last="index === node.children.length - 1"
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
  },
  isLast: {
    type: Boolean,
    default: false
  }
});

const emit = defineEmits(['toggle', 'select']);

const treeOptions = inject('ppTreeOptions', {
  expandAll: false,
  selectable: true,
  selectedId: ref(null),
  variant: 'standard'
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
.pp-tree-node {
  outline: none;
}

.pp-tree-node__content {
  display: flex;
  align-items: center;
  height: 36px;
  cursor: pointer;
  border-radius: 4px;
  transition: background-color 0.2s;
}

.pp-tree-node__content:hover {
  background-color: #f4f5f8;
}

.pp-tree-node__content.is-selected {
  background-color: #e6f0ff;
  color: #003399;
  font-weight: 500;
}

.pp-tree-node__expand-icon {
  width: 24px;
  height: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #999;
  transition: transform 0.2s;
  cursor: pointer;
}

.pp-tree-node__expand-icon.is-leaf {
  color: transparent;
  pointer-events: none;
}

.pp-tree-node__expand-icon.is-expanded {
  transform: rotate(90deg);
}

.pp-tree-node__icon {
  margin-right: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
}
.pp-tree-node__content.is-selected .pp-tree-node__icon {
  color: #003399;
}

.pp-tree-node__label {
  font-size: 14px;
  user-select: none;
}

/* BOXED VARIANT */
.variant-boxed {
  border: 1px solid #eef1f6;
  border-radius: 8px;
  margin-bottom: 8px;
  background-color: white;
  box-shadow: 0 1px 3px rgba(0,0,0,0.02);
  height: 42px;
}
.variant-boxed:hover {
  border-color: #d1d9e6;
  background-color: #f8fafc;
}
.variant-boxed.is-selected {
  border-color: #003399;
  background-color: #f0f5ff;
}

/* ZEBRA VARIANT */
.variant-zebra {
  border-radius: 0;
  border-bottom: 1px solid #f0f0f0;
}
.pp-tree-node:nth-child(even) > .variant-zebra {
  background-color: #fafafa;
}
.pp-tree-node:nth-child(odd) > .variant-zebra {
  background-color: #ffffff;
}
.variant-zebra.is-selected {
  background-color: #e6f0ff !important;
  border-left: 3px solid #003399;
}

/* LINED VARIANT */
.pp-tree-node__children.children-variant-lined {
  position: relative;
}

/* Vertical line for the children container */
.pp-tree-node__children.children-variant-lined::before {
  content: '';
  position: absolute;
  top: 0;
  bottom: 20px; /* Stop before the very bottom to connect cleanly */
  left: var(--line-left);
  width: 1px;
  background-color: #dcdcdc;
  z-index: 1;
}

/* Horizontal line for lined items > level 0 */
.variant-lined {
  position: relative;
}
.pp-tree-node__children .variant-lined::before {
  content: '';
  position: absolute;
  left: var(--parent-line-left);
  top: 17.5px; /* middle of 36px */
  width: 12px;
  height: 1px;
  background-color: #dcdcdc;
  z-index: 1;
}
</style>
