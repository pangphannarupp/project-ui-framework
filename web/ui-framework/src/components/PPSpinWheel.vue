<template>
  <div class="pp-spin-wheel-wrapper" :class="[`is-variant-${variant}`]">
    <!-- Pointer at the top -->
    <div class="pp-spin-wheel-pointer">
      <div class="pp-pointer-arrow" :style="{ borderTopColor: pointerColor }"></div>
      <div class="pp-pointer-dot" :style="{ backgroundColor: pointerColor }"></div>
    </div>

    <!-- The Wheel -->
    <div 
      class="pp-spin-wheel" 
      :style="wheelStyle" 
      @transitionend="onTransitionEnd"
    >
      <div 
        v-for="(item, index) in processedItems" 
        :key="index"
        class="pp-spin-wheel-slice-text"
        :style="getTextStyle(index)"
      >
        <span class="pp-spin-wheel-label">{{ item.label }}</span>
      </div>
    </div>
    
    <!-- Center Hub -->
    <div class="pp-spin-wheel-center">
      <div v-if="variant === 'donut'" class="pp-donut-hole"></div>
    </div>

    <!-- Casino Lights Rim (only for casino variant) -->
    <div v-if="variant === 'casino'" class="pp-casino-rim">
      <div v-for="n in 24" :key="n" class="pp-casino-light" :style="getLightStyle(n)"></div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

export interface SpinWheelItem {
  label: string;
  value: any;
  color?: string;
}

const props = withDefaults(defineProps<{
  items: SpinWheelItem[];
  spinDuration?: number; // ms
  spins?: number; // number of full rotations
  pointerColor?: string;
  variant?: 'standard' | 'donut' | 'casino';
}>(), {
  spinDuration: 4000,
  spins: 5,
  pointerColor: '#ff3b30',
  variant: 'standard'
});

const emit = defineEmits<{
  (e: 'start'): void;
  (e: 'finish', item: SpinWheelItem): void;
}>();

// Default vibrant colors if none provided
const defaultColors = [
  '#FF3B30', '#FF9500', '#FFCC00', '#4CD964', '#5AC8FA', '#007AFF', '#5856D6', '#FF2D55'
];

const processedItems = computed(() => {
  return props.items.map((item, index) => ({
    ...item,
    color: item.color || defaultColors[index % defaultColors.length]
  }));
});

// State for rotation
const currentRotation = ref(0);
const isSpinning = ref(false);
let targetIndex = -1;

const sliceAngle = computed(() => 360 / props.items.length);

// Generate conic-gradient string for slices
const wheelBackground = computed(() => {
  const numItems = processedItems.value.length;
  if (numItems === 0) return 'transparent';
  
  const angle = 360 / numItems;
  let gradientStr = 'conic-gradient(';
  
  processedItems.value.forEach((item, index) => {
    // Offset by -angle/2 so that the slice centers on 0 deg (top) when unrotated
    const startAngle = (index * angle) - (angle / 2);
    const endAngle = startAngle + angle;
    gradientStr += `${item.color} ${startAngle}deg ${endAngle}deg${index < numItems - 1 ? ', ' : ''}`;
  });
  
  gradientStr += ')';
  return gradientStr;
});

const wheelStyle = computed(() => ({
  background: wheelBackground.value,
  transform: `rotate(${currentRotation.value}deg)`,
  transition: isSpinning.value ? `transform ${props.spinDuration}ms cubic-bezier(0.1, 0.9, 0.2, 1)` : 'none'
}));

const getTextStyle = (index: number) => {
  const angle = index * sliceAngle.value;
  return {
    transform: `rotate(${angle}deg)`
  };
};

const getLightStyle = (n: number) => {
  // 24 lights = 360 / 24 = 15 degrees each
  return {
    transform: `rotate(${n * 15}deg) translateY(-142px)`
  };
};

const spinTo = (index: number) => {
  if (isSpinning.value || index < 0 || index >= props.items.length) return;
  
  isSpinning.value = true;
  targetIndex = index;
  emit('start');

  // We want the slice at `index` to end up exactly at the top (0 deg).
  // Currently, the slice `index` is at `index * sliceAngle` degrees.
  // So to bring it to the top, we must rotate the wheel by `- (index * sliceAngle)`.
  // To make it spin multiple times, we add `spins * 360`.
  
  const currentRotMod = currentRotation.value % 360;
  const currentBase = currentRotation.value - currentRotMod; // The base full rotations we are at
  
  const targetAngle = 360 - (index * sliceAngle.value); // The angle within [0, 360) that brings the slice to the top
  
  // New rotation = current base + full spins requested + target angle
  const nextRotation = currentBase + (props.spins * 360) + targetAngle;
  
  // If the new rotation is somehow less than the current + 360 (unlikely with spins=5), ensure we spin forward
  const finalRotation = (nextRotation < currentRotation.value + 360) 
    ? nextRotation + 360 
    : nextRotation;
    
  // Force a small delay to allow UI to catch up if it was instantly snapped
  setTimeout(() => {
    currentRotation.value = finalRotation;
  }, 50);
};

// Also expose a reset method if they want to reset it without spinning
const reset = () => {
  isSpinning.value = false;
  currentRotation.value = 0;
};

const onTransitionEnd = (event: TransitionEvent) => {
  if (event.propertyName === 'transform' && isSpinning.value) {
    isSpinning.value = false;
    emit('finish', processedItems.value[targetIndex]);
  }
};

defineExpose({
  spinTo,
  reset,
  isSpinning
});
</script>

<style scoped>
.pp-spin-wheel-wrapper {
  position: relative;
  display: inline-block;
  width: 300px;
  height: 300px;
}

.pp-spin-wheel-pointer {
  position: absolute;
  top: -15px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 10;
  display: flex;
  flex-direction: column;
  align-items: center;
  filter: drop-shadow(0 2px 4px rgba(0,0,0,0.3));
}

.pp-pointer-arrow {
  width: 0; 
  height: 0; 
  border-left: 15px solid transparent;
  border-right: 15px solid transparent;
  border-top: 25px solid; /* color set via inline style */
}

.pp-pointer-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  margin-top: -3px;
}

.pp-spin-wheel {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  position: relative;
  overflow: hidden;
  box-shadow: 0 4px 16px rgba(0,0,0,0.15);
  border: 4px solid #ffffff;
  box-sizing: border-box;
}

.pp-spin-wheel-slice-text {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  /* We don't hide overflow, it's just a rotating container for the text */
  pointer-events: none;
}

.pp-spin-wheel-label {
  position: absolute;
  top: 15px;
  left: 50%;
  transform: translateX(-50%);
  text-align: center;
  color: #ffffff;
  font-weight: 700;
  font-size: 14px;
  text-shadow: 0 1px 3px rgba(0,0,0,0.5);
  max-width: 100px; /* roughly half the radius */
  word-wrap: break-word;
}

.pp-spin-wheel-center {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 40px;
  height: 40px;
  background-color: #ffffff;
  border-radius: 50%;
  box-shadow: 0 2px 8px rgba(0,0,0,0.2);
  z-index: 5;
}

/* Donut Variant */
.is-variant-donut .pp-spin-wheel-center {
  width: 120px;
  height: 120px;
  box-shadow: inset 0 2px 8px rgba(0,0,0,0.1), 0 2px 8px rgba(0,0,0,0.2);
  display: flex;
  align-items: center;
  justify-content: center;
}
.pp-donut-hole {
  width: 90px;
  height: 90px;
  background-color: #f4f5f8;
  border-radius: 50%;
  box-shadow: inset 0 4px 10px rgba(0,0,0,0.05);
}

/* Casino Variant */
.is-variant-casino .pp-spin-wheel {
  border: 12px solid #222;
}
.pp-casino-rim {
  position: absolute;
  top: 0; left: 0; width: 100%; height: 100%;
  border-radius: 50%;
  pointer-events: none;
  z-index: 4;
}
.pp-casino-light {
  position: absolute;
  top: 50%; left: 50%;
  width: 8px; height: 8px;
  margin-top: -4px; margin-left: -4px;
  border-radius: 50%;
  background-color: #ffd700;
  box-shadow: 0 0 5px #ffaa00;
  animation: blink 1s infinite alternate;
}
.pp-casino-light:nth-child(even) {
  animation-delay: 0.5s;
}

@keyframes blink {
  0% { opacity: 0.4; box-shadow: 0 0 2px #ffaa00; }
  100% { opacity: 1; box-shadow: 0 0 10px #ffaa00, 0 0 20px #ffaa00; }
}
</style>
