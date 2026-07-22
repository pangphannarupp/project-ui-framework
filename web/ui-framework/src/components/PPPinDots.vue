<template>
  <div class="pp-pin-dots" :class="{ 'is-error': error, 'is-success': success }">
    <div class="dots-container">
      <div 
        v-for="index in length" 
        :key="index" 
        class="pin-dot"
        :class="{ 'is-filled': isFilled(index) }"
      ></div>
    </div>
    
    <div v-if="error && errorText" class="error-message">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="error-icon">
        <circle cx="12" cy="12" r="10"></circle>
        <line x1="12" y1="8" x2="12" y2="12"></line>
        <line x1="12" y1="16" x2="12.01" y2="16"></line>
      </svg>
      {{ errorText }}
    </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps({
  length: {
    type: Number,
    default: 6
  },
  value: {
    type: String,
    default: ''
  },
  error: {
    type: Boolean,
    default: false
  },
  errorText: {
    type: String,
    default: 'PIN does not match. Please try again.'
  },
  success: {
    type: Boolean,
    default: false
  }
});

const isFilled = (index: number) => {
  return props.value.length >= index;
};
</script>

<style scoped>
.pp-pin-dots {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 16px;
  width: 100%;
}

.dots-container {
  display: flex;
  justify-content: center;
  gap: 16px;
}

.pin-dot {
  width: 16px;
  height: 16px;
  border-radius: 50%;
  border: 1.5px solid var(--pp-primary-color, var(--pp-primary, #003399));
  background-color: transparent;
  transition: all 0.2s ease;
}

.pin-dot.is-filled {
  background-color: var(--pp-primary-color, var(--pp-primary, #003399));
  border-color: var(--pp-primary-color, var(--pp-primary, #003399));
}

/* Error State */
.pp-pin-dots.is-error .pin-dot {
  border-color: var(--pp-danger-color, #ff4d4f);
}
.pp-pin-dots.is-error .pin-dot.is-filled {
  background-color: var(--pp-danger-color, #ff4d4f);
}

@keyframes shake {
  0%, 100% { transform: translateX(0); }
  25% { transform: translateX(-8px); }
  75% { transform: translateX(8px); }
}
.pp-pin-dots.is-error .dots-container {
  animation: shake 0.4s ease-in-out;
}

/* Success State */
@keyframes success-pulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.25); background-color: #52c41a; border-color: #52c41a; }
  100% { transform: scale(1); background-color: #52c41a; border-color: #52c41a; }
}

.pp-pin-dots.is-success .pin-dot {
  animation: success-pulse 0.4s forwards;
}
.pp-pin-dots.is-success .pin-dot:nth-child(1) { animation-delay: 0s; }
.pp-pin-dots.is-success .pin-dot:nth-child(2) { animation-delay: 0.05s; }
.pp-pin-dots.is-success .pin-dot:nth-child(3) { animation-delay: 0.1s; }
.pp-pin-dots.is-success .pin-dot:nth-child(4) { animation-delay: 0.15s; }
.pp-pin-dots.is-success .pin-dot:nth-child(5) { animation-delay: 0.2s; }
.pp-pin-dots.is-success .pin-dot:nth-child(6) { animation-delay: 0.25s; }

.error-message {
  display: flex;
  align-items: center;
  gap: 6px;
  color: var(--pp-danger-color, #ff4d4f);
  font-size: 13px;
  font-weight: 500;
}
.error-icon {
  width: 14px;
  height: 14px;
}
</style>
