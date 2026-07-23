<template>
  <div v-if="modelValue" class="pp-time-alert-overlay" :class="`theme-${theme}`" @click="onOverlayClick">
    <div class="pp-time-alert-content" @click.stop>
      <div class="alert-header" v-if="title">
        <h3>{{ title }}</h3>
      </div>
      <div class="alert-body">
        <PPTimePicker 
          :modelValue="timeValue"
          :min="min"
          :max="max"
          :minuteValues="minuteValues"
          :hourCycle="hourCycle"
          :showActionButtons="false"
          :theme="theme"
          @update:modelValue="onTimeUpdate"
        />
      </div>
      <div class="alert-actions">
        <button class="cancel-btn" @click="onCancel">Cancel</button>
        <button class="confirm-btn" @click="onConfirm">OK</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import PPTimePicker from './PPTimePicker.vue';

const props = withDefaults(defineProps<{
  modelValue: boolean; // overlay open state
  timeValue?: string;
  title?: string;
  min?: string;
  max?: string;
  minuteValues?: string | number[];
  hourCycle?: 'h12' | 'h23';
  dismissOnOverlayClick?: boolean;
  theme?: 'light' | 'dark' | 'auto';
}>(), {
  theme: 'auto',
  dismissOnOverlayClick: true,
});

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'update:timeValue', val: string | string[] | null | undefined): void;
  (e: 'confirm', val: string | string[] | null | undefined): void;
  (e: 'cancel'): void;
}>();

// Internal state to hold the selected time before confirming
const internalTime = ref(props.timeValue);

watch(() => props.timeValue, (newVal) => {
  internalTime.value = newVal;
});

const onTimeUpdate = (val: string | string[] | null | undefined) => {
  internalTime.value = Array.isArray(val) ? val[0] : (val || undefined);
};

const onOverlayClick = () => {
  if (props.dismissOnOverlayClick !== false) {
    emit('update:modelValue', false);
  }
};

const onCancel = () => {
  emit('cancel');
  emit('update:modelValue', false);
};

const onConfirm = () => {
  emit('update:timeValue', internalTime.value);
  emit('confirm', internalTime.value);
  emit('update:modelValue', false);
};
</script>

<style scoped>
.pp-time-alert-overlay {
  --alert-bg: #fff;
  --alert-header-color: #333;
  --alert-border-color: #eee;

  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.4);
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 16px;
}

.pp-time-alert-overlay.theme-dark {
  --alert-bg: #1e1e1e;
  --alert-header-color: #fff;
  --alert-border-color: #333;
}

@media (prefers-color-scheme: dark) {
  .pp-time-alert-overlay.theme-auto {
    --alert-bg: #1e1e1e;
    --alert-header-color: #fff;
    --alert-border-color: #333;
  }
}

.pp-time-alert-content {
  background: var(--alert-bg);
  border-radius: 16px;
  width: 100%;
  max-width: 340px;
  max-height: 90vh;
  overflow: hidden;
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.15);
  display: flex;
  flex-direction: column;
}

.alert-header {
  padding: 20px 20px 10px;
  text-align: center;
}

.alert-header h3 {
  margin: 0;
  font-size: 18px;
  font-weight: 600;
  color: var(--alert-header-color);
}

.alert-body {
  padding: 10px 20px 20px;
}

.alert-actions {
  display: flex;
  border-top: 1px solid var(--alert-border-color);
}

.alert-actions button {
  flex: 1;
  padding: 16px;
  background: transparent;
  border: none;
  font-size: 16px;
  font-weight: 600;
  cursor: pointer;
}

.cancel-btn {
  color: #999;
  border-right: 1px solid var(--alert-border-color) !important;
}

.confirm-btn {
  color: #007aff;
}
</style>
