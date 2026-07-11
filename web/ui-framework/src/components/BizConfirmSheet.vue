<template>
  <BizBottomSheet :modelValue="modelValue" @update:modelValue="$emit('update:modelValue', $event)">
    <div class="biz-confirm-sheet-content">
      <div class="confirm-icon">
        <slot name="icon">
          <!-- Default warning icon matching the screenshot -->
          <div class="warning-circle">
            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z" fill="#f5a623" stroke="#f5a623"></path>
              <line x1="12" y1="9" x2="12" y2="13" stroke="white"></line>
              <line x1="12" y1="17" x2="12.01" y2="17" stroke="white"></line>
            </svg>
          </div>
        </slot>
      </div>
      
      <h3 class="confirm-title">{{ title }}</h3>
      <p class="confirm-subtitle" v-if="subtitle">{{ subtitle }}</p>
      
      <div class="confirm-actions">
        <slot name="actions">
          <BizButton 
            v-if="confirmText" 
            variant="outline-danger" 
            block 
            @click="$emit('confirm')"
          >
            {{ confirmText }}
          </BizButton>
          <BizButton 
            v-if="cancelText" 
            variant="outline" 
            block 
            @click="$emit('update:modelValue', false)"
          >
            {{ cancelText }}
          </BizButton>
        </slot>
      </div>
    </div>
  </BizBottomSheet>
</template>

<script setup lang="ts">
import BizBottomSheet from './BizBottomSheet.vue';
import BizButton from './BizButton.vue';

defineProps({
  modelValue: Boolean,
  title: String,
  subtitle: String,
  confirmText: {
    type: String,
    default: 'Confirm'
  },
  cancelText: {
    type: String,
    default: 'Cancel'
  }
});

defineEmits(['update:modelValue', 'confirm']);
</script>

<style scoped>
.biz-confirm-sheet-content {
  padding: 16px 20px 40px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
}

.confirm-icon {
  margin-bottom: 24px;
}

.warning-circle {
  width: 90px;
  height: 90px;
  border-radius: 50%;
  background-color: #fff8e6;
  color: #f5a623;
  display: flex;
  align-items: center;
  justify-content: center;
}

.warning-circle svg {
  width: 48px;
  height: 48px;
}

.confirm-title {
  font-size: 22px;
  font-weight: 700;
  color: var(--biz-primary-variant, #1a2a5e);
  margin: 0 0 8px 0;
}

.confirm-subtitle {
  font-size: 15px;
  color: #666;
  margin: 0 0 32px 0;
}

.confirm-actions {
  width: 100%;
  display: flex;
  flex-direction: column;
  gap: 16px;
}
</style>
