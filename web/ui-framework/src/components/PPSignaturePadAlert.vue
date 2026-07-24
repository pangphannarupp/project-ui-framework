<template>
  <div v-if="modelValue" class="pp-signature-alert-overlay" @click="onOverlayClick">
    <div class="pp-signature-alert-content" @click.stop>
      <div v-if="title" class="alert-header">
        <h3 class="alert-title">{{ title }}</h3>
      </div>
      
      <div class="alert-body">
        <PPSignaturePad 
          ref="sigPadRef"
          :placeholder="placeholder"
          :strokeColor="strokeColor"
          :lineWidth="lineWidth"
          :backgroundColor="backgroundColor"
        />
      </div>

      <div class="alert-footer">
        <button class="btn-clear" @click="onClear">{{ clearText }}</button>
        <div class="action-buttons">
          <button class="btn-cancel" @click="onCancel">{{ cancelText }}</button>
          <button class="btn-confirm" @click="onConfirm">{{ confirmText }}</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import PPSignaturePad from './PPSignaturePad.vue';

const props = withDefaults(defineProps<{
  modelValue: boolean;
  title?: string;
  placeholder?: string;
  strokeColor?: string;
  lineWidth?: number;
  backgroundColor?: string;
  cancelText?: string;
  confirmText?: string;
  clearText?: string;
  dismissOnOverlayClick?: boolean;
}>(), {
  title: 'Sign Here',
  placeholder: 'Please sign here',
  strokeColor: '#000000',
  lineWidth: 2,
  backgroundColor: '#ffffff',
  cancelText: 'Cancel',
  confirmText: 'Save',
  clearText: 'Clear',
  dismissOnOverlayClick: true
});

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'save', base64Image: string): void;
  (e: 'cancel'): void;
}>();

const sigPadRef = ref<InstanceType<typeof PPSignaturePad> | null>(null);

const onOverlayClick = () => {
  if (props.dismissOnOverlayClick) {
    onCancel();
  }
};

const onClear = () => {
  if (sigPadRef.value) {
    sigPadRef.value.clear();
  }
};

const onCancel = () => {
  emit('cancel');
  emit('update:modelValue', false);
};

const onConfirm = () => {
  if (sigPadRef.value && !sigPadRef.value.isEmpty()) {
    const data = sigPadRef.value.getData();
    if (data) {
      emit('save', data);
      emit('update:modelValue', false);
    }
  }
};
</script>

<style scoped>
.pp-signature-alert-overlay {
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

.pp-signature-alert-content {
  background: #fff;
  border-radius: 16px;
  width: 100%;
  max-width: 400px;
  max-height: 90vh;
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.15);
  display: flex;
  flex-direction: column;
}

.alert-header {
  padding: 20px 20px 12px;
}

.alert-title {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
  color: #1f2937;
}

.alert-body {
  padding: 0 20px 16px;
}

.alert-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  border-top: 1px solid #f3f4f6;
}

.action-buttons {
  display: flex;
  gap: 12px;
}

.btn-clear,
.btn-cancel,
.btn-confirm {
  padding: 8px 16px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  border: none;
}

.btn-clear {
  background: transparent;
  color: #ef4444;
}

.btn-cancel {
  background: #f4f5f8;
  color: #666;
}

.btn-confirm {
  background: var(--pp-primary-color, #003399);
  color: #ffffff;
}
</style>
