<template>
  <div v-if="modelValue" class="pp-confirm-overlay" @click="onOverlayClick">
    <div class="pp-confirm-content" @click.stop>
      <div class="confirm-icon" v-if="$slots.icon">
        <slot name="icon">
          <div class="warning-circle">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" fill="#f5a623" stroke="#f5a623"></path>
              <line x1="12" y1="9" x2="12" y2="13" stroke="white"></line>
              <line x1="12" y1="17" x2="12.01" y2="17" stroke="white"></line>
            </svg>
          </div>
        </slot>
      </div>
      <h3 class="confirm-title" v-if="title">{{ title }}</h3>
      <p class="confirm-message" v-if="message">{{ message }}</p>
      
      <div class="confirm-body" v-if="$slots.default">
        <slot></slot>
      </div>

      <div class="confirm-actions">
        <PPButton 
          :variant="confirmVariant" 
          block 
          @click="onConfirm"
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
import PPButton from './PPButton.vue';
import type { PropType } from 'vue';

const props = defineProps({
  modelValue: Boolean,
  title: String,
  message: String,
  confirmText: {
    type: String,
    default: 'Confirm'
  },
  cancelText: {
    type: String,
    default: 'Cancel'
  },
  confirmVariant: {
    type: String as PropType<'primary' | 'secondary' | 'outline' | 'ghost' | 'outline-danger'>,
    default: 'primary' // could be 'outline-danger'
  },
  dismissOnOverlayClick: {
    type: Boolean,
    default: false
  }
});

const emit = defineEmits(['update:modelValue', 'confirm', 'cancel']);

const onOverlayClick = () => {
  if (props.dismissOnOverlayClick) {
    onCancel();
  }
};

const onConfirm = () => {
  emit('confirm');
  emit('update:modelValue', false);
};

const onCancel = () => {
  emit('cancel');
  emit('update:modelValue', false);
};
</script>

<style scoped>
.pp-confirm-overlay {
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

.pp-confirm-content {
  background: #fff;
  border-radius: 16px;
  width: 100%;
  max-width: 340px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.15);
  padding: 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  animation: slideUp 0.2s ease;
}

.confirm-icon {
  margin-bottom: 24px;
  display: flex;
  justify-content: center;
}

.warning-circle {
  width: 64px;
  height: 64px;
  border-radius: 50%;
  background-color: #fff8e6;
  color: #f5a623;
  display: flex;
  align-items: center;
  justify-content: center;
}

.warning-circle svg {
  width: 32px;
  height: 32px;
}

.confirm-title {
  font-size: 20px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  margin: 0 0 8px 0;
}

.confirm-message {
  font-size: 15px;
  color: #666;
  margin: 0 0 24px 0;
  line-height: 1.5;
}

.confirm-body {
  width: 100%;
  margin-bottom: 24px;
  text-align: left;
}

.confirm-actions {
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
