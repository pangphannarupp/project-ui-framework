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
    <AvailableAddons @purchase="handlePurchase" />

    <!-- Available plans -->
    <AvailablePlans />
    
    <UpgradePlanSheet v-model="showUpgradePlanSheet" />

    <!-- Payment Alert Modal -->
    <PPAlert
      v-model="showAlert"
      :title="alertTitle"
      :message="alertMessage"
      :confirmText="alertType === 'success' ? 'OK' : 'Close'"
    >
      <template #icon>
        <div class="alert-status-icon" :class="alertType">
          <svg v-if="alertType === 'success'" viewBox="0 0 24 24" width="48" height="48" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
          <svg v-else viewBox="0 0 24 24" width="48" height="48" fill="none" stroke="currentColor" stroke-width="2">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
          </svg>
        </div>
      </template>
    </PPAlert>
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';
import { PPAlert } from '@phanna/ui-framework';
import BuyFriendCard from './components/BuyFriendCard.vue';
import CurrentPlanCard from './components/CurrentPlanCard.vue';
import AvailableAddons from './components/AvailableAddons.vue';
import AvailablePlans from './components/AvailablePlans.vue';
import UpgradePlanSheet from './UpgradePlanSheet.vue';
import '../../lib/mini.app.lib.js';

const MiniApp = (window as any).MiniApp;

const showUpgradePlanSheet = ref(false);

// Alert State
const showAlert = ref(false);
const alertType = ref<'success' | 'failed'>('success');
const alertTitle = ref('');
const alertMessage = ref('');

const handlePurchase = async (packName: string) => {
  try {
    const result = await MiniApp.requestPayment({
        serviceType: MiniApp.ServiceType.KHQR_PURCHASE,
        prepayId: "PREPAY_" + Date.now(),
        amount: 10.00,
        currency: "USD",
        partnerCode: "METFONE",
        metadata: {
            orderId: "ORDER_" + Date.now(),
            accountNumber: "012345678",
            packName: packName
        }
    });
    console.log("Payment status:", result.status);
    console.log("Transaction ID:", result.transactionId);

    alertType.value = 'success';
    alertTitle.value = 'Payment Successful';
    alertMessage.value = `You have successfully purchased ${packName}!\nTransaction ID: ${result.transactionId || 'SUCCESS'}`;
    showAlert.value = true;
  } catch (error: any) {
    console.error("Payment failed or cancelled:", error);
    alertType.value = 'failed';
    alertTitle.value = 'Payment Failed';
    alertMessage.value = error?.errorMessage || error?.message || 'Payment was cancelled or failed to process.';
    showAlert.value = true;
  }
};
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

.alert-status-icon {
  display: flex;
  align-items: center;
  justify-content: center;
}

.alert-status-icon.success {
  color: #00A651;
}

.alert-status-icon.failed {
  color: #ff4d4f;
}
</style>
