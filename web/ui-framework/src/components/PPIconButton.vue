<template>
  <button 
    class="pp-icon-btn" 
    :class="[`pp-icon-btn--${color}`]"
    @click="$emit('click')"
  >
    <div v-if="badge" class="pp-icon-btn__badge"></div>
    <slot>
      <!-- Use Ionic Icon if icon prop is provided -->
      <IonIcon v-if="icon" :icon="icon" class="pp-icon"></IonIcon>
      <!-- Fallback icon if none provided -->
      <svg v-else viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="pp-icon">
        <circle cx="12" cy="12" r="10"></circle>
      </svg>
    </slot>
  </button>
</template>

<script setup lang="ts">
import { IonIcon } from '@ionic/vue';

defineProps({
  icon: {
    type: [String, Object],
    default: undefined
  },
  color: {
    type: String,
    default: 'white', // 'white', 'danger', 'primary'
  },
  badge: {
    type: Boolean,
    default: false
  }
});

defineEmits(['click']);
</script>

<style scoped>
.pp-icon-btn {
  position: relative;
  width: 40px;
  height: 40px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  border: none;
  cursor: pointer;
  transition: all 0.2s ease;
  padding: 0;
}

.pp-icon-btn:active {
  transform: scale(0.95);
}

.pp-icon-btn__badge {
  position: absolute;
  top: 8px;
  right: 10px;
  width: 6px;
  height: 6px;
  background-color: #ff3b30;
  border-radius: 50%;
  box-shadow: 0 0 0 2px white;
}

/* Color Variants */
.pp-icon-btn--white {
  background-color: #ffffff;
  color: var(--pp-primary-variant, #1a2a5e);
}

.pp-icon-btn--transparent {
  background-color: transparent;
  color: #ffffff;
}
.pp-icon-btn--transparent:active {
  background-color: rgba(255, 255, 255, 0.2);
}

.pp-icon-btn--danger {
  background-color: #ffefef;
  color: #ff3b30;
}
.pp-icon-btn--danger .pp-icon-btn__badge {
  box-shadow: 0 0 0 2px #ffefef;
}

.pp-icon-btn--primary {
  background-color: #f4f5f8;
  color: var(--pp-primary-variant, #1a2a5e);
}

/* Base icon sizing */
:slotted(svg), .pp-icon, :deep(ion-icon) {
  width: 20px;
  height: 20px;
}
</style>
