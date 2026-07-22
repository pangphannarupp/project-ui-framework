<template>
  <PPBottomSheet 
    :modelValue="modelValue"
    @update:modelValue="$emit('update:modelValue', $event)"
  >
    <template #header v-if="title">
      <h3 style="margin: 0; padding: 0 16px; font-size: 18px; font-weight: 600;">{{ title }}</h3>
    </template>
    <div style="padding: 16px;">
      <PPColorPicker 
        :modelValue="localColor"
        :colors="colors"
        :allowCustom="allowCustom"
        @update:modelValue="onColorUpdate"
      />
    </div>
    <template #footer v-if="showActionButtons">
      <div class="action-buttons">
        <button class="btn-cancel" @click="onCancel">{{ cancelText }}</button>
        <button class="btn-confirm" @click="onConfirm">{{ confirmText }}</button>
      </div>
    </template>
  </PPBottomSheet>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import PPColorPicker from './PPColorPicker.vue';
import PPBottomSheet from './PPBottomSheet.vue';

const props = withDefaults(defineProps<{
  modelValue: boolean;
  title?: string;
  colorValue?: string;
  colors?: string[];
  allowCustom?: boolean;
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
</script>

<style scoped>
.action-buttons {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  padding: 0 16px 16px;
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
