<template>
  <div 
    class="pp-stepper"
    :class="[`orientation-${orientation}`]"
  >
    <div 
      v-for="(step, index) in steps" 
      :key="index"
      class="stepper-item"
      :class="[
        getStepStatus(index),
        { 'is-last': index === steps.length - 1 }
      ]"
    >
      <!-- Line Connector -->
      <div v-if="index !== steps.length - 1" class="stepper-line"></div>

      <!-- Step Indicator -->
      <div class="stepper-head" @click="handleStepClick(index)">
        <div class="stepper-icon">
          <ion-icon v-if="getStepStatus(index) === 'is-completed'" :icon="checkmark" />
          <ion-icon v-else-if="step.icon" :icon="step.icon" />
          <span v-else>{{ index + 1 }}</span>
        </div>
      </div>

      <!-- Step Content -->
      <div class="stepper-content">
        <div class="stepper-title" @click="handleStepClick(index)">
          {{ step.title }}
        </div>
        <div v-if="step.description" class="stepper-description">
          {{ step.description }}
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';
import { checkmark } from 'ionicons/icons';

export interface StepperStep {
  title: string;
  description?: string;
  icon?: string;
}

const props = withDefaults(defineProps<{
  steps: StepperStep[];
  activeStep?: number;
  orientation?: 'horizontal' | 'vertical';
  clickable?: boolean;
}>(), {
  activeStep: 0,
  orientation: 'horizontal',
  clickable: false
});

const emit = defineEmits(['update:activeStep']);

const getStepStatus = (index: number) => {
  if (index < props.activeStep) return 'is-completed';
  if (index === props.activeStep) return 'is-active';
  return 'is-pending';
};

const handleStepClick = (index: number) => {
  if (props.clickable) {
    emit('update:activeStep', index);
  }
};
</script>

<style scoped>
.pp-stepper {
  display: flex;
  width: 100%;
}

/* Horizontal */
.pp-stepper.orientation-horizontal {
  flex-direction: row;
  align-items: flex-start;
}

.pp-stepper.orientation-horizontal .stepper-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  flex: 1;
  position: relative;
}

.pp-stepper.orientation-horizontal .stepper-item:not(.is-last) {
  padding-right: 16px;
}

.pp-stepper.orientation-horizontal .stepper-line {
  position: absolute;
  top: 14px; /* Half of icon height (28px) */
  left: 50%;
  width: 100%;
  height: 2px;
  background-color: #e2e8f0;
  z-index: 1;
}

.pp-stepper.orientation-horizontal .stepper-item.is-completed .stepper-line {
  background-color: #3b82f6;
}

.pp-stepper.orientation-horizontal .stepper-content {
  text-align: center;
  margin-top: 12px;
}

/* Vertical */
.pp-stepper.orientation-vertical {
  flex-direction: column;
}

.pp-stepper.orientation-vertical .stepper-item {
  display: flex;
  position: relative;
  padding-bottom: 24px;
}

.pp-stepper.orientation-vertical .stepper-line {
  position: absolute;
  top: 32px;
  bottom: 0;
  left: 13px; /* Center of icon (28/2 - 1) */
  width: 2px;
  background-color: #e2e8f0;
  z-index: 1;
}

.pp-stepper.orientation-vertical .stepper-item.is-completed .stepper-line {
  background-color: #3b82f6;
}

.pp-stepper.orientation-vertical .stepper-item.is-last {
  padding-bottom: 0;
}

.pp-stepper.orientation-vertical .stepper-content {
  margin-left: 16px;
  padding-top: 4px;
}

/* Shared */
.stepper-head {
  position: relative;
  z-index: 2;
  cursor: pointer;
}

.stepper-icon {
  width: 28px;
  height: 28px;
  border-radius: 50%;
  background-color: #f1f5f9;
  border: 2px solid #e2e8f0;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 14px;
  font-weight: 600;
  color: #64748b;
  transition: all 0.2s ease;
}

.stepper-title {
  font-weight: 600;
  color: #64748b;
  font-size: 14px;
  cursor: pointer;
}

.stepper-description {
  font-size: 12px;
  color: #94a3b8;
  margin-top: 4px;
}

/* States */
.stepper-item.is-active .stepper-icon {
  background-color: #3b82f6;
  border-color: #3b82f6;
  color: white;
}

.stepper-item.is-active .stepper-title {
  color: #1e293b;
}

.stepper-item.is-completed .stepper-icon {
  background-color: white;
  border-color: #3b82f6;
  color: #3b82f6;
}

.stepper-item.is-completed .stepper-title {
  color: #1e293b;
}
</style>
