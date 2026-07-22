<template>
  <div class="pp-user-profile">
    <div class="avatar-container">
      <img v-if="avatarUrl" :src="avatarUrl" alt="Avatar" class="avatar-img" />
      <div v-else class="avatar-placeholder">
        {{ initials }}
      </div>
    </div>
    
    <div class="user-info">
      <div class="role-wrapper">
        <svg v-if="isVerified" class="verified-icon" viewBox="0 0 24 24" fill="currentColor">
          <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
        </svg>
        <span class="role-text">{{ role }}</span>
      </div>
      <div class="username">{{ userName }}</div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps({
  userName: {
    type: String,
    required: true
  },
  role: {
    type: String,
    default: 'User'
  },
  avatarUrl: {
    type: String,
    default: ''
  },
  isVerified: {
    type: Boolean,
    default: false
  }
});

const initials = computed(() => {
  return props.userName
    .split(' ')
    .map(n => n[0])
    .join('')
    .substring(0, 2)
    .toUpperCase();
});
</script>

<style scoped>
.pp-user-profile {
  display: flex;
  align-items: center;
  gap: 12px;
}

.avatar-container {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  overflow: hidden;
  flex-shrink: 0;
  background-color: #e0e0e0;
  border: 2px solid rgba(255, 255, 255, 0.2);
}

.avatar-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.avatar-placeholder {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: #666;
  font-weight: bold;
  font-size: 14px;
}

.user-info {
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.role-wrapper {
  display: flex;
  align-items: center;
  gap: 4px;
  margin-bottom: 2px;
}

.verified-icon {
  width: 14px;
  height: 14px;
  color: white;
}

.role-text {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.8);
  font-weight: 500;
}

.username {
  font-size: 15px;
  font-weight: 700;
  color: white;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}
</style>
