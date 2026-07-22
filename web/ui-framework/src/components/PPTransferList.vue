<template>
  <div class="pp-transfer-wrapper" :class="[
    `pp-transfer--${variant}`,
    `pp-transfer--${direction}`,
    { 'pp-transfer--disabled': disabled }
  ]">
    
    <!-- Left List -->
    <div class="pp-transfer-panel">
      <div class="pp-transfer-header">
        <label class="pp-transfer-title">
          <PPCheckbox 
            :modelValue="leftChecked.length > 0 && leftChecked.length === leftData.length" 
            @update:modelValue="toggleAllLeft" 
            :indeterminate="leftChecked.length > 0 && leftChecked.length < leftData.length"
            :disabled="disabled || leftData.length === 0" 
          />
          <span class="pp-transfer-title-text">{{ titles[0] }}</span>
        </label>
        <span class="pp-transfer-count">{{ leftChecked.length }} / {{ leftData.length }}</span>
      </div>
      <div class="pp-transfer-body custom-scrollbar">
        <div v-if="leftData.length === 0" class="pp-transfer-empty">
          <IonIcon :icon="layersOutline" class="pp-empty-icon" />
          <span>No Data</span>
        </div>
        <label 
          v-for="item in leftData" 
          :key="item.key" 
          class="pp-transfer-item" 
          :class="{ 'is-checked': leftChecked.includes(item.key), 'is-disabled': disabled || item.disabled }"
        >
          <PPCheckbox 
            :value="item.key" 
            :modelValue="leftChecked.includes(item.key)"
            @update:modelValue="val => toggleLeftItem(item.key, val)"
            :disabled="disabled || item.disabled" 
          />
          <span class="pp-transfer-item-text">{{ item.label }}</span>
        </label>
      </div>
    </div>

    <!-- Actions -->
    <div class="pp-transfer-actions">
      <button 
        class="pp-transfer-btn" 
        :class="{ 'is-active': leftChecked.length > 0 }"
        @click="moveToRight" 
        :disabled="disabled || leftChecked.length === 0"
      >
        <IonIcon :icon="chevronForwardOutline" />
      </button>
      <button 
        class="pp-transfer-btn" 
        :class="{ 'is-active': rightChecked.length > 0 }"
        @click="moveToLeft" 
        :disabled="disabled || rightChecked.length === 0"
      >
        <IonIcon :icon="chevronBackOutline" />
      </button>
    </div>

    <!-- Right List -->
    <div class="pp-transfer-panel">
      <div class="pp-transfer-header">
        <label class="pp-transfer-title">
          <PPCheckbox 
            :modelValue="rightChecked.length > 0 && rightChecked.length === rightData.length" 
            @update:modelValue="toggleAllRight" 
            :indeterminate="rightChecked.length > 0 && rightChecked.length < rightData.length"
            :disabled="disabled || rightData.length === 0" 
          />
          <span class="pp-transfer-title-text">{{ titles[1] }}</span>
        </label>
        <span class="pp-transfer-count">{{ rightChecked.length }} / {{ rightData.length }}</span>
      </div>
      <div class="pp-transfer-body custom-scrollbar">
        <div v-if="rightData.length === 0" class="pp-transfer-empty">
          <IonIcon :icon="layersOutline" class="pp-empty-icon" />
          <span>No Data</span>
        </div>
        <label 
          v-for="item in rightData" 
          :key="item.key" 
          class="pp-transfer-item" 
          :class="{ 'is-checked': rightChecked.includes(item.key), 'is-disabled': disabled || item.disabled }"
        >
          <PPCheckbox 
            :value="item.key" 
            :modelValue="rightChecked.includes(item.key)"
            @update:modelValue="val => toggleRightItem(item.key, val)"
            :disabled="disabled || item.disabled" 
          />
          <span class="pp-transfer-item-text">{{ item.label }}</span>
        </label>
      </div>
    </div>
    
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { IonIcon } from '@ionic/vue';
import { chevronForwardOutline, chevronBackOutline, layersOutline } from 'ionicons/icons';
import PPCheckbox from './PPCheckbox.vue';

export interface TransferOption {
  key: string | number;
  label: string;
  disabled?: boolean;
}

const props = withDefaults(defineProps<{
  modelValue?: (string | number)[];
  data?: TransferOption[];
  titles?: [string, string];
  variant?: 'outlined' | 'filled';
  disabled?: boolean;
  direction?: 'horizontal' | 'vertical';
}>(), {
  modelValue: () => [],
  data: () => [],
  titles: () => ['Source', 'Target'],
  variant: 'outlined',
  disabled: false,
  direction: 'horizontal'
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

const toggleAllLeft = (val: boolean) => {
  if (val) {
    leftChecked.value = leftData.value.filter(i => !i.disabled).map(i => i.key);
  } else {
    leftChecked.value = [];
  }
};

const toggleAllRight = (val: boolean) => {
  if (val) {
    rightChecked.value = rightData.value.filter(i => !i.disabled).map(i => i.key);
  } else {
    rightChecked.value = [];
  }
};

const toggleLeftItem = (key: string | number, checked: boolean) => {
  if (checked) {
    leftChecked.value.push(key);
  } else {
    leftChecked.value = leftChecked.value.filter(k => k !== key);
  }
};

const toggleRightItem = (key: string | number, checked: boolean) => {
  if (checked) {
    rightChecked.value.push(key);
  } else {
    rightChecked.value = rightChecked.value.filter(k => k !== key);
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
.pp-transfer-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 24px;
  width: 100%;
  font-family: inherit;
}

/* Panel Styles */
.pp-transfer-panel {
  flex: 1;
  display: flex;
  flex-direction: column;
  min-width: 200px;
  max-width: 320px;
  height: 320px;
  border-radius: 12px;
  overflow: hidden;
  background-color: #ffffff;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.04);
  transition: all 0.2s ease-in-out;
}

/* OUTLINED VARIANT */
.pp-transfer--outlined .pp-transfer-panel {
  border: 1px solid #e5e7eb;
}

/* FILLED VARIANT */
.pp-transfer--filled .pp-transfer-panel {
  border: none;
  background-color: #f5f5f5;
  box-shadow: none;
}

.pp-transfer-header {
  padding: 14px 16px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 1px solid #f3f4f6;
  background-color: #ffffff;
  z-index: 1;
}
.pp-transfer--filled .pp-transfer-header {
  background-color: #f3f4f6;
  border-bottom-color: #e5e7eb;
}

.pp-transfer-title {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 15px;
  font-weight: 600;
  color: #111827;
  cursor: pointer;
  margin: 0;
}

.pp-transfer-title-text {
  user-select: none;
}

.pp-transfer-count {
  font-size: 13px;
  color: #6b7280;
  font-weight: 500;
  background: #f3f4f6;
  padding: 2px 8px;
  border-radius: 12px;
}

.pp-transfer-body {
  flex: 1;
  overflow-y: auto;
  padding: 8px 0;
  background-color: #ffffff;
}

.pp-transfer-empty {
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  color: #9ca3af;
  font-size: 14px;
  gap: 8px;
}
.pp-empty-icon {
  font-size: 24px;
  opacity: 0.5;
}

.pp-transfer-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 10px 16px;
  font-size: 14px;
  color: #374151;
  cursor: pointer;
  transition: all 0.2s ease;
  margin: 2px 8px;
  border-radius: 8px;
}

.pp-transfer-item-text {
  user-select: none;
  flex: 1;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.pp-transfer-item:hover:not(.is-disabled) {
  background-color: #f9fafb;
}

.pp-transfer-item.is-checked {
  color: var(--pp-primary-variant, #1a2a5e);
  font-weight: 500;
}

.pp-transfer-item.is-disabled {
  cursor: not-allowed;
  opacity: 0.5;
}

/* Actions */
.pp-transfer-actions {
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 12px;
}

.pp-transfer--vertical {
  flex-direction: column;
}
.pp-transfer--vertical .pp-transfer-panel {
  width: 100%;
  max-width: none;
}
.pp-transfer--vertical .pp-transfer-actions {
  flex-direction: row;
}
.pp-transfer--vertical .pp-transfer-btn {
  transform: rotate(90deg);
}

@media (max-width: 600px) {
  .pp-transfer-wrapper {
    flex-direction: column;
  }
  .pp-transfer-panel {
    width: 100%;
    max-width: none;
  }
  .pp-transfer-actions {
    flex-direction: row;
  }
  .pp-transfer-btn {
    transform: rotate(90deg);
  }
}

.pp-transfer-btn {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  border: 1px solid #e5e7eb;
  background-color: #ffffff;
  color: #9ca3af;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.pp-transfer-btn.is-active {
  background-color: var(--pp-primary-variant, #1a2a5e);
  color: #ffffff;
  border-color: var(--pp-primary-variant, #1a2a5e);
  box-shadow: 0 4px 12px rgba(26, 42, 94, 0.2);
}
.pp-transfer-btn.is-active:hover {
  transform: translateY(-1px);
  box-shadow: 0 6px 16px rgba(26, 42, 94, 0.3);
}

.pp-transfer-btn:disabled {
  background-color: #f9fafb;
  color: #d1d5db;
  border-color: #f3f4f6;
  box-shadow: none;
  cursor: not-allowed;
  transform: none;
}

.pp-transfer-btn ion-icon {
  font-size: 20px;
}

/* DISABLED STATE */
.pp-transfer--disabled {
  opacity: 0.6;
  pointer-events: none;
}

/* Custom Scrollbar */
.custom-scrollbar::-webkit-scrollbar {
  width: 6px;
  height: 6px;
}
.custom-scrollbar::-webkit-scrollbar-track {
  background: transparent;
}
.custom-scrollbar::-webkit-scrollbar-thumb {
  background-color: #d1d5db;
  border-radius: 20px;
}
.custom-scrollbar::-webkit-scrollbar-thumb:hover {
  background-color: #9ca3af;
}
</style>
