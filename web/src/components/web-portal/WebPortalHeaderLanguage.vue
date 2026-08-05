<template>
  <div class="dropdown-wrapper" ref="languageWrapperRef">
    <button class="header-btn" @click="toggleLanguage">
      <ion-icon :icon="languageOutline" style="font-size: 18px;" />
      {{ currentLanguage }}
      <svg viewBox="0 0 24 24" width="16" height="16" stroke="currentColor" stroke-width="2" fill="none" style="margin-left: 4px;"><path d="M6 9l6 6 6-6"/></svg>
    </button>
    <transition name="dropdown-fade">
      <div v-if="isOpen" class="custom-dropdown simple-menu">
        <div class="dropdown-item" @click="setLanguage('English')">🇬🇧 English</div>
        <div class="dropdown-item" @click="setLanguage('Khmer')">🇰🇭 ភាសាខ្មែរ</div>
      </div>
    </transition>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, onUnmounted } from 'vue';
import { IonIcon } from '@ionic/vue';
import { languageOutline } from 'ionicons/icons';

const isOpen = ref(false);
const currentLanguage = ref('English');
const languageWrapperRef = ref<HTMLElement | null>(null);

const toggleLanguage = () => {
  isOpen.value = !isOpen.value;
};

const setLanguage = (lang: string) => {
  currentLanguage.value = lang;
  isOpen.value = false;
};

const closeOnOutsideClick = (e: MouseEvent) => {
  if (languageWrapperRef.value && !languageWrapperRef.value.contains(e.target as Node)) {
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
.header-btn {
  background: white;
  border: 1px solid #e2e8f0;
  color: #64748b;
  padding: 8px 16px;
  border-radius: 20px;
  font-family: inherit;
  font-size: 14px;
  font-weight: 500;
  cursor: pointer;
  display: flex;
  align-items: center;
  gap: 8px;
  transition: all 0.2s ease;
}

.header-btn:hover {
  background: #f8fafc;
  color: #1e293b;
}

.dropdown-wrapper {
  position: relative;
}

.custom-dropdown {
  position: absolute;
  top: calc(100% + 12px);
  right: 0;
  background: white;
  border: 1px solid #e2e8f0;
  border-radius: 16px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.025);
  z-index: 1000;
  display: flex;
  flex-direction: column;
  overflow: hidden;
}

.simple-menu {
  width: 160px;
  padding: 8px 0;
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
