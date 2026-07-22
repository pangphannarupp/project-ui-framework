<template>
  <Teleport to="body">
    <transition name="pp-toast-fade">
      <div v-if="modelValue" class="pp-toast">
        <slot name="icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="10"></circle>
            <line x1="12" y1="16" x2="12" y2="12"></line>
            <line x1="12" y1="8" x2="12.01" y2="8"></line>
          </svg>
        </slot>
        <span class="pp-toast-message">{{ message }}</span>
      </div>
    </transition>
  </Teleport>
</template>

<script setup lang="ts">
import { watch, onUnmounted } from 'vue';

const props = defineProps({
  modelValue: Boolean,
  message: String,
  duration: {
    type: Number,
    default: 3000
  }
});

const emit = defineEmits(['update:modelValue']);
let timer: ReturnType<typeof setTimeout> | null = null;

watch(() => props.modelValue, (newVal) => {
  if (newVal) {
    if (timer) clearTimeout(timer);
    timer = setTimeout(() => {
      emit('update:modelValue', false);
    }, props.duration);
  }
});

onUnmounted(() => {
  if (timer) clearTimeout(timer);
});
</script>

<style scoped>
.pp-toast {
  position: fixed;
  bottom: 80px; /* Above bottom nav */
  left: 50%;
  transform: translateX(-50%);
  background-color: #d92d20; /* Red from screenshot */
  color: white;
  padding: 12px 24px;
  border-radius: 24px;
  display: flex;
  align-items: center;
  gap: 8px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  z-index: 9999;
  font-size: 15px;
  font-weight: 500;
  white-space: nowrap;
}

.pp-toast svg {
  width: 20px;
  height: 20px;
}

.pp-toast-fade-enter-active,
.pp-toast-fade-leave-active {
  transition: all 0.3s ease;
}

.pp-toast-fade-enter-from,
.pp-toast-fade-leave-to {
  opacity: 0;
  transform: translate(-50%, 20px);
}
</style>
