<template>
  <div class="section">
    <h3 class="section-title text-center">Explore more Wi-Fi package</h3>
    <div class="package-list">
      
      <div class="package-card" @click="showFiberSheet = true">
        <div class="package-icon">
          <div class="logo">Smart<br>@Home</div>
        </div>
        <div class="package-info">
          <div class="package-name">5G @Home Chill 500GB <span>👍</span></div>
          <div class="package-speed">200 Mbps / Monthly</div>
        </div>
        <div class="package-price">15 USD</div>
      </div>

      <div class="package-card" @click="showFiberSheet = true">
        <div class="package-icon">
          <div class="logo">Smart<br>@Home</div>
        </div>
        <div class="package-info">
          <div class="package-name">5G @Home Pro 1000GB</div>
          <div class="package-speed">200 Mbps / Monthly</div>
        </div>
        <div class="package-price">18 USD</div>
      </div>

      <div class="package-card" @click="showFiberSheet = true">
        <div class="package-icon">
          <div class="logo">Smart<br>@Home</div>
        </div>
        <div class="package-info">
          <div class="package-name">5G @Home Stream 2000GB</div>
          <div class="package-speed">200 Mbps / Monthly</div>
        </div>
        <div class="package-price">22 USD</div>
      </div>

    </div>
    
    <SmartFiberSheet v-model="showFiberSheet" />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import SmartFiberSheet from '../SmartFiberSheet.vue';

const showFiberSheet = ref(false);
</script>

<style scoped>
.section {
  margin-top: 1rem;
}

.section-title {
  margin: 0;
  font-size: 1rem;
  color: var(--text-main);
  margin-bottom: 1rem;
}

.text-center {
  text-align: center;
}

.package-list {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.package-card {
  background: white;
  border-radius: 12px;
  padding: 1rem;
  display: flex;
  align-items: center;
  gap: 1rem;
  box-shadow: 0 2px 4px rgba(0,0,0,0.02);
  cursor: pointer;
}

.package-icon {
  flex-shrink: 0;
}

.logo {
  font-size: 0.7rem;
  font-weight: bold;
  color: var(--smart-green);
  border: 1px solid #eee;
  padding: 4px;
  border-radius: 4px;
  text-align: center;
}

.package-info {
  flex: 1;
}

.package-name {
  font-weight: bold;
  font-size: 0.95rem;
  margin-bottom: 0.25rem;
}

.package-speed {
  font-size: 0.8rem;
  color: var(--text-secondary);
}

.package-price {
  font-weight: bold;
  color: var(--text-main);
}
</style>
