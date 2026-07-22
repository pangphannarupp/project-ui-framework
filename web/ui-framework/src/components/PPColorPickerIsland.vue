<template>
  <div class="pp-color-picker-island-wrapper">
    <PPDynamicIsland 
      :modelValue="internalModelValue" 
      :state="islandState"
      :position="position"
      :fullWidth="fullWidth"
      :offset="offset"
      bgColor="#ffffff"
      textColor="#333333"
      wrapperClass="color-picker-island"
      @update:modelValue="handleIslandUpdate"
    >
      <template #minimal v-if="islandState === 'minimal'">
        <div class="calendar-minimal-dot"></div>
      </template>

      <template #expanded-body v-if="islandState === 'expanded'">
        <div class="calendar-island-body">
          <template v-if="title">
            <h3 style="margin: 0; padding: 0 16px 16px; font-size: 18px; font-weight: 600;">{{ title }}</h3>
          </template>
          <div style="padding: 0 16px 16px;">
            <PPColorPicker 
              :modelValue="localColor"
              :colors="colors"
              :allowCustom="allowCustom"
              @update:modelValue="onColorUpdate"
            />
          </div>
          <template v-if="showActionButtons">
            <div class="action-buttons">
              <button class="btn-cancel" @click="handleCancel">{{ cancelText }}</button>
              <button class="btn-confirm" @click="handleConfirm">{{ confirmText }}</button>
            </div>
          </template>
        </div>
      </template>
    </PPDynamicIsland>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import PPDynamicIsland from './PPDynamicIsland.vue';
import PPColorPicker from './PPColorPicker.vue';

const props = withDefaults(defineProps<{
  modelValue: boolean;
  title?: string;
  colorValue?: string;
  colors?: string[];
  allowCustom?: boolean;
  showActionButtons?: boolean;
  cancelText?: string;
  confirmText?: string;
  position?: 'top' | 'bottom' | 'left' | 'right';
  fullWidth?: boolean;
  offset?: number;
}>(), {
  showActionButtons: true,
  cancelText: 'Cancel',
  confirmText: 'Confirm',
  position: 'top',
  fullWidth: false,
  offset: 16
});

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'update:colorValue', val: string): void;
  (e: 'confirm', val: string): void;
  (e: 'cancel'): void;
}>();

const localColor = ref(props.colorValue || '');
const islandState = ref('minimal');
const internalModelValue = ref(false);
let expandTimeout: any;
let closeTimeout: any;

watch(() => props.colorValue, (newVal) => {
  if (newVal) {
    localColor.value = newVal;
  }
});

watch(() => props.modelValue, (val) => {
  if (val) {
    internalModelValue.value = true;
    islandState.value = 'minimal';
    clearTimeout(expandTimeout);
    expandTimeout = setTimeout(() => {
      islandState.value = 'expanded';
    }, 400); // Allow entry animation to finish before expanding
  } else {
    if (internalModelValue.value) {
      islandState.value = 'minimal';
      clearTimeout(closeTimeout);
      closeTimeout = setTimeout(() => {
        internalModelValue.value = false;
      }, 400);
    }
  }
});

const handleIslandUpdate = (val: boolean) => {
  if (!val) {
    emit('update:modelValue', false);
  } else {
    internalModelValue.value = val;
  }
};

const onColorUpdate = (val: string) => {
  localColor.value = val;
  if (!props.showActionButtons) {
    emit('update:colorValue', val);
  }
};

const handleConfirm = () => {
  emit('update:colorValue', localColor.value);
  emit('confirm', localColor.value);
  emit('update:modelValue', false);
};

const handleCancel = () => {
  emit('cancel');
  emit('update:modelValue', false);
};
</script>

<style scoped>
.calendar-island-body {
  width: 100%;
  height: 100%;
  overflow-y: auto;
  scrollbar-width: none;
  background: white; 
  border-radius: 16px;
  padding: 16px 0;
  color: #333;
}
.calendar-island-body::-webkit-scrollbar {
  display: none;
}

.calendar-minimal-dot {
  width: 16px;
  height: 16px;
  background-color: var(--pp-color-primary, #1976d2);
  border-radius: 50%;
}

.action-buttons {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  padding: 0 16px;
}

.btn-cancel,
.btn-confirm {
  padding: 8px 16px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  border: none;
}

.btn-cancel {
  background: #f4f5f8;
  color: var(--pp-calendar-btn-cancel-text, #666);
}

.btn-confirm {
  background: var(--pp-calendar-btn-confirm-bg, var(--pp-primary-color, var(--pp-primary, #003399)));
  color: var(--pp-calendar-btn-confirm-text, #ffffff);
}
</style>

<style>
.color-picker-island {
  --pp-island-expanded-width: 360px;
  --pp-island-expanded-height: 340px;
  --pp-island-expanded-radius: 24px;
}
</style>
