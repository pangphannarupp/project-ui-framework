<template>
  <div 
    class="pp-fab" 
    :class="[
      `pp-fab--${position}`,
      { 'pp-fab--extended': extended },
      { 'pp-fab--active': active }
    ]"
  >
    <button 
      class="pp-fab-button" 
      :class="[
        `pp-fab-button--${color}`,
        `pp-fab-button--${variant}`,
        { 'pp-fab-button--extended': extended }
      ]"
      @click="onClick"
      :disabled="disabled"
    >
      <span class="pp-fab-icon">
        <slot name="icon">
          <!-- Default Plus Icon -->
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <line x1="12" y1="5" x2="12" y2="19"></line>
            <line x1="5" y1="12" x2="19" y2="12"></line>
          </svg>
        </slot>
      </span>
      <span class="pp-fab-text" v-if="$slots.default">
        <slot></slot>
      </span>
    </button>
    <slot name="list"></slot>
  </div>
</template>

<script setup lang="ts">
import { provide, ref } from 'vue';

const props = withDefaults(defineProps<{
  position?: 'bottom-right' | 'bottom-left' | 'top-right' | 'top-left' | 'center';
  color?: 'primary' | 'secondary' | 'danger';
  variant?: 'solid' | 'gradient' | 'soft' | 'outline' | 'glass';
  extended?: boolean;
  disabled?: boolean;
}>(), {
  position: 'bottom-right',
  color: 'primary',
  variant: 'solid',
  extended: false,
  disabled: false
});

const emit = defineEmits(['click']);

const active = ref(false);

const onClick = () => {
  if (props.disabled) return;
  active.value = !active.value;
  emit('click', active.value);
};

provide('ppFabContext', {
  active,
  position: props.position
});
</script>

<style scoped>
.pp-fab {
  position: absolute;
  display: inline-flex;
  flex-direction: column;
  align-items: center;
  z-index: 99;
}

.pp-fab--bottom-right { bottom: 16px; right: 16px; align-items: flex-end; }
.pp-fab--bottom-left { bottom: 16px; left: 16px; align-items: flex-start; }
.pp-fab--top-right { top: 16px; right: 16px; align-items: flex-end; }
.pp-fab--top-left { top: 16px; left: 16px; align-items: flex-start; }
.pp-fab--center { top: 50%; left: 50%; transform: translate(-50%, -50%); }

.pp-fab-button {
  display: flex;
  align-items: center;
  justify-content: center;
  border: none;
  border-radius: 28px;
  min-width: 56px;
  height: 56px;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  padding: 0 16px;
}

.pp-fab-button:not(.pp-fab-button--extended) {
  padding: 0;
}

.pp-fab-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.3s ease;
}

.pp-fab--active .pp-fab-icon {
  transform: rotate(45deg);
}

.pp-fab-text {
  font-weight: 600;
  font-size: 14px;
  white-space: nowrap;
  overflow: hidden;
  max-width: 0;
  opacity: 0;
  margin-left: 0;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.pp-fab-button--extended .pp-fab-text {
  max-width: 200px;
  opacity: 1;
  margin-left: 8px;
}

/* Solid Variants (Default) */
.pp-fab-button--solid.pp-fab-button--primary {
  background-color: var(--pp-primary-variant, #1a2a5e);
  color: white;
}
.pp-fab-button--solid.pp-fab-button--primary:hover { background-color: #121e42; }

.pp-fab-button--solid.pp-fab-button--secondary {
  background-color: #e0e0e0;
  color: #333;
}
.pp-fab-button--solid.pp-fab-button--secondary:hover { background-color: #cccccc; }

.pp-fab-button--solid.pp-fab-button--danger {
  background-color: #d32f2f;
  color: white;
}
.pp-fab-button--solid.pp-fab-button--danger:hover { background-color: #b71c1c; }

/* Gradient Variants */
.pp-fab-button--gradient {
  background: linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%);
  color: white;
  border: none;
}
.pp-fab-button--gradient:hover {
  background: linear-gradient(135deg, #2563eb 0%, #7c3aed 100%);
  box-shadow: 0 6px 16px rgba(139, 92, 246, 0.4);
}

/* Soft Variants */
.pp-fab-button--soft {
  background-color: #eff6ff;
  color: #2563eb;
  box-shadow: 0 4px 10px rgba(37, 99, 235, 0.15);
}
.pp-fab-button--soft:hover {
  background-color: #dbeafe;
}

/* Outline Variants */
.pp-fab-button--outline {
  background-color: #ffffff;
  color: var(--pp-primary-variant, #1a2a5e);
  border: 2px solid var(--pp-primary-variant, #1a2a5e);
}
.pp-fab-button--outline:hover {
  background-color: #f8fafc;
}

/* Glass Variants */
.pp-fab-button--glass {
  background-color: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border: 1px solid rgba(255, 255, 255, 0.4);
  color: var(--pp-primary-variant, #1a2a5e);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}
.pp-fab-button--glass:hover {
  background-color: rgba(255, 255, 255, 0.8);
}

.pp-fab-button:disabled {
  background-color: #bdbdbd;
  cursor: not-allowed;
  box-shadow: none;
}
</style>
