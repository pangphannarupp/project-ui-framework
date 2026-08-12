<template>
  <div class="mobile-tab">
    <!-- Buy for friend card -->
    <BuyFriendCard />

    <!-- Phone Tab -->
    <div class="phone-tab">
      0123 456 789
    </div>

    <!-- Current Plan Card -->
    <CurrentPlanCard @upgrade="showUpgradePlanSheet = true" />

    <!-- Available Add-ons -->
    <AvailableAddons />

    <!-- Available plans -->
    <AvailablePlans />
    
    <UpgradePlanSheet v-model="showUpgradePlanSheet" />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import BuyFriendCard from './components/BuyFriendCard.vue';
import CurrentPlanCard from './components/CurrentPlanCard.vue';
import AvailableAddons from './components/AvailableAddons.vue';
import AvailablePlans from './components/AvailablePlans.vue';
import UpgradePlanSheet from './UpgradePlanSheet.vue';

const showUpgradePlanSheet = ref(false);
</script>

<style scoped>
.mobile-tab {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.phone-tab {
  background-color: #007766;
  color: white;
  display: inline-block;
  padding: 0.5rem 1.5rem;
  border-top-left-radius: 12px;
  border-top-right-radius: 12px;
  font-weight: bold;
  align-self: flex-start;
  margin-bottom: -1rem; /* tuck under the card below */
  z-index: 1;
  position: relative;
}

.section {
  margin-top: 1rem;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 1rem;
}

.section-title {
  margin: 0;
  font-size: 1rem;
  color: var(--text-main);
  margin-bottom: 1rem;
}

.browse-link {
  color: var(--smart-green);
  text-decoration: none;
  font-weight: 500;
  font-size: 0.9rem;
}
</style>
