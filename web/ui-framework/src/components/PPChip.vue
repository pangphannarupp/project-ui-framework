<template>
  <div 
    class="pp-chip"
    :class="[
      `color-${color}`,
      `variant-${variant}`,
      `size-${size}`,
      { 'is-clickable': clickable || $attrs.onClick }
    ]"
    :style="customStyle"
  >
    <div v-if="$slots.icon || icon" class="chip-icon">
      <slot name="icon">
        <ion-icon v-if="icon" :icon="icon" />
      </slot>
    </div>
    
    <span class="chip-label">
      <slot>{{ label }}</slot>
    </span>

    <button v-if="closable" class="chip-close" @click.stop="handleClose">
      <ion-icon :icon="closeCircle" />
    </button>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { IonIcon } from '@ionic/vue';
import { closeCircle } from 'ionicons/icons';

const props = withDefaults(defineProps<{
  label?: string;
  icon?: string;
  color?: 'primary' | 'secondary' | 'success' | 'warning' | 'danger' | 'info' | 'default';
  variant?: 'solid' | 'outline' | 'soft';
  size?: 'sm' | 'md' | 'lg';
  closable?: boolean;
  clickable?: boolean;
  bgColor?: string;
  textColor?: string;
}>(), {
  color: 'default',
  variant: 'solid',
  size: 'md',
  closable: false,
  clickable: false
});

const emit = defineEmits(['close']);

const handleClose = () => {
  emit('close');
};

const customStyle = computed(() => {
  const styles: any = {};
  if (props.bgColor && props.variant === 'solid') {
    styles.backgroundColor = props.bgColor;
    styles.borderColor = props.bgColor;
  }
  if (props.bgColor && props.variant === 'outline') {
    styles.borderColor = props.bgColor;
    styles.color = props.bgColor;
  }
  if (props.textColor) styles.color = props.textColor;
  return styles;
});
</script>

<style scoped>
.pp-chip {
  display: inline-flex;
  align-items: center;
  border-radius: 9999px;
  font-weight: 500;
  transition: all 0.2s ease;
  box-sizing: border-box;
  white-space: nowrap;
}

.pp-chip.is-clickable {
  cursor: pointer;
}
.pp-chip.is-clickable:active {
  transform: scale(0.95);
}

.chip-icon {
  display: flex;
  align-items: center;
  margin-right: 6px;
  font-size: 1.1em;
}

.chip-close {
  display: flex;
  align-items: center;
  justify-content: center;
  background: none;
  border: none;
  padding: 0;
  margin-left: 6px;
  margin-right: -4px;
  cursor: pointer;
  color: inherit;
  opacity: 0.7;
  font-size: 1.2em;
  transition: opacity 0.2s;
}

.chip-close:hover {
  opacity: 1;
}

/* Sizes */
.size-sm { padding: 2px 8px; font-size: 12px; height: 24px; }
.size-md { padding: 4px 12px; font-size: 14px; height: 32px; }
.size-lg { padding: 6px 16px; font-size: 16px; height: 40px; }

/* Colors & Variants */

/* Default */
.color-default.variant-solid { background-color: #e2e8f0; color: #475569; border: 1px solid #e2e8f0; }
.color-default.variant-outline { background-color: transparent; color: #475569; border: 1px solid #cbd5e1; }
.color-default.variant-soft { background-color: #f1f5f9; color: #475569; border: 1px solid transparent; }

/* Primary */
.color-primary.variant-solid { background-color: #3b82f6; color: white; border: 1px solid #3b82f6; }
.color-primary.variant-outline { background-color: transparent; color: #3b82f6; border: 1px solid #3b82f6; }
.color-primary.variant-soft { background-color: #eff6ff; color: #2563eb; border: 1px solid transparent; }

/* Success */
.color-success.variant-solid { background-color: #10b981; color: white; border: 1px solid #10b981; }
.color-success.variant-outline { background-color: transparent; color: #10b981; border: 1px solid #10b981; }
.color-success.variant-soft { background-color: #ecfdf5; color: #059669; border: 1px solid transparent; }

/* Warning */
.color-warning.variant-solid { background-color: #f59e0b; color: white; border: 1px solid #f59e0b; }
.color-warning.variant-outline { background-color: transparent; color: #f59e0b; border: 1px solid #f59e0b; }
.color-warning.variant-soft { background-color: #fffbeb; color: #d97706; border: 1px solid transparent; }

/* Danger */
.color-danger.variant-solid { background-color: #ef4444; color: white; border: 1px solid #ef4444; }
.color-danger.variant-outline { background-color: transparent; color: #ef4444; border: 1px solid #ef4444; }
.color-danger.variant-soft { background-color: #fef2f2; color: #dc2626; border: 1px solid transparent; }
</style>
