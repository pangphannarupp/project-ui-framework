<template>
  <div class="pp-chat-item">
    <div class="pp-chat-avatar-wrapper">
      <PPAvatar :src="avatar" :name="name" size="lg" />
    </div>
    <div class="pp-chat-info">
      <div class="pp-chat-name-row">
        <span class="pp-chat-name">{{ name }}</span>
        <span class="pp-chat-time">{{ time }}</span>
      </div>
      <div class="pp-chat-msg-row">
        <span class="pp-chat-message" :class="{'unread-msg': unread && unread > 0}">
          {{ message }}
        </span>
        <div class="pp-chat-badge-wrapper" v-if="unread && unread > 0">
          <PPBadge :value="unread" color="primary" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import PPAvatar from './PPAvatar.vue';
import PPBadge from './PPBadge.vue';

defineProps<{
  name: string;
  avatar?: string;
  time?: string;
  message?: string;
  unread?: number;
}>();
</script>

<style scoped>
.pp-chat-item {
  display: flex;
  align-items: center;
  padding: 12px 16px;
  cursor: pointer;
}

.pp-chat-item:active {
  background-color: rgba(0, 0, 0, 0.05);
}

:global(.phone-mockup.dark-mode) .pp-chat-item:active {
  background-color: rgba(255, 255, 255, 0.05);
}

.pp-chat-avatar-wrapper {
  margin-right: 16px;
}

.pp-chat-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  overflow: hidden;
}

.pp-chat-name-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 4px;
}

.pp-chat-name {
  font-size: 16px;
  font-weight: 600;
  color: var(--text-main, inherit);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.pp-chat-time {
  font-size: 12px;
  color: var(--text-sub, #6b7280);
}

.pp-chat-msg-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.pp-chat-message {
  font-size: 14px;
  color: var(--text-sub, #6b7280);
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  padding-right: 8px;
}

.pp-chat-message.unread-msg {
  color: var(--text-main, inherit);
  font-weight: 500;
}

.pp-chat-badge-wrapper {
  display: flex;
  align-items: center;
  justify-content: center;
  margin-left: 8px;
}

:deep(.pp-badge-wrapper) {
  display: flex;
}

:deep(.pp-badge) {
  position: static;
  transform: none;
}
</style>
