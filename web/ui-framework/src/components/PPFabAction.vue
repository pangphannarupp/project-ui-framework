<template>
  <button 
    class="pp-fab-action" 
    :class="`pp-fab-action--${color}`"
    @click="onClick"
  >
    <slot></slot>
  </button>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
  color?: 'primary' | 'secondary' | 'danger' | 'light';
}>(), {
  color: 'light'
});

const emit = defineEmits(['click']);

const onClick = (e: Event) => {
  emit('click', e);
};
</script>

<style scoped>
.pp-fab-action {
  display: flex;
  align-items: center;
  justify-content: center;
  border: none;
  border-radius: 50%;
  width: 40px;
  height: 40px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  cursor: pointer;
  transition: all 0.2s ease;
}

.pp-fab-action:hover {
  transform: scale(1.1);
}

.pp-fab-action--light {
  background-color: #ffffff;
  color: #333333;
}
.pp-fab-action--light:hover { background-color: #f5f5f5; }

.pp-fab-action--primary {
  background-color: var(--pp-primary-variant, #1a2a5e);
  color: white;
}
.pp-fab-action--primary:hover { background-color: #121e42; }

.pp-fab-action--secondary {
  background-color: #e0e0e0;
  color: #333;
}
.pp-fab-action--secondary:hover { background-color: #cccccc; }

.pp-fab-action--danger {
  background-color: #d32f2f;
  color: white;
}
.pp-fab-action--danger:hover { background-color: #b71c1c; }
</style>
