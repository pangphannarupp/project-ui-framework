<script setup lang="ts">
import { useZooStore } from './store/zooStore';

const store = useZooStore();
</script>

<template>
  <div class="app-container">
    <router-view />

    <!-- Global Toast Notification -->
    <transition name="toast-slide">
      <div 
        v-if="store.state.toastMessage" 
        class="floating-toast"
        :class="'toast-' + store.state.toastType"
      >
        <span>{{ store.state.toastMessage }}</span>
      </div>
    </transition>
  </div>
</template>

<style>
.app-container {
  min-height: 100vh;
  position: relative;
}

.floating-toast {
  position: fixed;
  bottom: 24px;
  right: 24px;
  z-index: 9999;
  padding: 12px 20px;
  border-radius: 14px;
  font-weight: 700;
  font-size: 0.9rem;
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
  display: flex;
  align-items: center;
  gap: 8px;
  animation: bounceIn 0.3s ease;
}

.toast-info {
  background: #0f172a;
  color: #ffffff;
}

.toast-success {
  background: #059669;
  color: #ffffff;
}

.toast-warning {
  background: #d97706;
  color: #ffffff;
}

.toast-error {
  background: #dc2626;
  color: #ffffff;
}

.toast-slide-enter-active,
.toast-slide-leave-active {
  transition: all 0.3s ease;
}

.toast-slide-enter-from,
.toast-slide-leave-to {
  opacity: 0;
  transform: translateY(20px);
}
</style>
