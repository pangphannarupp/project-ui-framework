<template>
  <div class="biz-time-picker-island-wrapper">
    <BizDynamicIsland 
      :modelValue="internalModelValue" 
      :state="islandState"
      :position="position"
      :fullWidth="fullWidth"
      :offset="offset"
      bgColor="#ffffff"
      textColor="#333333"
      wrapperClass="time-picker-island"
      @update:modelValue="handleIslandUpdate"
    >
      <template #minimal v-if="islandState === 'minimal'">
        <div class="calendar-minimal-dot"></div>
      </template>

      <template #expanded-body v-if="islandState === 'expanded'">
        <div class="calendar-island-body">
          <BizTimePicker 
            :title="title"
            :modelValue="timeValue"
            :min="min"
            :max="max"
            :minuteValues="minuteValues"
            :hourCycle="hourCycle"
            :showActionButtons="showActionButtons"
            @update:modelValue="onTimeUpdate"
            @change="(val) => $emit('change', val)"
            @confirm="handleConfirm"
            @cancel="handleCancel"
          />
        </div>
      </template>
    </BizDynamicIsland>
  </div>
</template>

<script setup lang="ts">
import { ref, watch } from 'vue';
import BizDynamicIsland from './BizDynamicIsland.vue';
import BizTimePicker from './BizTimePicker.vue';

const props = withDefaults(defineProps<{
  modelValue: boolean;
  timeValue?: string;
  title?: string;
  min?: string;
  max?: string;
  minuteValues?: string | number[];
  hourCycle?: 'h12' | 'h23';
  showActionButtons?: boolean;
  position?: 'top' | 'bottom' | 'left' | 'right';
  fullWidth?: boolean;
  offset?: number;
}>(), {
  position: 'top',
  fullWidth: false,
  offset: 16
});

const emit = defineEmits<{
  (e: 'update:modelValue', val: boolean): void;
  (e: 'update:timeValue', val: string | string[] | null | undefined): void;
  (e: 'change', val: string | string[] | null | undefined): void;
  (e: 'confirm', val: string | string[] | null | undefined): void;
  (e: 'cancel'): void;
}>();

const islandState = ref('minimal');
const internalModelValue = ref(false);
let expandTimeout: any;
let closeTimeout: any;

watch(() => props.modelValue, (val) => {
  if (val) {
    internalModelValue.value = true;
    islandState.value = 'minimal';
    clearTimeout(expandTimeout);
    expandTimeout = setTimeout(() => {
      islandState.value = 'expanded';
    }, 400); // Allow entry animation to finish before expanding
  } else {
    if (internalModelValue.value) {
      islandState.value = 'minimal';
      clearTimeout(closeTimeout);
      closeTimeout = setTimeout(() => {
        internalModelValue.value = false;
      }, 400);
    }
  }
});

const handleIslandUpdate = (val: boolean) => {
  if (!val) {
    emit('update:modelValue', false);
  } else {
    internalModelValue.value = val;
  }
};

const onTimeUpdate = (val: string | string[] | null | undefined) => {
  emit('update:timeValue', val);
};

const handleConfirm = (val: string | string[] | null | undefined) => {
  emit('confirm', val);
  emit('update:modelValue', false);
};

const handleCancel = () => {
  emit('cancel');
  emit('update:modelValue', false);
};
</script>

<style scoped>
.calendar-island-body {
  width: 100%;
  height: 100%;
  overflow-y: auto;
  scrollbar-width: none;
  background: white; 
  border-radius: 16px;
  padding: 8px;
  color: #333;
}
.calendar-island-body::-webkit-scrollbar {
  display: none;
}

.calendar-minimal-dot {
  width: 16px;
  height: 16px;
  background-color: var(--biz-color-primary, #1976d2);
  border-radius: 50%;
}
</style>

<style>
.time-picker-island {
  --biz-island-expanded-width: 320px;
  --biz-island-expanded-height: 320px;
  --biz-island-expanded-radius: 24px;
}
</style>
