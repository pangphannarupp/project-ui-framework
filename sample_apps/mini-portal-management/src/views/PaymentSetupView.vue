<script setup lang="ts">
import { ref } from 'vue'
import AdminLayout from '../layouts/AdminLayout.vue'

const gateways = ref([
  {
    id: 'bakong',
    name: 'Bakong KHQR Universal',
    status: true,
    currency: 'KHR & USD',
    merchantId: 'MCNC_KHQR_99014',
    fee: '0.00% (National QR)',
    webhookUrl: 'https://api.miniportal.io/v1/webhooks/bakong-settlement',
    icon: '🇰🇭'
  },
  {
    id: 'payway',
    name: 'ABA PayWay Gateway',
    status: true,
    currency: 'USD & KHR',
    merchantId: 'ec44102919_abaprod',
    fee: '1.20% + $0.10 / txn',
    webhookUrl: 'https://api.miniportal.io/v1/webhooks/aba-payway',
    icon: '💳'
  },
  {
    id: 'wing',
    name: 'Wing Bank Commerce',
    status: false,
    currency: 'USD',
    merchantId: 'WING_BIZ_88301',
    fee: '0.80%',
    webhookUrl: 'https://api.miniportal.io/v1/webhooks/wing-notify',
    icon: '🏦'
  }
])

const saveSuccess = ref(false)

const handleSaveSettings = () => {
  saveSuccess.value = true
  setTimeout(() => {
    saveSuccess.value = false
  }, 3000)
}
</script>

<template>
  <AdminLayout>
    <div class="payment-view">
      <div class="header-card glass-panel">
        <div>
          <h2>Payment Gateways & KHQR Settlement</h2>
          <p>Manage payment merchant credentials, webhook routing, transaction fees, and multi-currency payout rules.</p>
        </div>
        <button @click="handleSaveSettings" class="btn btn-primary">
          💾 Save Gateway Configuration
        </button>
      </div>

      <div v-if="saveSuccess" class="alert-banner">
        ✅ Payment routing preferences saved and pushed to all active mini apps successfully!
      </div>

      <div class="gateways-grid">
        <div v-for="g in gateways" :key="g.id" class="gateway-card glass-panel">
          <div class="gateway-header">
            <div class="gateway-icon">{{ g.icon }}</div>
            <div class="gateway-info">
              <h3>{{ g.name }}</h3>
              <small>{{ g.currency }} • {{ g.fee }}</small>
            </div>
            <label class="switch">
              <input type="checkbox" v-model="g.status" />
              <span class="slider round"></span>
            </label>
          </div>

          <div class="gateway-fields">
            <div class="field-group">
              <label>Merchant / Terminal ID</label>
              <input type="text" v-model="g.merchantId" />
            </div>

            <div class="field-group">
              <label>Webhook Callback URL</label>
              <input type="text" v-model="g.webhookUrl" class="font-mono" />
            </div>

            <div class="field-group">
              <label>Secret API Key (Encrypted HSM)</label>
              <input type="password" value="sk_live_99812903810293810293" />
            </div>
          </div>

          <div class="gateway-footer">
            <button class="test-btn">⚡ Test Webhook Ping</button>
            <button class="small-link">View Logs</button>
          </div>
        </div>
      </div>
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

.gateway-icon {
  font-size: 24px;
  width: 44px;
  height: 44px;
  background: #1f2937;
  border-radius: 12px;
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

.field-group input {
  background: #0f172a;
  border: 1px solid #374151;
  padding: 10px 12px;
  border-radius: 8px;
  color: #fff;
  font-size: 13px;
  outline: none;
}

.font-mono {
  font-family: 'JetBrains Mono', monospace;
}

.gateway-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 14px;
  border-top: 1px solid #1f2937;
}

.test-btn {
  background: #1f2937;
  border: 1px solid #374151;
  color: #cbd5e1;
  padding: 6px 12px;
  border-radius: 6px;
  font-size: 12px;
  cursor: pointer;
}

.small-link {
  background: transparent;
  border: none;
  color: #60a5fa;
  font-size: 12px;
  cursor: pointer;
}

.btn-primary {
  background: linear-gradient(135deg, #2563eb, #4f46e5);
  color: #fff;
  border: none;
  padding: 10px 20px;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
}

/* Switch */
.switch {
  position: relative;
  display: inline-block;
  width: 44px;
  height: 24px;
}
.switch input {
  opacity: 0;
  width: 0;
  height: 0;
}
.slider {
  position: absolute;
  cursor: pointer;
  top: 0; left: 0; right: 0; bottom: 0;
  background-color: #374151;
  transition: .3s;
  border-radius: 24px;
}
.slider:before {
  position: absolute;
  content: "";
  height: 18px;
  width: 18px;
  left: 3px;
  bottom: 3px;
  background-color: white;
  transition: .3s;
  border-radius: 50%;
}
input:checked + .slider {
  background-color: #10b981;
}
input:checked + .slider:before {
  transform: translateX(20px);
}
</style>
