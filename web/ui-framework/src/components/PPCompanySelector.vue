<template>
  <div class="pp-company-selector" @click="$emit('click')">
    <div class="company-logo">
      <slot name="logo">
        <img v-if="logoUrl" :src="logoUrl" alt="Logo" class="logo-img" />
        <div v-else class="logo-placeholder">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
            <polyline points="9 22 9 12 15 12 15 22"></polyline>
          </svg>
        </div>
      </slot>
    </div>
    
    <div class="company-info">
      <div class="company-name">{{ companyName }}</div>
      <div class="company-type" v-if="companyType">
        <svg class="type-icon" viewBox="0 0 24 24" fill="currentColor">
          <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
        </svg>
        {{ companyType }}
      </div>
    </div>
    
    <div class="selector-icon">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <polyline points="8 9 12 5 16 9"></polyline>
        <polyline points="16 15 12 19 8 15"></polyline>
      </svg>
    </div>
  </div>
</template>

<script setup lang="ts">
defineProps({
  companyName: {
    type: String,
    required: true
  },
  companyType: {
    type: String,
    default: ''
  },
  logoUrl: {
    type: String,
    default: ''
  }
});

defineEmits(['click']);
</script>

<style scoped>
.pp-company-selector {
  display: flex;
  align-items: center;
  gap: 12px;
  background: white;
  padding: 12px 16px;
  border-radius: 16px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
  cursor: pointer;
  transition: background-color 0.2s;
}

.pp-company-selector:active {
  background: #f8f9fa;
}

.company-logo {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #e6f0ff;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  overflow: hidden;
  border: 1px solid #d9e6f2;
}

.logo-img {
  width: 100%;
  height: 100%;
  object-fit: contain;
}

.logo-placeholder {
  color: #0066cc;
}
.logo-placeholder svg {
  width: 20px;
  height: 20px;
}

.company-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  overflow: hidden;
}

.company-name {
  font-size: 14px;
  font-weight: 700;
  color: var(--pp-primary-variant, #1a2a5e);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  margin-bottom: 2px;
}

.company-type {
  display: flex;
  align-items: center;
  gap: 4px;
  font-size: 12px;
  color: #888;
}

.type-icon {
  width: 12px;
  height: 12px;
}

.selector-icon {
  color: #a0a0a0;
  display: flex;
  align-items: center;
  justify-content: center;
}
.selector-icon svg {
  width: 16px;
  height: 16px;
}
</style>
