<template>
  <div v-if="modelValue" class="pp-alert-overlay" :class="`pp-alert-overlay-${backdropType}`" @click="onOverlayClick">
    <div class="pp-alert-content" @click.stop>
      <div class="alert-icon" v-if="$slots.icon">
        <slot name="icon"></slot>
      </div>
      <h3 class="alert-title" v-if="title">{{ title }}</h3>
      <p class="alert-message" v-if="message">{{ message }}</p>
      
      <div class="alert-body" v-if="$slots.default">
        <slot></slot>
      </div>

      <div class="alert-actions">
        <PPButton 
          variant="primary" 
          block 
          @click="onConfirm"
        >
          {{ confirmText }}
        </PPButton>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import PPButton from './PPButton.vue';

const props = defineProps({
  modelValue: Boolean,
  title: String,
  message: String,
  confirmText: {
    type: String,
    default: 'OK'
  },
  dismissOnOverlayClick: {
    type: Boolean,
    default: true
  },
  backdropType: {
    type: String,
    default: 'default'
  }
});

const emit = defineEmits(['update:modelValue', 'confirm']);

const onOverlayClick = () => {
  if (props.dismissOnOverlayClick) {
    emit('update:modelValue', false);
  }
};

const onConfirm = () => {
  emit('confirm');
  emit('update:modelValue', false);
};
</script>

<style scoped>
.pp-alert-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 16px;
  animation: fadeIn 0.2s ease;
}

.pp-alert-overlay-default {
  background: rgba(0, 0, 0, 0.4);
}

.pp-alert-overlay-blur {
  background: rgba(0, 0, 0, 0.2);
  backdrop-filter: blur(8px);
  -webkit-backdrop-filter: blur(8px);
}

.pp-alert-overlay-clear {
  background: transparent;
}

.pp-alert-overlay-black {
  background: rgba(0, 0, 0, 0.8);
}

.pp-alert-content {
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

.alert-icon {
  margin-bottom: 16px;
  display: flex;
  justify-content: center;
}

.alert-title {
  font-size: 20px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  margin: 0 0 8px 0;
}

.alert-message {
  font-size: 15px;
  color: #666;
  margin: 0 0 24px 0;
  line-height: 1.5;
}

.alert-body {
  width: 100%;
  margin-bottom: 24px;
  text-align: left;
}

.alert-actions {
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
