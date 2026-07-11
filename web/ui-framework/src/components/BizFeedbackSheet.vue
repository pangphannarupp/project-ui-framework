<template>
  <BizBottomSheet :modelValue="modelValue" @update:modelValue="$emit('update:modelValue', $event)">
    <div class="feedback-sheet-content">
      
      <!-- Icon -->
      <div class="icon-wrapper" v-if="icon === 'error'">
        <div class="icon-bg-light error-light">
          <div class="icon-bg-dark error-dark">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="shield-icon">
              <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" fill="currentColor" stroke="none"></path>
              <line x1="12" y1="8" x2="12" y2="12" stroke="#fff" stroke-width="2.5" stroke-linecap="round"></line>
              <circle cx="12" cy="16" r="1.5" fill="#fff" stroke="none"></circle>
            </svg>
          </div>
        </div>
      </div>
      
      <div class="icon-wrapper" v-else-if="icon === 'locked'">
        <div class="icon-bg-light error-light">
          <div class="icon-bg-dark error-dark">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" class="shield-icon">
              <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z" fill="currentColor" stroke="none"></path>
              <rect x="9" y="11" width="6" height="6" rx="1" fill="#fff" stroke="none"></rect>
              <path d="M10 11V9a2 2 0 0 1 4 0v2" stroke="#fff" stroke-width="1.5" stroke-linecap="round"></path>
              <circle cx="12" cy="14" r="1" fill="#d93025" stroke="none"></circle>
            </svg>
          </div>
        </div>
      </div>
      
      <div class="icon-wrapper" v-else-if="icon === 'success'">
         <!-- Success variant placeholder if needed -->
      </div>

      <!-- Text -->
      <h2 class="feedback-title">{{ title }}</h2>
      <p class="feedback-desc" v-if="description" v-html="description"></p>

      <!-- Custom Slot for complex content like Master/Sub user info -->
      <div class="feedback-slot" v-if="$slots.default">
        <slot></slot>
      </div>

      <!-- Action Button -->
      <div class="feedback-action">
        <BizButton variant="primary" block @click="handleAction">{{ buttonText }}</BizButton>
      </div>
    </div>
  </BizBottomSheet>
</template>

<script setup lang="ts">
import BizBottomSheet from './BizBottomSheet.vue';
import BizButton from './BizButton.vue';

defineProps({
  modelValue: {
    type: Boolean,
    default: false
  },
  icon: {
    type: String,
    default: 'error' // 'error', 'success', etc
  },
  title: {
    type: String,
    default: 'Action Required'
  },
  description: {
    type: String,
    default: ''
  },
  buttonText: {
    type: String,
    default: 'Okay'
  }
});

const emit = defineEmits(['update:modelValue', 'action']);

const handleAction = () => {
  emit('action');
  emit('update:modelValue', false);
};
</script>

<style scoped>
.feedback-sheet-content {
  padding: 16px 24px 32px 24px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

/* Icon */
.icon-wrapper {
  margin-bottom: 20px;
  margin-top: 8px;
}
.icon-bg-light {
  width: 72px;
  height: 72px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}
.error-light {
  background-color: #ffeded;
}
.icon-bg-dark {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
}
.error-dark {
  background-color: #d93025;
  color: #d93025;
}
.shield-icon {
  width: 28px;
  height: 28px;
}

/* Typography */
.feedback-title {
  font-size: 18px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0 0 10px 0;
  text-align: center;
}
.feedback-desc {
  font-size: 13px;
  color: #555;
  text-align: center;
  line-height: 1.5;
  margin: 0 0 24px 0;
  padding: 0 16px;
}

.feedback-slot {
  width: 100%;
  margin-bottom: 24px;
}

.feedback-action {
  width: 100%;
}
</style>
