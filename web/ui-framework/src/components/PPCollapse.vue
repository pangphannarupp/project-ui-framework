<template>
  <div 
    class="pp-collapse"
    :class="[`pp-collapse--${variant}`]"
  >
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { provide, computed } from 'vue';

const props = defineProps({
  modelValue: {
    type: [Array, String, Number],
    default: () => []
  },
  accordion: {
    type: Boolean,
    default: false
  },
  variant: {
    type: String,
    default: 'default' // 'default', 'flush', 'filled', 'separated'
  }
});

const emit = defineEmits(['update:modelValue', 'change']);

const activeNames = computed(() => {
  return Array.isArray(props.modelValue) ? props.modelValue : (props.modelValue ? [props.modelValue] : []);
});

const handleItemClick = (name: string | number) => {
  if (props.accordion) {
    const newVal = activeNames.value[0] === name ? '' : name;
    emit('update:modelValue', newVal);
    emit('change', newVal);
  } else {
    const _activeNames = [...activeNames.value];
    const index = _activeNames.indexOf(name);
    
    if (index > -1) {
      _activeNames.splice(index, 1);
    } else {
      _activeNames.push(name);
    }
    
    emit('update:modelValue', _activeNames);
    emit('change', _activeNames);
  }
};

provide('pp-collapse', {
  activeNames,
  handleItemClick,
  variant: computed(() => props.variant)
});
</script>

<style scoped>
.pp-collapse {
  display: flex;
  flex-direction: column;
}

/* Default Variant */
.pp-collapse--default {
  border: 1px solid var(--pp-border-color, #e0e2ec);
  border-radius: 12px;
  background-color: var(--pp-bg-color, #ffffff);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
  overflow: hidden;
}

/* Flush Variant */
.pp-collapse--flush {
  border: none;
  border-radius: 0;
  box-shadow: none;
  background-color: transparent;
}

/* Separated Variant */
.pp-collapse--separated {
  border: none;
  background-color: transparent;
  box-shadow: none;
  gap: 12px;
}

/* Filled Variant */
.pp-collapse--filled {
  border: none;
  border-radius: 12px;
  background-color: transparent;
  gap: 8px;
}
</style>
