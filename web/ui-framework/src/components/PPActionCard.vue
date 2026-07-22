<template>
  <div class="pp-action-card" @click="$emit('click')">
    <div class="card-icon-container">
      <div v-if="badgeCount !== undefined" class="card-badge" :class="[`badge-${badgeColor}`]">
        {{ badgeCount }}
      </div>
      <div v-else class="card-icon" :class="[`icon-${badgeColor}`]">
        <slot name="icon">
          <!-- Fallback -->
          <svg viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2z"/>
          </svg>
        </slot>
      </div>
    </div>
    
    <div class="card-text">
      <div class="card-title">{{ title }}</div>
      <div class="card-subtitle" v-if="subtitle">{{ subtitle }}</div>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  title: {
    type: String,
    required: true
  },
  subtitle: {
    type: String,
    default: ''
  },
  badgeCount: {
    type: [Number, String],
    default: undefined
  },
  badgeColor: {
    type: String,
    default: 'pink' // 'pink', 'orange', 'teal', 'blue'
  }
});

defineEmits(['click']);
</script>

<style scoped>
.pp-action-card {
  background: white;
  border-radius: 16px;
  padding: 16px 12px;
  display: flex;
  flex-direction: column;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
  cursor: pointer;
  transition: transform 0.2s, box-shadow 0.2s;
  height: 100%;
}

.pp-action-card:active {
  transform: scale(0.97);
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.02);
}

.card-icon-container {
  margin-bottom: 12px;
}

.card-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  font-size: 16px;
  font-weight: 700;
}

.card-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 40px;
  height: 40px;
  border-radius: 50%;
}

.card-icon :slotted(svg) {
  width: 24px;
  height: 24px;
}

/* Colors */
.badge-pink, .icon-pink {
  background-color: #ffe6eb;
  color: #ff4d6d;
}

.badge-orange, .icon-orange {
  background-color: #fff3e0;
  color: #ff9800;
}

.badge-teal, .icon-teal {
  background-color: #e0f2f1;
  color: #009688;
}

.badge-blue, .icon-blue {
  background-color: #e6f0ff;
  color: #0066cc;
}

/* Specific styling for icon variations to match design */
.icon-blue {
  background-color: transparent;
  color: #0066cc;
}
.icon-pink {
  background-color: transparent;
  color: #ff4d6d;
}

.card-text {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.card-title {
  font-size: 14px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  line-height: 1.2;
}

.card-subtitle {
  font-size: 12px;
  color: #666;
  line-height: 1.2;
}
</style>
