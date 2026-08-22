<template>
  <div class="wifi-tab">
    <!-- Top up section -->
    <TopUpCard />

    <!-- Explore more Wi-Fi package -->
    <WifiPackageList />
  </div>
</template>

<script setup lang="ts">
import TopUpCard from './components/TopUpCard.vue';
import WifiPackageList from './components/WifiPackageList.vue';
</script>

<style scoped>
.wifi-tab {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}
</style>
