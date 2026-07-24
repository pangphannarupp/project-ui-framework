<template>
  <div class="pp-segment" :class="[`variant-${variant}`]" ref="segmentRef">
    <div 
      v-if="variant !== 'underline'" 
      class="pp-segment-indicator" 
      :style="indicatorStyle"
    ></div>
    <slot></slot>
  </div>
</template>

<script setup lang="ts">
import { provide, ref, watch, onMounted, nextTick } from 'vue';

const props = withDefaults(defineProps<{
  modelValue: string | number;
  variant?: 'pill' | 'underline' | 'block' | 'material3' | 'ios-glass';
}>(), {
  variant: 'pill'
});

const emit = defineEmits(['update:modelValue', 'change']);

const activeValue = ref(props.modelValue);
const segmentRef = ref<HTMLElement | null>(null);

const indicatorStyle = ref<Record<string, any>>({
  width: '0px',
  height: '100%',
  transform: 'translate(0px, 0px)',
  opacity: 0
});

const updateIndicator = async () => {
  if (!segmentRef.value) return;
  await nextTick();
  const activeBtn = segmentRef.value.querySelector('.pp-segment-button--active') as HTMLElement;
  if (activeBtn) {
    let top = activeBtn.offsetTop;
    let height = activeBtn.offsetHeight;
    indicatorStyle.value = {
      width: `${activeBtn.offsetWidth}px`,
      height: `${height}px`,
      transform: `translate(${activeBtn.offsetLeft}px, ${top}px)`,
      opacity: 1
    };
  }
};

watch(() => props.modelValue, (newVal) => {
  activeValue.value = newVal;
  updateIndicator();
});

onMounted(() => {
  // Give it a tiny delay to ensure buttons are fully rendered
  setTimeout(updateIndicator, 50);
});

const updateValue = (val: string | number) => {
  activeValue.value = val;
  emit('update:modelValue', val);
  emit('change', val);
  updateIndicator();
};

provide('ppSegmentContext', {
  activeValue,
  updateValue,
  variant: props.variant
});
</script>

<style scoped>
.pp-segment {
  display: flex;
  align-items: center;
  position: relative;
  z-index: 1; /* Establish stacking context */
}

.pp-segment-indicator {
  position: absolute;
  top: 0; 
  left: 0;
  border-radius: var(--pp-segment-radius, 30px);
  background-color: var(--pp-segment-btn-active-bg, var(--pp-primary-variant, #1a2a5e));
  box-shadow: var(--pp-segment-btn-active-shadow, 0 2px 4px rgba(0,0,0,0.1));
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1), width 0.3s cubic-bezier(0.4, 0, 0.2, 1), opacity 0.3s;
  z-index: -1; /* place behind buttons */
}

/* Variant: Pill (Default) */
.pp-segment.variant-pill {
  background-color: var(--pp-segment-bg, #ffffff);
  border: 1px solid var(--pp-segment-border-color, #e0e0e0);
  border-radius: var(--pp-segment-radius, 30px);
  padding: var(--pp-segment-padding, 4px);
  box-shadow: inset 0 1px 3px rgba(0,0,0,0.05);
}

/* Variant: Underline */
.pp-segment.variant-underline {
  background: transparent;
  border-bottom: 2px solid var(--pp-border-color, #e2e8f0);
  border-radius: 0;
  padding: 0;
  gap: 16px;
}
/* Underline doesn't use the standard absolute indicator, though we could animate its bottom border. 
   For now, we keep it simple or implement a separate bottom-indicator later if desired. */

/* Variant: Block */
.pp-segment.variant-block {
  background-color: var(--pp-background-alt, #f1f5f9);
  border-radius: 8px;
  padding: 4px;
  gap: 4px;
}
.pp-segment.variant-block .pp-segment-indicator {
  border-radius: 6px;
  background-color: #ffffff;
  box-shadow: 0 1px 3px rgba(0,0,0,0.1);
}

/* Variant: Material UI 3 */
.pp-segment.variant-material3 {
  background-color: #f3f4f6; /* Surface container */
  border-radius: 30px;
  padding: 4px;
  gap: 0;
}
.pp-segment.variant-material3 .pp-segment-indicator {
  border-radius: 30px;
  background-color: #d8e4ff; /* Primary container M3 */
  box-shadow: none;
}

/* Variant: iOS Liquid Glass */
.pp-segment.variant-ios-glass {
  background: rgba(255, 255, 255, 0.4);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 20px;
  padding: 3px;
  box-shadow: inset 0 1px 2px rgba(0,0,0,0.05);
}
.pp-segment.variant-ios-glass .pp-segment-indicator {
  border-radius: 18px;
  background-color: #ffffff;
  box-shadow: 0 3px 8px rgba(0,0,0,0.12), 0 3px 1px rgba(0,0,0,0.04);
}
</style>
