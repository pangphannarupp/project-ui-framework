<template>
  <Teleport to="body">
    <transition name="pp-web-toast-fade">
      <div v-if="modelValue" class="pp-web-toast" :class="[`is-${position}`, `is-${type}`]">
        <div class="pp-web-toast-icon">
          <slot name="icon">
            <svg v-if="type === 'success'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <polyline points="20 6 9 17 4 12"></polyline>
            </svg>
            <svg v-else-if="type === 'error'" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="12" r="10"></circle>
              <line x1="15" y1="9" x2="9" y2="15"></line>
              <line x1="9" y1="9" x2="15" y2="15"></line>
            </svg>
            <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="12" r="10"></circle>
              <line x1="12" y1="16" x2="12" y2="12"></line>
              <line x1="12" y1="8" x2="12.01" y2="8"></line>
            </svg>
          </slot>
        </div>
        <div class="pp-web-toast-content">
          <div v-if="title" class="pp-web-toast-title">{{ title }}</div>
          <div class="pp-web-toast-message">{{ message }}</div>
        </div>
        <div v-if="closable" class="pp-web-toast-close" @click="$emit('update:modelValue', false)">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <line x1="18" y1="6" x2="6" y2="18"></line>
            <line x1="6" y1="6" x2="18" y2="18"></line>
          </svg>
        </div>
      </div>
    </transition>
  </Teleport>
</template>

<script setup lang="ts">
import { watch, onUnmounted } from 'vue';

const props = defineProps({
  modelValue: Boolean,
  message: String,
  title: String,
  type: {
    type: String,
    default: 'info' // 'success', 'error', 'warning', 'info'
  },
  position: {
    type: String,
    default: 'top-right' // 'top-right', 'top-left', 'bottom-right', 'bottom-left', 'top-center', 'bottom-center'
  },
  duration: {
    type: Number,
    default: 3000
  },
  closable: {
    type: Boolean,
    default: true
  }
});

const emit = defineEmits(['update:modelValue']);
let timer: ReturnType<typeof setTimeout> | null = null;

const startTimer = () => {
  if (props.duration > 0) {
    timer = setTimeout(() => {
      emit('update:modelValue', false);
    }, props.duration);
  }
};

watch(() => props.modelValue, (newVal) => {
  if (newVal) {
    if (timer) clearTimeout(timer);
    startTimer();
  }
});

onUnmounted(() => {
  if (timer) clearTimeout(timer);
});
</script>

<style scoped>
.pp-web-toast {
  position: fixed;
  display: flex;
  align-items: flex-start;
  gap: 12px;
  background-color: white;
  color: #333;
  padding: 16px;
  border-radius: 8px;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
  z-index: 9999;
  min-width: 300px;
  max-width: 400px;
  border-left: 4px solid #0066cc;
}

.pp-web-toast.is-success { border-left-color: #4caf50; }
.pp-web-toast.is-error { border-left-color: #f44336; }
.pp-web-toast.is-warning { border-left-color: #ff9800; }
.pp-web-toast.is-info { border-left-color: #0066cc; }

/* Positions */
.pp-web-toast.is-top-right { top: 24px; right: 24px; }
.pp-web-toast.is-top-left { top: 24px; left: 24px; }
.pp-web-toast.is-bottom-right { bottom: 24px; right: 24px; }
.pp-web-toast.is-bottom-left { bottom: 24px; left: 24px; }
.pp-web-toast.is-top-center { top: 24px; left: 50%; transform: translateX(-50%); }
.pp-web-toast.is-bottom-center { bottom: 24px; left: 50%; transform: translateX(-50%); }

.pp-web-toast-icon {
  flex-shrink: 0;
  width: 24px;
  height: 24px;
}
.pp-web-toast.is-success .pp-web-toast-icon { color: #4caf50; }
.pp-web-toast.is-error .pp-web-toast-icon { color: #f44336; }
.pp-web-toast.is-warning .pp-web-toast-icon { color: #ff9800; }
.pp-web-toast.is-info .pp-web-toast-icon { color: #0066cc; }

.pp-web-toast-content {
  flex-grow: 1;
}

.pp-web-toast-title {
  font-weight: 600;
  font-size: 15px;
  margin-bottom: 4px;
}

.pp-web-toast-message {
  font-size: 14px;
  color: #666;
  line-height: 1.4;
}

.pp-web-toast-close {
  flex-shrink: 0;
  width: 20px;
  height: 20px;
  color: #999;
  cursor: pointer;
  transition: color 0.2s;
}

.pp-web-toast-close:hover {
  color: #333;
}

.pp-web-toast-fade-enter-active,
.pp-web-toast-fade-leave-active {
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.pp-web-toast-fade-enter-from,
.pp-web-toast-fade-leave-to {
  opacity: 0;
  transform: translateY(-20px);
}

.pp-web-toast.is-top-center.pp-web-toast-fade-enter-from,
.pp-web-toast.is-top-center.pp-web-toast-fade-leave-to {
  transform: translate(-50%, -20px);
}
.pp-web-toast.is-bottom-center.pp-web-toast-fade-enter-from,
.pp-web-toast.is-bottom-center.pp-web-toast-fade-leave-to {
  transform: translate(-50%, 20px);
}
</style>
