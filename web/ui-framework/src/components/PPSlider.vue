<template>
  <div class="pp-slider-wrapper" :class="[`variant-${variant}`, { 'is-disabled': disabled }]">
    <!-- Optional Header/Label -->
    <div v-if="label || showValue" class="pp-slider-header">
      <span v-if="label" class="pp-slider-label">{{ label }}</span>
      <span v-if="showValue" class="pp-slider-value-display">
        {{ formatValueDisplay(modelValue) }}
      </span>
    </div>
    
    <ion-range
      class="pp-slider"
      :min="min"
      :max="max"
      :step="step"
      :value="modelValue"
      :dual-knobs="dualKnobs"
      :snaps="snaps"
      :pin="pin"
      :ticks="ticks"
      :disabled="disabled"
      :color="color"
      @ionChange="onChange"
    >
      <ion-icon v-if="startIcon" :icon="startIcon" slot="start"></ion-icon>
      <ion-icon v-if="endIcon" :icon="endIcon" slot="end"></ion-icon>
    </ion-range>
  </div>
</template>

<script setup lang="ts">
import { IonRange, IonIcon } from '@ionic/vue';

withDefaults(defineProps<{
  modelValue?: number | { lower: number; upper: number };
  min?: number;
  max?: number;
  step?: number;
  dualKnobs?: boolean;
  snaps?: boolean;
  pin?: boolean;
  ticks?: boolean;
  disabled?: boolean;
  color?: 'primary' | 'secondary' | 'tertiary' | 'success' | 'warning' | 'danger' | 'light' | 'medium' | 'dark';
  label?: string;
  showValue?: boolean;
  startIcon?: any;
  endIcon?: any;
  variant?: 'standard' | 'm3';
}>(), {
  min: 0,
  max: 100,
  step: 1,
  dualKnobs: false,
  snaps: false,
  pin: false,
  ticks: false,
  disabled: false,
  color: 'primary',
  showValue: false,
  variant: 'standard'
});

const emit = defineEmits(['update:modelValue', 'change']);

const onChange = (e: any) => {
  emit('update:modelValue', e.detail.value);
  emit('change', e.detail.value);
};

const formatValueDisplay = (val: any) => {
  if (val === undefined || val === null) return '';
  if (typeof val === 'object' && val.lower !== undefined && val.upper !== undefined) {
    return `${val.lower} - ${val.upper}`;
  }
  return val.toString();
};
</script>

<style scoped>
.pp-slider-wrapper {
  width: 100%;
  padding: 8px 0;
  display: flex;
  flex-direction: column;
}

.pp-slider-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 16px;
  margin-bottom: -4px;
}

.pp-slider-label {
  font-size: 14px;
  font-weight: 500;
  color: var(--pp-primary-variant, #1a2a5e);
}

.pp-slider-value-display {
  font-size: 14px;
  font-weight: 700;
  color: var(--pp-primary, #003399);
}

.pp-slider {
  --bar-background: #e0e0e0;
  --bar-background-active: var(--pp-primary, #003399);
  --bar-height: 4px;
  --bar-border-radius: 4px;
  --knob-background: #ffffff;
  --knob-border-radius: 50%;
  --knob-box-shadow: 0 2px 4px rgba(0,0,0,0.2);
  --knob-size: 24px;
  --pin-background: var(--pp-primary, #003399);
  --pin-color: #ffffff;
}

.is-disabled .pp-slider-label,
.is-disabled .pp-slider-value-display {
  opacity: 0.5;
}

/* Material 3 Variant */
.variant-m3 .pp-slider {
  --bar-height: 16px;
  --bar-border-radius: 16px;
  --knob-size: 28px;
  --knob-background: #ffffff;
  --knob-box-shadow: 0 4px 8px rgba(0,0,0,0.15);
  --bar-background: rgba(var(--pp-primary-rgb, 0, 51, 153), 0.15);
  --bar-background-active: var(--pp-primary, #003399);
}
.variant-m3 .pp-slider::part(knob) {
  border: 2px solid var(--pp-primary, #003399);
}
</style>
