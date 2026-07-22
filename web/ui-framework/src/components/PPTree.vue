<template>
  <div class="pp-tree">
    <PPTreeNode 
      v-for="node in data" 
      :key="node.id" 
      :node="node" 
      :level="0"
      @toggle="handleToggle"
      @select="handleSelect"
    />
  </div>
</template>

<script setup lang="ts">
import { provide, ref } from 'vue';
import PPTreeNode from './PPTreeNode.vue';

export interface TreeNodeData {
  id: string | number;
  label: string;
  children?: TreeNodeData[];
  expanded?: boolean;
  selected?: boolean;
  icon?: string;
}

const props = defineProps({
  data: {
    type: Array as () => TreeNodeData[],
    default: () => []
  },
  expandAll: {
    type: Boolean,
    default: false
  },
  selectable: {
    type: Boolean,
    default: true
  }
});

const emit = defineEmits(['node-click', 'node-expand', 'node-collapse']);

const selectedId = ref<string | number | null>(null);

provide('bizTreeOptions', {
  expandAll: props.expandAll,
  selectable: props.selectable,
  selectedId
});

const handleToggle = (node: TreeNodeData, expanded: boolean) => {
  if (expanded) {
    emit('node-expand', node);
  } else {
    emit('node-collapse', node);
  }
};

const handleSelect = (node: TreeNodeData) => {
  if (props.selectable) {
    selectedId.value = node.id;
    emit('node-click', node);
  }
};
</script>

<style scoped>
.pp-tree {
  font-family: inherit;
  color: #333;
}
</style>
