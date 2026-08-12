<template>
  <button
    :class="[
      'pp-button',
      `pp-button--${variant}`,
      `pp-button--size-${size}`,
      { 'pp-button--block': block },
      { 'pp-button--disabled': disabled || loading },
      { 'pp-button--loading': loading },
      { 'pp-button--rounded': rounded }
    ]"
    :disabled="disabled || loading"
    :type="type"
  >
    <!-- Loading Spinner -->
    <span v-if="loading" class="pp-button__spinner">
      <slot name="loading">
        <svg class="pp-spinner" viewBox="0 0 50 50">
          <circle class="path" cx="25" cy="25" r="20" fill="none" stroke-width="5"></circle>
        </svg>
      </slot>
    </span>
    
    <span class="pp-button__icon-left" v-if="$slots.iconLeft && !loading">
      <slot name="iconLeft"></slot>
    </span>
    <span class="pp-button__text" :style="{ opacity: loading ? 0 : 1 }">
      <slot></slot>
    </span>
    <span class="pp-button__icon-right" v-if="$slots.iconRight && !loading">
      <slot name="iconRight"></slot>
    </span>
  </button>
</template>

<script setup lang="ts">
withDefaults(defineProps<{
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost' | 'danger' | 'success' | 'outline-danger' | 'gradient' | 'elevated' | 'soft';
  size?: 'small' | 'medium' | 'large';
  block?: boolean;
  disabled?: boolean;
  loading?: boolean;
  rounded?: boolean;
  type?: 'button' | 'submit' | 'reset';
}>(), {
  variant: 'primary',
  size: 'medium',
  block: false,
  disabled: false,
  loading: false,
  rounded: false,
  type: 'button'
});
</script>

<style scoped>
.pp-button {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  border-radius: 12px;
  font-weight: 600;
  cursor: pointer;
  border: 1px solid transparent;
  transition: all 0.2s ease-in-out;
  font-family: inherit;
  position: relative;
  overflow: hidden;
}

/* Sizes */
.pp-button--size-small {
  padding: 6px 12px;
  font-size: 12px;
}
.pp-button--size-medium {
  padding: 10px 16px;
  font-size: 14px;
}
.pp-button--size-large {
  padding: 14px 24px;
  font-size: 16px;
}

.pp-button--rounded {
  border-radius: 9999px;
}

.pp-button--block {
  display: flex;
  width: 100%;
}

/* Primary Variant */
.pp-button--primary {
  background-color: var(--pp-primary-variant, #1a2a5e);
  color: #ffffff;
}
.pp-button--primary:not(.pp-button--disabled):hover {
  background-color: #121e42;
  box-shadow: 0 4px 12px rgba(26, 42, 94, 0.2);
}

/* Secondary Variant */
.pp-button--secondary {
  background-color: #f1f5f9;
  color: #334155;
}
.pp-button--secondary:not(.pp-button--disabled):hover {
  background-color: #e2e8f0;
}

/* Danger Variant */
.pp-button--danger {
  background-color: #ef4444;
  color: #ffffff;
}
.pp-button--danger:not(.pp-button--disabled):hover {
  background-color: #dc2626;
  box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
}

/* Success Variant */
.pp-button--success {
  background-color: #10b981;
  color: #ffffff;
}
.pp-button--success:not(.pp-button--disabled):hover {
  background-color: #059669;
  box-shadow: 0 4px 12px rgba(16, 185, 129, 0.2);
}

/* Outline Variants */
.pp-button--outline {
  background-color: transparent;
  border-color: #cbd5e1;
  color: #3b82f6;
}
.pp-button--outline:not(.pp-button--disabled):hover {
  background-color: #eff6ff;
  border-color: #3b82f6;
}

.pp-button--outline-danger {
  background-color: transparent;
  border-color: #fca5a5;
  color: #ef4444;
}
.pp-button--outline-danger:not(.pp-button--disabled):hover {
  background-color: #fef2f2;
  border-color: #ef4444;
}

/* Gradient Variant */
.pp-button--gradient {
  background: linear-gradient(135deg, #3b82f6 0%, #8b5cf6 100%);
  color: #ffffff;
  border: none;
}
.pp-button--gradient:not(.pp-button--disabled):hover {
  background: linear-gradient(135deg, #2563eb 0%, #7c3aed 100%);
  box-shadow: 0 4px 15px rgba(139, 92, 246, 0.4);
}

/* Elevated (3D) Variant */
.pp-button--elevated {
  background-color: #ffffff;
  color: #0f172a;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
  border: 1px solid #e2e8f0;
}
.pp-button--elevated:not(.pp-button--disabled):hover {
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
  transform: translateY(-2px);
}
.pp-button--elevated:not(.pp-button--disabled):active {
  box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  transform: translateY(0);
}

/* Soft (Tonal) Variant */
.pp-button--soft {
  background-color: #eff6ff;
  color: #2563eb;
}
.pp-button--soft:not(.pp-button--disabled):hover {
  background-color: #dbeafe;
}

/* Ghost Variant */
.pp-button--ghost {
  background-color: transparent;
  color: #3b82f6;
}
.pp-button--ghost:not(.pp-button--disabled):hover {
  background-color: #eff6ff;
}

/* Disabled & Loading */
.pp-button--disabled {
  opacity: 0.6;
  cursor: not-allowed;
}
.pp-button--loading {
  pointer-events: none;
}

/* Spinner positioning */
.pp-button__spinner {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  display: flex;
  align-items: center;
  justify-content: center;
}

.pp-button__text {
  transition: opacity 0.2s ease;
}

.pp-button__icon-left,
.pp-button__icon-right {
  display: inline-flex;
  align-items: center;
}

/* SVG Spinner Animation */
.pp-spinner {
  animation: rotate 2s linear infinite;
  width: 24px;
  height: 24px;
}
.pp-button--size-small .pp-spinner {
  width: 18px;
  height: 18px;
}
.pp-spinner .path {
  stroke: currentColor;
  stroke-linecap: round;
  animation: dash 1.5s ease-in-out infinite;
}

@keyframes rotate {
  100% {
    transform: rotate(360deg);
  }
}
@keyframes dash {
  0% {
    stroke-dasharray: 1, 150;
    stroke-dashoffset: 0;
  }
  50% {
    stroke-dasharray: 90, 150;
    stroke-dashoffset: -35;
  }
  100% {
    stroke-dasharray: 90, 150;
    stroke-dashoffset: -124;
  }
}
</style>
