<template>
  <button 
    class="biz-icon-btn" 
    :class="[`biz-icon-btn--${color}`]"
    @click="$emit('click')"
  >
    <div v-if="badge" class="biz-icon-btn__badge"></div>
    <slot>
      <!-- Fallback icon if none provided -->
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="biz-icon">
        <circle cx="12" cy="12" r="10"></circle>
      </svg>
    </slot>
  </button>
</template>

<script setup lang="ts">
defineProps({
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
.biz-icon-btn {
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

.biz-icon-btn:active {
  transform: scale(0.95);
}

.biz-icon-btn__badge {
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
.biz-icon-btn--white {
  background-color: #ffffff;
  color: var(--biz-primary-variant, #1a2a5e);
}

.biz-icon-btn--danger {
  background-color: #ffefef;
  color: #ff3b30;
}
.biz-icon-btn--danger .biz-icon-btn__badge {
  box-shadow: 0 0 0 2px #ffefef;
}

.biz-icon-btn--primary {
  background-color: #f4f5f8;
  color: var(--biz-primary-variant, #1a2a5e);
}

/* Base icon sizing */
:slotted(svg), .biz-icon {
  width: 20px;
  height: 20px;
}
</style>
