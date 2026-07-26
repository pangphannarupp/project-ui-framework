<template>
  <div v-if="modelValue" class="pp-input-dialog-overlay" @click="onOverlayClick">
    <div class="pp-input-dialog-content" @click.stop>
      <h3 class="dialog-title" v-if="title">{{ title }}</h3>
      <p class="dialog-message" v-if="message">{{ message }}</p>
      
      <div class="dialog-body">
        <slot name="input">
          <div class="input-wrapper">
            <input 
              ref="inputRef"
              :type="inputType" 
              class="dialog-input" 
              :placeholder="placeholder"
              v-model="inputValue"
              @keyup.enter="onConfirm"
            />
          </div>
        </slot>
      </div>

      <div class="dialog-actions">
        <PPButton 
          variant="primary" 
          block 
          @click="onConfirm"
          :disabled="!inputValue && required"
        >
          {{ confirmText }}
        </PPButton>
        <PPButton 
          variant="outline" 
          block 
          @click="onCancel"
        >
          {{ cancelText }}
        </PPButton>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch, nextTick } from 'vue';
import PPButton from './PPButton.vue';

const props = defineProps({
  modelValue: Boolean,
  title: String,
  message: String,
  initialValue: {
    type: String,
    default: ''
  },
  placeholder: {
    type: String,
    default: ''
  },
  inputType: {
    type: String,
    default: 'text'
  },
  confirmText: {
    type: String,
    default: 'Submit'
  },
  cancelText: {
    type: String,
    default: 'Cancel'
  },
  required: {
    type: Boolean,
    default: false
  },
  dismissOnOverlayClick: {
    type: Boolean,
    default: false
  }
});

const emit = defineEmits(['update:modelValue', 'confirm', 'cancel']);

const inputValue = ref(props.initialValue);
const inputRef = ref<HTMLInputElement | null>(null);

watch(() => props.modelValue, (val) => {
  if (val) {
    inputValue.value = props.initialValue;
    nextTick(() => {
      inputRef.value?.focus();
    });
  }
});

const onOverlayClick = () => {
  if (props.dismissOnOverlayClick) {
    onCancel();
  }
};

const onConfirm = () => {
  if (props.required && !inputValue.value) return;
  emit('confirm', inputValue.value);
  emit('update:modelValue', false);
};

const onCancel = () => {
  emit('cancel');
  emit('update:modelValue', false);
};
</script>

<style scoped>
.pp-input-dialog-overlay {
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
  animation: fadeIn 0.2s ease;
}

.pp-input-dialog-content {
  background: #fff;
  border-radius: 16px;
  width: 100%;
  max-width: 340px;
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.15);
  padding: 24px;
  display: flex;
  flex-direction: column;
  animation: slideUp 0.2s ease;
}

.dialog-title {
  font-size: 20px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  margin: 0 0 8px 0;
  text-align: center;
}

.dialog-message {
  font-size: 15px;
  color: #666;
  margin: 0 0 20px 0;
  line-height: 1.5;
  text-align: center;
}

.dialog-body {
  width: 100%;
  margin-bottom: 24px;
}

.input-wrapper {
  width: 100%;
}

.dialog-input {
  width: 100%;
  padding: 14px 16px;
  font-size: 16px;
  border: 1px solid #e0e0e0;
  border-radius: 12px;
  outline: none;
  transition: border-color 0.2s ease, box-shadow 0.2s ease;
  box-sizing: border-box;
}

.dialog-input:focus {
  border-color: var(--pp-primary, #007aff);
  box-shadow: 0 0 0 3px rgba(0, 122, 255, 0.1);
}

.dialog-actions {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 12px;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

@keyframes slideUp {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>
