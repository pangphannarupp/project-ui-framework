<template>
  <div class="dropdown-wrapper" ref="wrapperRef">
    <div @click="toggleDropdown" style="cursor: pointer;" class="profile-trigger">
      <PPUserProfile userName="Alex Johnson" role="Administrator" avatarUrl="https://i.pravatar.cc/150?img=32" isVerified />
    </div>
    <transition name="dropdown-fade">
      <div v-if="isOpen" class="custom-dropdown profile-dropdown">
        <div class="profile-header">
          <img src="https://i.pravatar.cc/150?img=32" alt="Avatar" class="profile-large-avatar" />
          <div class="profile-info">
            <div class="profile-name">Alex Johnson</div>
            <div class="profile-email">alex.j@example.com</div>
          </div>
        </div>
        <div class="dropdown-divider"></div>
        <div class="dropdown-item">
          <ion-icon :icon="personOutline" class="dropdown-icon" /> My Profile
        </div>
        <div class="dropdown-item">
          <ion-icon :icon="settingsOutline" class="dropdown-icon" /> Account Settings
        </div>
        <div class="dropdown-divider"></div>
        <div class="dropdown-item text-danger" @click="handleLogout">
          <ion-icon :icon="logOutOutline" class="dropdown-icon" /> Logout
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { IonIcon } from '@ionic/vue';
import { PPUserProfile } from '@phanna/ui-framework';
import { personOutline, settingsOutline, logOutOutline } from 'ionicons/icons';

const isOpen = ref(false);
const wrapperRef = ref<HTMLElement | null>(null);

const toggleDropdown = () => {
  isOpen.value = !isOpen.value;
};

const handleLogout = () => {
  console.log('Logging out...');
  isOpen.value = false;
};

const closeOnOutsideClick = (e: MouseEvent) => {
  if (wrapperRef.value && !wrapperRef.value.contains(e.target as Node)) {
    isOpen.value = false;
  }
};

onMounted(() => {
  document.addEventListener('click', closeOnOutsideClick);
});

onUnmounted(() => {
  document.removeEventListener('click', closeOnOutsideClick);
});
</script>

<style scoped>
.dropdown-wrapper {
  position: relative;
}

:deep(.profile-trigger .username) {
  color: #1e293b !important;
}

:deep(.profile-trigger .role-text) {
  color: #64748b !important;
}

:deep(.profile-trigger .verified-icon) {
  color: #3b82f6 !important;
}

:deep(.profile-trigger .avatar-container) {
  border-color: #e2e8f0 !important;
}

.custom-dropdown {
  position: absolute;
  top: calc(100% + 12px);
  right: 0;
  background: white;
  border: 1px solid #e2e8f0;
  border-radius: 16px;
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
  z-index: 1000;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.profile-dropdown {
  width: 260px;
}

.profile-header {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 20px;
}

.profile-large-avatar {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  object-fit: cover;
  border: 2px solid #a855f7;
}

.profile-info {
  display: flex;
  flex-direction: column;
}

.profile-name {
  font-size: 16px;
  font-weight: 600;
  color: #1e293b;
  margin-bottom: 4px;
}

.profile-email {
  font-size: 13px;
  color: #64748b;
}

.dropdown-divider {
  height: 1px;
  background: #e2e8f0;
  margin: 4px 0;
}

.dropdown-item {
  padding: 12px 20px;
  color: #1e293b;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 14px;
  font-weight: 500;
  transition: background 0.2s;
}

.dropdown-item:hover {
  background: #f8fafc;
}

.dropdown-icon {
  font-size: 18px;
  opacity: 0.8;
}

.text-danger { color: #ef4444; }

.dropdown-fade-enter-active,
.dropdown-fade-leave-active {
  transition: opacity 0.2s, transform 0.2s;
}

.dropdown-fade-enter-from,
.dropdown-fade-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}
</style>
