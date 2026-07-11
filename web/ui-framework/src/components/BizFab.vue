<template>
  <div 
    class="biz-fab" 
    :class="[
      `biz-fab--${position}`,
      { 'biz-fab--extended': extended },
      { 'biz-fab--active': active }
    ]"
  >
    <button 
      class="biz-fab-button" 
      :class="`biz-fab-button--${color}`"
      @click="onClick"
      :disabled="disabled"
    >
      <span class="biz-fab-icon">
        <slot name="icon">
          <!-- Default Plus Icon -->
          <svg viewBox="0 0 24 24" width="24" height="24" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <line x1="12" y1="5" x2="12" y2="19"></line>
            <line x1="5" y1="12" x2="19" y2="12"></line>
          </svg>
        </slot>
      </span>
      <span class="biz-fab-text" v-if="extended && $slots.default">
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
  extended?: boolean;
  disabled?: boolean;
}>(), {
  position: 'bottom-right',
  color: 'primary',
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

provide('bizFabContext', {
  active,
  position: props.position
});
</script>

<style scoped>
.biz-fab {
  position: relative;
  display: inline-flex;
  flex-direction: column;
  align-items: center;
  z-index: 99;
}

.biz-fab--bottom-right, .biz-fab--top-right { align-items: flex-end; }
.biz-fab--bottom-left, .biz-fab--top-left { align-items: flex-start; }

.biz-fab-button {
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

.biz-fab-button:not(.biz-fab--extended) {
  padding: 0;
  width: 56px;
}

.biz-fab-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.3s ease;
}

.biz-fab--active .biz-fab-icon {
  transform: rotate(45deg);
}

.biz-fab-text {
  margin-left: 8px;
  font-weight: 600;
  font-size: 14px;
  white-space: nowrap;
}

/* Colors */
.biz-fab-button--primary {
  background-color: var(--biz-primary-variant, #1a2a5e);
  color: white;
}
.biz-fab-button--primary:hover { background-color: #121e42; }

.biz-fab-button--secondary {
  background-color: #e0e0e0;
  color: #333;
}
.biz-fab-button--secondary:hover { background-color: #cccccc; }

.biz-fab-button--danger {
  background-color: #d32f2f;
  color: white;
}
.biz-fab-button--danger:hover { background-color: #b71c1c; }

.biz-fab-button:disabled {
  background-color: #bdbdbd;
  cursor: not-allowed;
  box-shadow: none;
}
</style>
