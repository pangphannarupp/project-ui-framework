<template>
  <PPBottomSheet 
    :modelValue="modelValue"
    sheetClass="pp-signature-light-modal"
    @update:modelValue="onUpdateModelValue"
  >
    <template #header v-if="title">
      <h3 style="margin: 0; padding: 0 16px; font-size: 18px; font-weight: 600;">{{ title }}</h3>
    </template>
    
    <div class="sheet-body">
      <PPSignaturePad 
        ref="sigPadRef"
        :placeholder="placeholder"
        :strokeColor="strokeColor"
        :lineWidth="lineWidth"
        :backgroundColor="backgroundColor"
      />
    </div>

    <template #footer>
      <div class="sheet-footer">
        <button class="btn-clear" @click="onClear">{{ clearText }}</button>
        <div class="action-buttons">
          <button class="btn-cancel" @click="onCancel">{{ cancelText }}</button>
          <button class="btn-confirm" @click="onConfirm">{{ confirmText }}</button>
        </div>
      </div>
    </template>
  </PPBottomSheet>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import PPSignaturePad from './PPSignaturePad.vue';
import PPBottomSheet from './PPBottomSheet.vue';

withDefaults(defineProps<{
  modelValue: boolean;
  title?: string;
  placeholder?: string;
  strokeColor?: string;
  lineWidth?: number;
  backgroundColor?: string;
  cancelText?: string;
  confirmText?: string;
  clearText?: string;
}>(), {
  title: 'Sign Here',
  placeholder: 'Please sign here',
  strokeColor: '#000000',
  lineWidth: 2,
  backgroundColor: '#ffffff',
  cancelText: 'Cancel',
  confirmText: 'Save',
  clearText: 'Clear'
});

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'save', base64Image: string): void;
  (e: 'cancel'): void;
}>();

const sigPadRef = ref<InstanceType<typeof PPSignaturePad> | null>(null);

const onUpdateModelValue = (val: boolean) => {
  if (!val) {
    onCancel();
  } else {
    emit('update:modelValue', val);
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
.sheet-body {
  padding: 16px;
}

.sheet-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 16px 16px;
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

:deep(.pp-signature-light-modal) {
  background-color: #ffffff !important;
  color: #1e1e1e !important;
}
</style>
