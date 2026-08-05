<template>
  <button class="header-btn theme-toggle" @click="toggleTheme" :title="isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode'">
    <ion-icon :icon="isDark ? sunnyOutline : moonOutline" style="font-size: 20px;" />
  </button>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { IonIcon } from '@ionic/vue';
import { moonOutline, sunnyOutline } from 'ionicons/icons';

const isDark = ref(true); 

onMounted(() => {
  // Check initial state
  isDark.value = !document.body.classList.contains('light-theme');
});

const toggleTheme = () => {
  isDark.value = !isDark.value;
  if (isDark.value) {
    document.body.classList.remove('light-theme');
  } else {
    document.body.classList.add('light-theme');
  }
};
</script>

<style scoped>
.theme-toggle {
  background: white;
  border: 1px solid #e2e8f0;
  color: #64748b;
  width: 38px;
  height: 38px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s ease;
  padding: 0;
}

.theme-toggle:hover {
  background: #f8fafc;
  color: #1e293b;
}
</style>
