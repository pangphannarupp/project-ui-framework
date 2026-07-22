<template>
  <Teleport to="body">
    <transition :name="`island-fade-${position}`">
      <div 
        v-if="modelValue" 
        class="pp-dynamic-island-wrapper"
        :class="[`is-position-${position}`, wrapperClass]"
        :style="wrapperStyle"
      >
        <div 
          ref="islandRef"
          class="pp-dynamic-island" 
          :class="[`is-${state}`, `is-${position}`, { 'is-full-width': fullWidth }]"
          :style="islandDynamicStyle"
          @click="handleClick"
        >
          <!-- Dynamic Content based on State -->
          <transition name="island-content" mode="out-in">
            <!-- Minimal State -->
            <div v-if="state === 'minimal'" class="island-minimal" key="minimal">
              <slot name="minimal">
                <div class="minimal-dot"></div>
              </slot>
            </div>

            <!-- Compact State -->
            <div v-else-if="state === 'compact'" class="island-compact" key="compact">
              <div class="compact-left">
                <slot name="compact-left"></slot>
              </div>
              <div class="compact-center">
                <slot name="compact-center"></slot>
              </div>
              <div class="compact-right">
                <slot name="compact-right"></slot>
              </div>
            </div>

            <!-- Expanded State -->
            <div v-else-if="state === 'expanded'" class="island-expanded" key="expanded">
              <slot name="expanded">
                <div class="expanded-header">
                  <slot name="expanded-header"></slot>
                </div>
                <div class="expanded-body">
                  <slot name="expanded-body"></slot>
                </div>
                <div class="expanded-footer">
                  <slot name="expanded-footer"></slot>
                </div>
              </slot>
            </div>
          </transition>
        </div>
      </div>
    </transition>
  </Teleport>
</template>

<script setup lang="ts">
import { watch, computed, onMounted, onUnmounted, ref } from 'vue';

const props = defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  state: {
    type: String,
    default: 'compact', // 'minimal', 'compact', 'expanded'
    validator: (value: string) => ['minimal', 'compact', 'expanded'].includes(value)
  },
  position: {
    type: String,
    default: 'top', // 'top', 'bottom', 'left', 'right'
    validator: (value: string) => ['top', 'bottom', 'left', 'right'].includes(value)
  },
  offset: {
    type: Number,
    default: 16
  },
  fullWidth: {
    type: Boolean,
    default: false
  },
  wrapperClass: {
    type: String,
    default: ''
  },
  autoHideTimeout: {
    type: Number,
    default: 0 // 0 means no auto-hide
  },
  dismissOnOutsideClick: {
    type: Boolean,
    default: true
  },
  bgColor: {
    type: String,
    default: ''
  },
  textColor: {
    type: String,
    default: ''
  }
});

const emit = defineEmits(['update:modelValue', 'click']);

const islandRef = ref<HTMLElement | null>(null);

const wrapperStyle = computed(() => {
  if (props.position === 'top') return { top: `${props.offset}px` };
  if (props.position === 'bottom') return { bottom: `${props.offset}px` };
  if (props.position === 'left') return { left: `${props.offset}px` };
  if (props.position === 'right') return { right: `${props.offset}px` };
  return {};
});

const islandDynamicStyle = computed(() => {
  const styles: Record<string, string> = {};
  if (props.bgColor) {
    styles['--pp-island-bg'] = props.bgColor;
  }
  if (props.textColor) {
    styles['--pp-island-color'] = props.textColor;
  }
  return styles;
});

let timeoutId: number | undefined;

const startTimeout = () => {
  if (timeoutId) clearTimeout(timeoutId);
  if (props.autoHideTimeout > 0 && props.modelValue) {
    timeoutId = window.setTimeout(() => {
      emit('update:modelValue', false);
    }, props.autoHideTimeout);
  }
};

watch(() => props.modelValue, (newVal) => {
  if (newVal) {
    startTimeout();
  } else if (timeoutId) {
    clearTimeout(timeoutId);
  }
});

watch(() => props.state, () => {
  if (props.modelValue) {
    startTimeout();
  }
});

const handleClick = (e: Event) => {
  emit('click', e);
};

const handleOutsideClick = (e: MouseEvent) => {
  if (props.dismissOnOutsideClick && props.modelValue && islandRef.value) {
    // If click is outside the island, close it
    if (!islandRef.value.contains(e.target as Node)) {
      emit('update:modelValue', false);
    }
  }
};

onMounted(() => {
  window.addEventListener('click', handleOutsideClick, true);
});

onUnmounted(() => {
  window.removeEventListener('click', handleOutsideClick, true);
});
</script>

<style scoped>
.pp-dynamic-island-wrapper {
  position: fixed;
  z-index: 10000;
  display: flex;
  pointer-events: none;
  width: 100%;
}

/* Position specific wrapper styling */
.pp-dynamic-island-wrapper.is-position-top,
.pp-dynamic-island-wrapper.is-position-bottom {
  left: 50%;
  transform: translateX(-50%);
  justify-content: center;
}

.pp-dynamic-island-wrapper.is-position-left,
.pp-dynamic-island-wrapper.is-position-right {
  top: 50%;
  transform: translateY(-50%);
  align-items: center;
}

.pp-dynamic-island {
  background-color: var(--pp-island-bg, #000000);
  color: var(--pp-island-color, #ffffff);
  border-radius: 40px; /* Fully rounded by default */
  pointer-events: auto; /* Enable clicks on the island itself */
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
  overflow: hidden;
  
  /* The magic bouncy transition for dimensions */
  transition: width 0.5s cubic-bezier(0.4, 0, 0.2, 1),
              height 0.5s cubic-bezier(0.4, 0, 0.2, 1),
              border-radius 0.5s cubic-bezier(0.4, 0, 0.2, 1),
              padding 0.5s cubic-bezier(0.4, 0, 0.2, 1);
              
  display: flex;
  align-items: center;
  justify-content: center;
}

/* State Dimensions */
.pp-dynamic-island.is-minimal {
  width: 48px;
  height: 48px;
  border-radius: 24px;
}

.pp-dynamic-island.is-compact {
  width: 220px;
  height: 40px;
  border-radius: 20px;
  padding: 0 16px;
}

.pp-dynamic-island.is-expanded {
  width: var(--pp-island-expanded-width, 340px);
  height: var(--pp-island-expanded-height, 180px);
  border-radius: var(--pp-island-expanded-radius, 36px);
  padding: 20px;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
}

.pp-dynamic-island.is-full-width:not(.is-minimal) {
  width: calc(100% - 32px) !important;
  max-width: 600px;
}

/* Internal Layouts */
.island-minimal {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100%;
  height: 100%;
}

.minimal-dot {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  background-color: var(--pp-island-accent, #2dd36f);
}

.island-compact {
  display: flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  height: 100%;
}

.compact-left, .compact-right {
  display: flex;
  align-items: center;
  gap: 8px;
}

.compact-center {
  flex: 1;
  display: flex;
  justify-content: center;
  font-size: 14px;
  font-weight: 500;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  padding: 0 8px;
}

.island-expanded {
  display: flex;
  flex-direction: column;
  width: 100%;
  height: 100%;
}

.expanded-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  margin-bottom: 12px;
}

.expanded-body {
  flex: 1;
  width: 100%;
  display: flex;
  flex-direction: column;
}

.expanded-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  width: 100%;
  margin-top: auto;
}

/* Content Fade Transition */
.island-content-enter-active,
.island-content-leave-active {
  transition: opacity 0.2s ease, transform 0.2s ease;
}

.island-content-enter-from,
.island-content-leave-to {
  opacity: 0;
  transform: scale(0.95);
}

/* Wrapper Fade Slide Transition - TOP */
.island-fade-top-enter-active,
.island-fade-top-leave-active {
  transition: opacity 0.4s cubic-bezier(0.4, 0, 0.2, 1), transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}
.island-fade-top-enter-from,
.island-fade-top-leave-to {
  opacity: 0;
  transform: translate(-50%, -20px);
}
.island-fade-top-enter-to,
.island-fade-top-leave-from {
  opacity: 1;
  transform: translate(-50%, 0);
}

/* Wrapper Fade Slide Transition - BOTTOM */
.island-fade-bottom-enter-active,
.island-fade-bottom-leave-active {
  transition: opacity 0.4s cubic-bezier(0.4, 0, 0.2, 1), transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}
.island-fade-bottom-enter-from,
.island-fade-bottom-leave-to {
  opacity: 0;
  transform: translate(-50%, 20px);
}
.island-fade-bottom-enter-to,
.island-fade-bottom-leave-from {
  opacity: 1;
  transform: translate(-50%, 0);
}

/* Wrapper Fade Slide Transition - LEFT */
.island-fade-left-enter-active,
.island-fade-left-leave-active {
  transition: opacity 0.4s cubic-bezier(0.4, 0, 0.2, 1), transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}
.island-fade-left-enter-from,
.island-fade-left-leave-to {
  opacity: 0;
  transform: translate(-20px, -50%);
}
.island-fade-left-enter-to,
.island-fade-left-leave-from {
  opacity: 1;
  transform: translate(0, -50%);
}

/* Wrapper Fade Slide Transition - RIGHT */
.island-fade-right-enter-active,
.island-fade-right-leave-active {
  transition: opacity 0.4s cubic-bezier(0.4, 0, 0.2, 1), transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}
.island-fade-right-enter-from,
.island-fade-right-leave-to {
  opacity: 0;
  transform: translate(20px, -50%);
}
.island-fade-right-enter-to,
.island-fade-right-leave-from {
  opacity: 1;
  transform: translate(0, -50%);
}
</style>
