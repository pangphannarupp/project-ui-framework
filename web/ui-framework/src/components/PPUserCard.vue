<template>
  <div class="pp-user-card">
    <div class="user-avatar">
      {{ initials }}
    </div>
    
    <div class="user-info">
      <div class="user-name-row">
        <h3>{{ name }}</h3>
        <span class="verified-icon" v-if="isMaster">
          <svg viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
            <path d="M9 12l2 2 4-4" stroke="#fff" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" fill="none"></path>
          </svg>
        </span>
      </div>
      
      <div class="user-phone">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path>
        </svg>
        {{ phone }}
      </div>
      
      <div class="user-badges">


      </div>
    </div>
    
    <div class="user-actions">
      <div :class="['status-chip', status.toLowerCase()]">{{ status }}</div>
      <button class="more-btn">
        <svg viewBox="0 0 24 24" fill="currentColor">
          <circle cx="12" cy="5" r="2"></circle>
          <circle cx="12" cy="12" r="2"></circle>
          <circle cx="12" cy="19" r="2"></circle>
        </svg>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps({
  name: { type: String, required: true },
  phone: { type: String, required: true },
  status: { type: String, default: 'Active' },
  isMaster: { type: Boolean, default: false }
});

const initials = computed(() => {
  const parts = props.name.split(' ');
  if (parts.length >= 2) {
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
  return props.name.substring(0, 2).toUpperCase();
});
</script>

<style scoped>
.pp-user-card {
  display: flex;
  align-items: flex-start;
  padding: 16px;
  background: white;
  border-radius: 16px;
  border: 1px solid #eef1f6;
  margin-bottom: 12px;
}

.user-avatar {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background-color: #e6f0ff;
  color: var(--pp-primary-variant, #1a2a5e);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 15px;
  flex-shrink: 0;
  margin-right: 12px;
}

.user-info {
  flex: 1;
  min-width: 0;
}

.user-name-row {
  display: flex;
  align-items: center;
  gap: 6px;
  margin-bottom: 4px;
}

.user-name-row h3 {
  margin: 0;
  font-size: 15px;
  font-weight: 700;
  color: #111;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.verified-icon {
  color: #3b63cc;
  display: flex;
  align-items: center;
}

.verified-icon svg {
  width: 14px;
  height: 14px;
}

.user-phone {
  display: flex;
  align-items: center;
  gap: 6px;
  color: #666;
  font-size: 13px;
  margin-bottom: 8px;
}

.user-phone svg {
  width: 12px;
  height: 12px;
}

.user-badges {
  display: flex;
  gap: 8px;
  flex-wrap: wrap;
}

.pp-badge {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  padding: 4px 8px;
  border-radius: 6px;
  background-color: #3b63cc;
  color: white;
  font-size: 11px;
  font-weight: 600;
}

.pp-badge.light-blue {
  background-color: #00a4e4;
}

.pp-badge svg {
  width: 12px;
  height: 12px;
}

.user-actions {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  justify-content: space-between;
  height: 100%;
}

.status-chip {
  padding: 4px 10px;
  border-radius: 12px;
  font-size: 12px;
  font-weight: 600;
  margin-bottom: 24px;
}

.status-chip.active {
  background-color: #f0f5ff;
  color: #3b63cc;
}

.status-chip.inactive {
  background-color: #f5f5f5;
  color: #888;
}

.status-chip.pending {
  background-color: #fff8e5;
  color: #e59f00;
}

.status-chip.locked {
  background-color: #ffebeb;
  color: #ff3b30;
}

.more-btn {
  background: transparent;
  border: none;
  color: #888;
  padding: 4px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
}

.more-btn svg {
  width: 20px;
  height: 20px;
}
</style>
