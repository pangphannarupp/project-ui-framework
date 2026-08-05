<template>
  <div class="dropdown-wrapper" ref="wrapperRef">
    <PPIconButton badge @click="toggleDropdown" class="header-icon-btn">
      <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path>
        <path d="M13.73 21a2 2 0 0 1-3.46 0"></path>
      </svg>
    </PPIconButton>

    <transition name="dropdown-fade">
      <div v-if="isOpen" class="custom-dropdown notifications-dropdown">
        <div class="notifications-header">
          <h3>Notifications</h3>
          <button class="mark-all-read">Mark all as read</button>
        </div>
        <div class="notifications-list">
          <PPNotificationItem
            v-for="item in notificationItems"
            :key="item.id"
            :title="item.title"
            :description="item.description"
            :timestamp="item.timestamp"
            :unread="item.unread"
            class="portal-notification-item"
            @click="handleSelect(item)"
            @detail-click="handleSelect(item)"
          >
            <template #icon>
              <ion-icon :icon="item.icon" :class="{'text-danger': item.danger, 'text-success': item.success, 'text-primary': item.primary}" />
            </template>
          </PPNotificationItem>
        </div>
        <div class="notifications-footer">
          <button class="view-all">View all notifications</button>
        </div>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { IonIcon } from '@ionic/vue';
import { PPIconButton, PPNotificationItem } from '@phanna/ui-framework';
import { warningOutline, checkmarkCircleOutline, rocketOutline } from 'ionicons/icons';

const isOpen = ref(false);
const wrapperRef = ref<HTMLElement | null>(null);

const notificationItems = ref([
  { 
    id: 1, 
    title: 'New project Alpha created', 
    description: 'Sarah M. has just created a new project in your workspace.',
    timestamp: '2 mins ago',
    icon: rocketOutline, 
    primary: true,
    unread: true 
  },
  { 
    id: 2, 
    title: 'System update completed', 
    description: 'The latest patches have been successfully applied.',
    timestamp: '1 hour ago',
    icon: checkmarkCircleOutline, 
    success: true,
    unread: false 
  },
  { 
    id: 3, 
    title: 'Server load warning', 
    description: 'High CPU usage detected on Node-3.',
    timestamp: '3 hours ago',
    icon: warningOutline, 
    danger: true,
    unread: true 
  },
]);

const toggleDropdown = () => {
  isOpen.value = !isOpen.value;
};

const handleSelect = (item: any) => {
  console.log('Notification selected:', item);
  item.unread = false;
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

.header-icon-btn {
  color: #64748b;
  background: white;
  border: 1px solid #e2e8f0;
}
.header-icon-btn:hover {
  background: #f8fafc;
  color: #1e293b;
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

.notifications-dropdown {
  width: 360px;
}

.notifications-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px 20px;
  border-bottom: 1px solid #e2e8f0;
}

.notifications-header h3 {
  margin: 0;
  font-size: 16px;
  font-weight: 600;
  color: #1e293b;
}

.mark-all-read {
  background: none;
  border: none;
  color: #a855f7;
  font-size: 13px;
  font-weight: 500;
  cursor: pointer;
  padding: 0;
}

.mark-all-read:hover {
  text-decoration: underline;
}

.notifications-list {
  max-height: 400px;
  overflow-y: auto;
}

.notifications-list::-webkit-scrollbar {
  width: 6px;
}
.notifications-list::-webkit-scrollbar-thumb {
  background: rgba(0, 0, 0, 0.1);
  border-radius: 3px;
}

:deep(.portal-notification-item) {
  --pp-notification-bg: transparent;
  --pp-notification-border-color: #f1f5f9;
  --pp-notification-active-bg: #f8fafc;
  --pp-notification-title-color: #1e293b;
  --pp-notification-desc-color: #64748b;
  --pp-notification-icon-bg: #f1f5f9;
  --pp-notification-icon-color: #475569;
  --pp-notification-unread-color: #ef4444;
}

:deep(.portal-notification-item:hover) {
  background-color: #f8fafc;
}

.notifications-footer {
  padding: 12px;
  text-align: center;
  border-top: 1px solid #e2e8f0;
  background: #f8fafc;
}

.view-all {
  background: none;
  border: none;
  color: #64748b;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  padding: 8px;
  width: 100%;
}

.view-all:hover {
  color: #3b82f6;
}

.dropdown-fade-enter-active,
.dropdown-fade-leave-active {
  transition: opacity 0.2s, transform 0.2s;
}

.dropdown-fade-enter-from,
.dropdown-fade-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}

.text-danger { color: #ef4444; }
.text-success { color: #10b981; }
.text-primary { color: #3b82f6; }
</style>
