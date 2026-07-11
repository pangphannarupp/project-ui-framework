<template>
  <div class="biz-transfer-wrapper" :class="[
    `biz-transfer--${variant}`,
    { 'biz-transfer--disabled': disabled }
  ]">
    
    <!-- Left List -->
    <div class="biz-transfer-panel">
      <div class="biz-transfer-header">
        <label class="biz-transfer-title">
          <input type="checkbox" :checked="leftChecked.length > 0 && leftChecked.length === leftData.length" @change="toggleAllLeft" :disabled="disabled" />
          {{ titles[0] }}
        </label>
        <span class="biz-transfer-count">{{ leftChecked.length }}/{{ leftData.length }}</span>
      </div>
      <div class="biz-transfer-body">
        <div v-if="leftData.length === 0" class="biz-transfer-empty">No Data</div>
        <label v-for="item in leftData" :key="item.key" class="biz-transfer-item" :class="{ 'is-checked': leftChecked.includes(item.key) }">
          <input type="checkbox" :value="item.key" v-model="leftChecked" :disabled="disabled || item.disabled" />
          <span>{{ item.label }}</span>
        </label>
      </div>
    </div>

    <!-- Actions -->
    <div class="biz-transfer-actions">
      <button class="biz-transfer-btn" @click="moveToRight" :disabled="disabled || leftChecked.length === 0">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="9 18 15 12 9 6"></polyline>
        </svg>
      </button>
      <button class="biz-transfer-btn" @click="moveToLeft" :disabled="disabled || rightChecked.length === 0">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="15 18 9 12 15 6"></polyline>
        </svg>
      </button>
    </div>

    <!-- Right List -->
    <div class="biz-transfer-panel">
      <div class="biz-transfer-header">
        <label class="biz-transfer-title">
          <input type="checkbox" :checked="rightChecked.length > 0 && rightChecked.length === rightData.length" @change="toggleAllRight" :disabled="disabled" />
          {{ titles[1] }}
        </label>
        <span class="biz-transfer-count">{{ rightChecked.length }}/{{ rightData.length }}</span>
      </div>
      <div class="biz-transfer-body">
        <div v-if="rightData.length === 0" class="biz-transfer-empty">No Data</div>
        <label v-for="item in rightData" :key="item.key" class="biz-transfer-item" :class="{ 'is-checked': rightChecked.includes(item.key) }">
          <input type="checkbox" :value="item.key" v-model="rightChecked" :disabled="disabled || item.disabled" />
          <span>{{ item.label }}</span>
        </label>
      </div>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

export interface TransferOption {
  key: string | number;
  label: string;
  disabled?: boolean;
}

const props = withDefaults(defineProps<{
  modelValue?: (string | number)[];
  data?: TransferOption[];
  titles?: [string, string];
  variant?: 'outlined' | 'filled' | 'underlined';
  disabled?: boolean;
}>(), {
  modelValue: () => [],
  data: () => [],
  titles: () => ['Source', 'Target'],
  variant: 'outlined',
  disabled: false
});

const emit = defineEmits(['update:modelValue', 'change']);

const leftChecked = ref<(string | number)[]>([]);
const rightChecked = ref<(string | number)[]>([]);

const leftData = computed(() => {
  return props.data.filter(item => !props.modelValue.includes(item.key));
});

const rightData = computed(() => {
  return props.data.filter(item => props.modelValue.includes(item.key));
});

const toggleAllLeft = (e: Event) => {
  const target = e.target as HTMLInputElement;
  if (target.checked) {
    leftChecked.value = leftData.value.filter(i => !i.disabled).map(i => i.key);
  } else {
    leftChecked.value = [];
  }
};

const toggleAllRight = (e: Event) => {
  const target = e.target as HTMLInputElement;
  if (target.checked) {
    rightChecked.value = rightData.value.filter(i => !i.disabled).map(i => i.key);
  } else {
    rightChecked.value = [];
  }
};

const moveToRight = () => {
  const newTargetKeys = [...props.modelValue, ...leftChecked.value];
  emit('update:modelValue', newTargetKeys);
  emit('change', newTargetKeys, 'right', leftChecked.value);
  leftChecked.value = [];
};

const moveToLeft = () => {
  const newTargetKeys = props.modelValue.filter(key => !rightChecked.value.includes(key));
  emit('update:modelValue', newTargetKeys);
  emit('change', newTargetKeys, 'left', rightChecked.value);
  rightChecked.value = [];
};
</script>

<style scoped>
.biz-transfer-wrapper {
  display: flex;
  align-items: stretch;
  gap: 16px;
  width: 100%;
  font-family: inherit;
}

/* Panel Styles */
.biz-transfer-panel {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-width: 150px;
  height: 250px;
  border-radius: 8px;
  overflow: hidden;
  background-color: #ffffff;
  transition: all 0.2s ease-in-out;
}

/* OUTLINED VARIANT */
.biz-transfer--outlined .biz-transfer-panel {
  border: 1px solid #cccccc;
}

/* FILLED VARIANT */
.biz-transfer--filled .biz-transfer-panel {
  border: none;
  background-color: #f5f5f5;
  border-bottom: 2px solid #999999;
  border-radius: 8px 8px 0 0;
}

/* UNDERLINED VARIANT */
.biz-transfer--underlined .biz-transfer-panel {
  border: none;
  border-bottom: 2px solid #cccccc;
  border-radius: 0;
  background-color: transparent;
}

.biz-transfer-header {
  padding: 12px 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1px solid #eeeeee;
  background-color: #fafafa;
}

.biz-transfer--filled .biz-transfer-header {
  background-color: #e8e8e8;
  border-bottom: 1px solid #dddddd;
}

.biz-transfer--underlined .biz-transfer-header {
  background-color: transparent;
  padding: 12px 8px;
}

.biz-transfer-title {
  display: flex;
  align-items: center;
  gap: 8px;
  font-size: 14px;
  font-weight: 500;
  color: #333333;
  cursor: pointer;
}

.biz-transfer-count {
  font-size: 12px;
  color: #999999;
}

.biz-transfer-body {
  flex: 1;
  overflow-y: auto;
  padding: 8px 0;
}

.biz-transfer--underlined .biz-transfer-body {
  padding: 8px 8px;
}

.biz-transfer-empty {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #cccccc;
  font-size: 14px;
}

.biz-transfer-item {
  display: flex;
  align-items: center;
  gap: 8px;
  padding: 8px 16px;
  font-size: 14px;
  color: #333333;
  cursor: pointer;
  transition: background-color 0.2s;
}

.biz-transfer--underlined .biz-transfer-item {
  padding: 8px 0;
}

.biz-transfer-item:hover {
  background-color: #f0f4ff;
}

.biz-transfer-item.is-checked {
  background-color: rgba(26, 42, 94, 0.05);
}

.biz-transfer-item input[type="checkbox"] {
  cursor: pointer;
}

.biz-transfer-item input[type="checkbox"]:disabled,
.biz-transfer-item input[type="checkbox"]:disabled + span {
  cursor: not-allowed;
  opacity: 0.5;
}

/* Actions */
.biz-transfer-actions {
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 12px;
}

@media (max-width: 600px) {
  .biz-transfer-wrapper {
    flex-direction: column;
  }
  .biz-transfer-actions {
    flex-direction: row;
  }
  .biz-transfer-btn svg {
    transform: rotate(90deg);
  }
}

.biz-transfer-btn {
  width: 36px;
  height: 36px;
  border-radius: 4px;
  border: 1px solid #cccccc;
  background-color: #ffffff;
  color: #333333;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}

.biz-transfer-btn:hover:not(:disabled) {
  border-color: var(--biz-primary-variant, #1a2a5e);
  color: var(--biz-primary-variant, #1a2a5e);
}

.biz-transfer-btn:disabled {
  background-color: #f5f5f5;
  color: #cccccc;
  border-color: #eeeeee;
  cursor: not-allowed;
}

.biz-transfer-btn svg {
  width: 18px;
  height: 18px;
}

/* DISABLED STATE */
.biz-transfer--disabled {
  opacity: 0.6;
  pointer-events: none;
}
</style>
