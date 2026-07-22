<template>
  <button
    :class="[
      'pp-button',
      `pp-button--${variant}`,
      { 'pp-button--block': block },
      { 'pp-button--disabled': disabled }
    ]"
    :disabled="disabled"
    :type="type"
  >
    <span class="pp-button__icon-left" v-if="$slots.iconLeft">
      <slot name="iconLeft"></slot>
    </span>
    <span class="pp-button__text">
      <slot></slot>
    </span>
    <span class="pp-button__icon-right" v-if="$slots.iconRight">
      <slot name="iconRight"></slot>
    </span>
  </button>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost' | 'outline-danger';
  block?: boolean;
  disabled?: boolean;
  type?: 'button' | 'submit' | 'reset';
}>(), {
  variant: 'primary',
  block: false,
  disabled: false,
  type: 'button'
});

</script>

<style scoped>
.pp-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  padding: 16px 24px;
  border-radius: 12px;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
  border: 1px solid transparent;
  transition: all 0.2s ease-in-out;
  font-family: inherit;
}

.pp-button--block {
  display: flex;
  width: 100%;
}

.pp-button--primary {
  background-color: var(--pp-primary-variant, #1a2a5e);
  color: #ffffff;
}

.pp-button--primary:not(.pp-button--disabled):hover {
  background-color: #121e42;
}

.pp-button--secondary {
  background-color: #e0e0e0;
  color: #333333;
}

.pp-button--outline {
  background-color: transparent;
  border-color: #cccccc;
  color: #3b63cc;
}

.pp-button--outline-danger {
  background-color: transparent;
  border-color: #d32f2f;
  color: #d32f2f;
}

.pp-button--ghost {
  background-color: transparent;
  color: #0066cc;
  padding: 0;
}

.pp-button--ghost:not(.pp-button--disabled):hover {
  text-decoration: underline;
}

.pp-button--disabled {
  background-color: #c0c0c0;
  color: #ffffff;
  cursor: not-allowed;
  opacity: 0.8;
}

.pp-button__icon-left,
.pp-button__icon-right {
  display: inline-flex;
  align-items: center;
}
</style>
