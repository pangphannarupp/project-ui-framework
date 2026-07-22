<template>
  <ion-page>
    <div class="pp-screen branch-map-screen">
      
      <!-- Top header area (Mock) -->
      <div class="map-header">
        <button class="back-btn" @click="router.back()">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
            <polyline points="15 18 9 12 15 6"></polyline>
          </svg>
        </button>
        <h1 class="header-title">PPCBank Branch</h1>
        <p class="header-subtitle">Please find your nearest PPCBank branch with your convenience map and direction.</p>
      </div>

      <!-- Action buttons for demoing the bottom sheets -->
      <div class="demo-actions">
        <PPButton variant="primary" block @click="showFilterSheet = true">Open Filter Sheet</PPButton>
        <PPButton variant="outline" block @click="showSortSheet = true">Open Sort Sheet</PPButton>
      </div>

      <!-- Sheets -->
      <PPFilterSheet 
        v-model="showFilterSheet" 
        v-model:modelValueFacilities="selectedFacilities"
      />

      <PPSortSheet 
        v-model="showSortSheet" 
        v-model:modelValueSort="currentSort"
      />

    </div>
  </ion-page>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { IonPage } from '@ionic/vue';
import { PPButton, PPFilterSheet, PPSortSheet } from '@phanna/ui-framework';

const router = useRouter();

const showFilterSheet = ref(true);
const showSortSheet = ref(false);

const selectedFacilities = ref<string[]>(['Japan Desk']);
const currentSort = ref('distance');
</script>

<style scoped>
.branch-map-screen {
  background-color: #e5e5e5;
  background-image: linear-gradient(#b3c6ff 1px, transparent 1px), linear-gradient(90deg, #b3c6ff 1px, transparent 1px);
  background-size: 20px 20px;
  position: relative;
  display: flex;
  flex-direction: column;
  height: 100vh;
}

.map-header {
  background-color: var(--pp-primary, #003399);
  padding: 56px 24px 24px 24px;
  color: white;
  border-bottom-left-radius: 24px;
  border-bottom-right-radius: 24px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
}

.back-btn {
  background: transparent;
  border: none;
  color: white;
  padding: 0;
  margin-bottom: 24px;
  cursor: pointer;
}

.back-btn svg {
  width: 24px;
  height: 24px;
}

.header-title {
  font-size: 24px;
  font-weight: 700;
  margin: 0 0 8px 0;
}

.header-subtitle {
  font-size: 13px;
  opacity: 0.9;
  line-height: 1.5;
  margin: 0;
}

.demo-actions {
  padding: 24px;
  display: flex;
  flex-direction: column;
  gap: 16px;
  margin-top: auto;
}
</style>
