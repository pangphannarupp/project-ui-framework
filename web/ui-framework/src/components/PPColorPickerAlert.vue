<template>
  <div v-if="modelValue" class="pp-color-alert-overlay" @click="onOverlayClick">
    <div class="pp-color-alert-content" @click.stop>
      <div v-if="title" class="alert-header">
        <h3>{{ title }}</h3>
      </div>
      <div class="alert-body">
        <PPColorPicker 
          :modelValue="localColor"
          :colors="colors"
          :allowCustom="allowCustom"
          @update:modelValue="onColorUpdate"
        />
      </div>
      <div class="action-buttons" v-if="showActionButtons">
        <button class="btn-cancel" @click="onCancel">{{ cancelText }}</button>
        <button class="btn-confirm" @click="onConfirm">{{ confirmText }}</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import PPColorPicker from './PPColorPicker.vue';

const props = withDefaults(defineProps<{
  modelValue: boolean;
  title?: string;
  colorValue?: string;
  colors?: string[];
  allowCustom?: boolean;
  dismissOnOverlayClick?: boolean;
  showActionButtons?: boolean;
  cancelText?: string;
  confirmText?: string;
}>(), {
  showActionButtons: true,
  cancelText: 'Cancel',
  confirmText: 'Confirm'
});

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'update:colorValue', val: string): void;
  (e: 'confirm', val: string): void;
  (e: 'cancel'): void;
}>();

const localColor = ref(props.colorValue || '');

watch(() => props.colorValue, (newVal) => {
  if (newVal) {
    localColor.value = newVal;
  }
});

const onColorUpdate = (val: string) => {
  localColor.value = val;
  if (!props.showActionButtons) {
    emit('update:colorValue', val);
  }
};

const onCancel = () => {
  emit('cancel');
  emit('update:modelValue', false);
};

const onConfirm = () => {
  emit('update:colorValue', localColor.value);
  emit('confirm', localColor.value);
  emit('update:modelValue', false);
};

const onOverlayClick = () => {
  if (props.dismissOnOverlayClick !== false) {
    emit('update:modelValue', false);
  }
};
</script>

<style scoped>
.pp-color-alert-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.4);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 16px;
}

.pp-color-alert-content {
  background: #fff;
  border-radius: 16px;
  width: 100%;
  max-width: 400px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.15);
}

.alert-header {
  padding: 16px 20px 8px;
}

.alert-header h3 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
  color: #333;
}

.alert-body {
  padding: 16px;
}

.action-buttons {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  padding: 16px;
  border-top: 1px solid #f0f0f5;
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
