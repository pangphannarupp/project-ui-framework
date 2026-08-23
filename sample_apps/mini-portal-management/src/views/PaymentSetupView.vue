<script setup lang="ts">
import AdminLayout from '../layouts/AdminLayout.vue'
import { usePaymentSetupViewModel } from '../viewmodels/usePaymentSetupViewModel'

const {
  isLoading,
  gateways,
  saveSuccess,
  handleSaveSettings
} = usePaymentSetupViewModel()
</script>

<template>
  <AdminLayout>
    <div class="payment-view">
      <div class="header-card glass-panel">
        <div>
          <h2>Payment Gateways & KHQR Settlement</h2>
          <p>Manage payment merchant credentials, webhook routing, transaction fees, and multi-currency payout rules.</p>
        </div>
        <PPButton @click="handleSaveSettings" variant="primary" size="small">
          <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:6px;"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
          <span>Save Gateway Configuration</span>
        </PPButton>
      </div>

      <div v-if="saveSuccess" class="alert-banner">
        <PPChip label="SYNCHRONIZED" color="success" size="sm" variant="soft" />
        <span>Payment routing preferences saved and pushed to all active mini apps successfully!</span>
      </div>

      <!-- PPSkeleton Loading State -->
      <PPSkeleton :loading="isLoading" :animated="true">
        <template #template>
          <div class="gateways-grid">
            <div v-for="i in 3" :key="i" class="skeleton-card" style="padding: 24px; height: 380px;">
              <div style="display: flex; align-items: center; justify-content: space-between;">
                <div style="display: flex; align-items: center; gap: 12px;">
                  <PPSkeletonItem variant="rect" width="46px" height="46px" style="border-radius: 12px;" />
                  <div style="display: flex; flex-direction: column; gap: 4px;">
                    <PPSkeletonItem variant="text" width="140px" height="18px" />
                    <PPSkeletonItem variant="text" width="90px" height="12px" />
                  </div>
                </div>
                <PPSkeletonItem variant="rect" width="48px" height="26px" style="border-radius: 13px;" />
              </div>
              <div style="display: flex; flex-direction: column; gap: 14px; margin-top: 20px;">
                <PPSkeletonItem variant="rect" height="40px" style="border-radius: 8px;" />
                <PPSkeletonItem variant="rect" height="40px" style="border-radius: 8px;" />
                <PPSkeletonItem variant="rect" height="40px" style="border-radius: 8px;" />
              </div>
            </div>
          </div>
        </template>

        <div class="gateways-grid">
          <div v-for="g in gateways" :key="g.id" class="gateway-card glass-panel">
            <div class="gateway-header">
              <div class="gateway-icon-svg" :style="{ color: g.color, backgroundColor: `${g.color}15`, borderColor: `${g.color}35` }">
                <svg v-if="g.icon === 'qr-code'" viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="3" width="7" height="7"></rect><rect x="14" y="3" width="7" height="7"></rect><rect x="14" y="14" width="7" height="7"></rect><rect x="3" y="14" width="7" height="7"></rect></svg>
                <svg v-else-if="g.icon === 'card'" viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2"><rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect><line x1="1" y1="10" x2="23" y2="10"></line></svg>
                <svg v-else viewBox="0 0 24 24" width="22" height="22" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
              </div>
              <div class="gateway-info">
                <h3>{{ g.name }}</h3>
                <small>{{ g.currency }} • {{ g.fee }}</small>
              </div>
              <PPSwitch v-model="g.status" />
            </div>

            <div class="gateway-fields">
              <div class="field-group">
                <label>Merchant / Terminal ID</label>
                <PPInput v-model="g.merchantId" />
              </div>

              <div class="field-group">
                <label>Webhook Callback URL</label>
                <PPInput v-model="g.webhookUrl" />
              </div>

              <div class="field-group">
                <label>Secret API Key (Encrypted HSM)</label>
                <PPInput type="password" modelValue="sk_live_99812903810293810293" />
              </div>
            </div>

            <div class="gateway-footer">
              <PPButton size="small" variant="outline">
                <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:4px;"><polygon points="13 2 3 14 12 14 11 22 21 10 12 10 13 2"></polygon></svg>
                <span>Test Webhook Ping</span>
              </PPButton>
              <RouterLink to="/logs" style="text-decoration:none;">
                <PPButton size="small" variant="outline">
                  <span>View Logs</span>
                </PPButton>
              </RouterLink>
            </div>
          </div>
        </div>
      </PPSkeleton>
    </div>
  </AdminLayout>
</template>

<style scoped>
.payment-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.header-card {
  padding: 24px;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
}

.header-card h2 {
  font-size: 20px;
  color: #fff;
  margin-bottom: 4px;
}

.header-card p {
  color: #94a3b8;
  font-size: 13px;
}

.alert-banner {
  background: rgba(16, 185, 129, 0.15);
  border: 1px solid #10b981;
  color: #6ee7b7;
  padding: 12px 16px;
  border-radius: 10px;
  font-size: 13px;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 10px;
}

.gateways-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 20px;
}

.gateway-card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 24px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.gateway-header {
  display: flex;
  align-items: center;
  gap: 14px;
}

.gateway-icon-svg {
  width: 44px;
  height: 44px;
  border-radius: 12px;
  border: 1px solid;
  display: flex;
  align-items: center;
  justify-content: center;
}

.gateway-info {
  flex: 1;
}

.gateway-info h3 {
  font-size: 16px;
  color: #fff;
}

.gateway-info small {
  font-size: 12px;
  color: #94a3b8;
}

.gateway-fields {
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.field-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.field-group label {
  font-size: 12px;
  color: #cbd5e1;
  font-weight: 500;
}

.gateway-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 14px;
  border-top: 1px solid #1f2937;
}
</style>
