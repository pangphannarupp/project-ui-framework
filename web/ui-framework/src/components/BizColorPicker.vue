<template>
  <div class="biz-color-picker">
    <div class="color-grid">
      <!-- Predefined colors provided by the project -->
      <button 
        v-for="(color, index) in colors" 
        :key="index"
        type="button"
        class="color-swatch"
        :class="{ 'is-selected': modelValue === color }"
        :style="{ backgroundColor: color }"
        :aria-label="`Select color ${color}`"
        @click="selectColor(color)"
      >
        <svg v-if="modelValue === color" class="check-icon" viewBox="0 0 24 24" width="16" height="16" stroke="white" stroke-width="3" fill="none" stroke-linecap="round" stroke-linejoin="round" :style="{ stroke: getContrastColor(color) }">
          <polyline points="20 6 9 17 4 12"></polyline>
        </svg>
      </button>

      <!-- Dynamic Custom Color Picker -->
      <div v-if="allowCustom" class="color-swatch dynamic-swatch" :class="{ 'is-selected': isCustomSelected }">
        <label class="color-input-wrapper" aria-label="Select custom color">
          <input 
            type="color" 
            class="color-input" 
            :value="dynamicColor" 
            @input="onDynamicColorChange" 
          />
          <svg v-if="!isCustomSelected" class="plus-icon" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" stroke-linecap="round" stroke-linejoin="round">
            <line x1="12" y1="5" x2="12" y2="19"></line>
            <line x1="5" y1="12" x2="19" y2="12"></line>
          </svg>
          <svg v-else class="check-icon" viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="3" fill="none" stroke-linecap="round" stroke-linejoin="round" :style="{ stroke: getContrastColor(dynamicColor) }">
            <polyline points="20 6 9 17 4 12"></polyline>
          </svg>
        </label>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, watch } from 'vue';

const props = withDefaults(defineProps<{
  modelValue?: string;
  colors?: string[];
  allowCustom?: boolean;
}>(), {
  modelValue: '',
  colors: () => [
    '#f44336', '#e91e63', '#9c27b0', '#673ab7', 
    '#3f51b5', '#2196f3', '#03a9f4', '#00bcd4', 
    '#009688', '#4caf50', '#8bc34a', '#cddc39', 
    '#ffeb3b', '#ffc107', '#ff9800', '#ff5722'
  ],
  allowCustom: true
});

const emit = defineEmits<{
  (e: 'update:modelValue', val: string): void;
}>();

// Helper to calculate contrast color (black/white) for checkmark based on background luminance
const getContrastColor = (hex: string) => {
  if (!hex || !hex.startsWith('#')) return '#ffffff';
  let r = 0, g = 0, b = 0;
  if (hex.length === 4) {
    r = parseInt(hex[1] + hex[1], 16);
    g = parseInt(hex[2] + hex[2], 16);
    b = parseInt(hex[3] + hex[3], 16);
  } else if (hex.length === 7) {
    r = parseInt(hex.substring(1, 3), 16);
    g = parseInt(hex.substring(3, 5), 16);
    b = parseInt(hex.substring(5, 7), 16);
  }
  const yiq = ((r * 299) + (g * 587) + (b * 114)) / 1000;
  return (yiq >= 128) ? '#000000' : '#ffffff';
};

// Check if the current selected color is a custom color (not in the predefined colors array)
const isCustomSelected = computed(() => {
  return props.modelValue && !props.colors.includes(props.modelValue) && props.allowCustom;
});

// The dynamic color to display in the color picker input
const dynamicColor = ref('#000000');

// Initialize dynamic color from v-model if it's custom
watch(() => props.modelValue, (newVal) => {
  if (newVal && !props.colors.includes(newVal)) {
    dynamicColor.value = newVal;
  }
}, { immediate: true });

const selectColor = (color: string) => {
  emit('update:modelValue', color);
};

const onDynamicColorChange = (event: Event) => {
  const target = event.target as HTMLInputElement;
  const newColor = target.value;
  dynamicColor.value = newColor;
  emit('update:modelValue', newColor);
};
</script>

<style scoped>
.biz-color-picker {
  width: 100%;
  font-family: 'Inter', -apple-system, sans-serif;
}

.color-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
}

.color-swatch {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  border: 2px solid transparent;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.2s, box-shadow 0.2s, border-color 0.2s;
  padding: 0;
  box-sizing: border-box;
  background-color: #f0f0f5; /* Fallback */
}

.color-swatch:hover {
  transform: scale(1.1);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.color-swatch.is-selected {
  border-color: #000;
  box-shadow: 0 2px 8px rgba(0,0,0,0.15);
  transform: scale(1.1);
}

.dynamic-swatch {
  background: conic-gradient(
    from 180deg,
    #ff0000, #ff8000, #ffff00, #00ff00, #00ffff, #0000ff, #8000ff, #ff00ff, #ff0000
  );
  position: relative;
  overflow: hidden;
}

.color-input-wrapper {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  position: absolute;
  top: 0;
  left: 0;
}

.color-input {
  opacity: 0;
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  cursor: pointer;
  padding: 0;
  border: none;
}

.plus-icon,
.check-icon {
  z-index: 1;
  pointer-events: none;
}

.dynamic-swatch.is-selected .color-input-wrapper {
  background-color: v-bind('dynamicColor');
}

.dynamic-swatch.is-selected {
  background: none;
  background-color: v-bind('dynamicColor');
}
</style>
