<template>
  <div class="pp-tree-select-wrapper" :class="[
    `pp-tree-select--${variant}`,
    { 'pp-tree-select--error': error },
    { 'pp-tree-select--disabled': disabled }
  ]" ref="selectWrapper">
    <label v-if="label" class="pp-tree-select-label">
      {{ label }} <span v-if="required" class="pp-tree-select-required">*</span>
    </label>
    
    <div 
      :class="['pp-tree-select-container', { 'pp-tree-select-container--focused': isFocused || isOpen }]"
      @click="toggleDropdown"
      tabindex="0"
      @keydown.enter="toggleDropdown"
      @keydown.space.prevent="toggleDropdown"
      @keydown.esc="closeDropdown"
    >
      <span class="pp-tree-select-icon pp-tree-select-icon--left" v-if="$slots.iconLeft || iconLeft">
        <slot name="iconLeft">
          <IonIcon v-if="iconLeft" :icon="iconLeft"></IonIcon>
        </slot>
      </span>
      
      <div class="pp-tree-select-input pp-tree-select-display" :class="{ 'is-placeholder': !selectedOptionLabel }">
        {{ selectedOptionLabel || placeholder }}
      </div>
      
      <div class="pp-tree-select-actions">
        <span 
          v-if="clearable && modelValue" 
          class="pp-tree-select-icon pp-tree-select-icon--clear"
          @click.stop="clearSelection"
        >
          <IonIcon :icon="closeCircleOutline" />
        </span>
        <span class="pp-tree-select-icon pp-tree-select-icon--right" :class="{ 'is-open': isOpen }">
          <slot name="iconRight">
            <IonIcon :icon="chevronDownOutline" />
          </slot>
        </span>
      </div>
    </div>

    <!-- Dropdown Menu with Tree -->
    <Transition name="pp-dropdown">
      <div v-if="isOpen" class="pp-tree-select-dropdown">
        <div class="pp-tree-select-tree-container">
          <PPTree 
            :data="data" 
            :expandAll="expandAll" 
            :selectable="true" 
            variant="standard" 
            @node-click="handleNodeClick"
          />
        </div>
        <div v-if="!data || data.length === 0" class="pp-tree-select-no-options">
          No data available
        </div>
      </div>
    </Transition>
    
    <div class="pp-tree-select-helper" v-if="helperText || error">
      <span class="pp-tree-select-message" :class="{ 'pp-tree-select-message--error': error }">
        {{ error || helperText }}
      </span>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { IonIcon } from '@ionic/vue';
import { chevronDownOutline, closeCircleOutline } from 'ionicons/icons';
import PPTree from './PPTree.vue';

export interface TreeNodeData {
  id: string | number;
  label: string;
  children?: TreeNodeData[];
  expanded?: boolean;
  selected?: boolean;
  icon?: string;
}

const props = defineProps({
  modelValue: {
    type: [String, Number],
    default: null
  },
  data: {
    type: Array as () => TreeNodeData[],
    default: () => []
  },
  label: String,
  placeholder: {
    type: String,
    default: 'Select...'
  },
  variant: {
    type: String,
    default: 'outline'
  },
  error: String,
  helperText: String,
  disabled: Boolean,
  required: Boolean,
  iconLeft: String,
  clearable: {
    type: Boolean,
    default: false
  },
  expandAll: {
    type: Boolean,
    default: false
  }
});

const emit = defineEmits(['update:modelValue', 'change']);

const isOpen = ref(false);
const isFocused = ref(false);
const selectWrapper = ref<HTMLElement | null>(null);

// Find label by ID
const findLabelById = (nodes: TreeNodeData[], id: string | number): string | null => {
  for (const node of nodes) {
    if (node.id === id) {
      return node.label;
    }
    if (node.children && node.children.length > 0) {
      const found = findLabelById(node.children, id);
      if (found) return found;
    }
  }
  return null;
};

const selectedOptionLabel = computed(() => {
  if (props.modelValue === null || props.modelValue === undefined) return '';
  return findLabelById(props.data, props.modelValue) || props.modelValue.toString();
});

const toggleDropdown = () => {
  if (props.disabled) return;
  isOpen.value = !isOpen.value;
  isFocused.value = isOpen.value;
};

const closeDropdown = () => {
  isOpen.value = false;
  isFocused.value = false;
};

const handleNodeClick = (node: TreeNodeData) => {
  emit('update:modelValue', node.id);
  emit('change', node);
  closeDropdown();
};

const clearSelection = () => {
  emit('update:modelValue', null);
  emit('change', null);
};

const handleClickOutside = (event: MouseEvent) => {
  if (selectWrapper.value && !selectWrapper.value.contains(event.target as Node)) {
    closeDropdown();
  }
};

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
});

onUnmounted(() => {
  document.removeEventListener('click', handleClickOutside);
});
</script>

<style scoped>
.pp-tree-select-wrapper {
  display: flex;
  flex-direction: column;
  position: relative;
  width: 100%;
  font-family: inherit;
}

.pp-tree-select-label {
  font-size: 14px;
  font-weight: 500;
  margin-bottom: 6px;
  color: var(--pp-text-color, #333);
}

.pp-tree-select-required {
  color: #ef4444;
}

.pp-tree-select-container {
  display: flex;
  align-items: center;
  min-height: 44px;
  border-radius: 8px;
  border: 1px solid var(--pp-border-color, #e2e8f0);
  background: var(--pp-bg-color, #ffffff);
  padding: 0 12px;
  cursor: pointer;
  transition: all 0.2s ease;
  position: relative;
}

.pp-tree-select-container:hover {
  border-color: var(--pp-primary-color, #003399);
}

.pp-tree-select-container--focused {
  border-color: var(--pp-primary-color, #003399);
  box-shadow: 0 0 0 3px rgba(0, 51, 153, 0.1);
}

.pp-tree-select--disabled .pp-tree-select-container {
  background: #f1f5f9;
  cursor: not-allowed;
  opacity: 0.7;
}

.pp-tree-select--disabled .pp-tree-select-container:hover {
  border-color: #e2e8f0;
}

.pp-tree-select--error .pp-tree-select-container {
  border-color: #ef4444;
}

.pp-tree-select--error .pp-tree-select-container--focused {
  box-shadow: 0 0 0 3px rgba(239, 68, 68, 0.1);
}

.pp-tree-select-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  color: #94a3b8;
  font-size: 20px;
}

.pp-tree-select-icon--left {
  margin-right: 8px;
}

.pp-tree-select-icon--right {
  margin-left: 8px;
  transition: transform 0.3s ease;
}

.pp-tree-select-icon--right.is-open {
  transform: rotate(180deg);
}

.pp-tree-select-icon--clear {
  color: #cbd5e1;
  transition: color 0.2s;
  font-size: 18px;
}

.pp-tree-select-icon--clear:hover {
  color: #64748b;
}

.pp-tree-select-actions {
  display: flex;
  align-items: center;
  gap: 4px;
}

.pp-tree-select-display {
  flex: 1;
  font-size: 16px;
  color: #1e293b;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  user-select: none;
}

.pp-tree-select-display.is-placeholder {
  color: #94a3b8;
}

.pp-tree-select-dropdown {
  position: absolute;
  top: calc(100% + 4px);
  left: 0;
  width: 100%;
  max-height: 300px;
  background: #ffffff;
  border-radius: 8px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
  border: 1px solid #e2e8f0;
  z-index: 100;
  overflow-y: auto;
  display: flex;
  flex-direction: column;
}

.pp-tree-select-tree-container {
  padding: 8px;
}

.pp-tree-select-no-options {
  padding: 12px 16px;
  color: #94a3b8;
  text-align: center;
  font-style: italic;
  font-size: 14px;
}

.pp-tree-select-helper {
  margin-top: 4px;
}

.pp-tree-select-message {
  font-size: 12px;
  color: #64748b;
}

.pp-tree-select-message--error {
  color: #ef4444;
}

/* Transitions */
.pp-dropdown-enter-active,
.pp-dropdown-leave-active {
  transition: all 0.2s ease;
  transform-origin: top center;
}

.pp-dropdown-enter-from,
.pp-dropdown-leave-to {
  opacity: 0;
  transform: scaleY(0.95);
}

/* Variants */
.pp-tree-select--filled .pp-tree-select-container {
  background: #f1f5f9;
  border-color: transparent;
}
.pp-tree-select--filled .pp-tree-select-container:hover {
  background: #e2e8f0;
}
.pp-tree-select--filled.pp-tree-select-container--focused {
  background: #ffffff;
  border-color: var(--pp-primary-color, #003399);
}

.pp-tree-select--flushed .pp-tree-select-container {
  border: none;
  border-bottom: 1px solid #e2e8f0;
  border-radius: 0;
  padding-left: 0;
  padding-right: 0;
  background: transparent;
}
.pp-tree-select--flushed .pp-tree-select-container:hover {
  border-bottom-color: #94a3b8;
}
.pp-tree-select--flushed .pp-tree-select-container--focused {
  border-bottom-color: var(--pp-primary-color, #003399);
  box-shadow: none;
}
</style>
