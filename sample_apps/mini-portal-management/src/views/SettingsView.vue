<script setup lang="ts">
import { ref } from 'vue'
import AdminLayout from '../layouts/AdminLayout.vue'

const generalSettings = ref({
  portalName: 'Mini Portal Management',
  clusterRegion: 'ap-southeast-1 (Singapore)',
  cdnDomain: 'https://pangphannarupp.github.io/project-ui-framework',
  maintenanceMode: false,
  autoPurgeDays: 30,
  enforce2FA: true
})

const isSaved = ref(false)

const handleSave = () => {
  isSaved.value = true
  setTimeout(() => {
    isSaved.value = false
  }, 2500)
}
</script>

<template>
  <AdminLayout>
    <div class="settings-view">
      <div class="header-card glass-panel">
        <div>
          <h2>Portal & Edge Node Preferences</h2>
          <p>Configure global cluster properties, security boundaries, and telemetry purge policies.</p>
        </div>
        <button @click="handleSave" class="btn btn-primary">
          💾 Save Portal Settings
        </button>
      </div>

      <div v-if="isSaved" class="alert-banner">
        ✅ System preferences updated successfully!
      </div>

      <div class="settings-grid">
        <!-- General Card -->
        <div class="card glass-panel">
          <h3>🏢 General Configuration</h3>
          <div class="form-group">
            <label>Portal Title</label>
            <input type="text" v-model="generalSettings.portalName" />
          </div>
          <div class="form-group">
            <label>Primary Deployment CDN</label>
            <input type="text" v-model="generalSettings.cdnDomain" class="font-mono" />
          </div>
          <div class="form-group">
            <label>Primary Cluster Cloud Region</label>
            <input type="text" v-model="generalSettings.clusterRegion" />
          </div>
        </div>

        <!-- Security Card -->
        <div class="card glass-panel">
          <h3>🔒 Security & Authentication</h3>
          <div class="toggle-row">
            <div>
              <strong>Enforce Mandatory 2FA</strong>
              <p>Require OTP code for all administrators upon login.</p>
            </div>
            <label class="switch">
              <input type="checkbox" v-model="generalSettings.enforce2FA" />
              <span class="slider round"></span>
            </label>
          </div>

          <div class="toggle-row">
            <div>
              <strong>Global Maintenance Mode</strong>
              <p>Temporarily lock non-admin access to all 30 mini apps.</p>
            </div>
            <label class="switch">
              <input type="checkbox" v-model="generalSettings.maintenanceMode" />
              <span class="slider round"></span>
            </label>
          </div>

          <div class="form-group">
            <label>Audit Log Retention Window (Days)</label>
            <input type="number" v-model="generalSettings.autoPurgeDays" />
          </div>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
.settings-view {
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

.settings-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
  gap: 24px;
}

.card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 24px;
  display: flex;
  flex-direction: column;
  gap: 18px;
}

.card h3 {
  font-size: 16px;
  color: #fff;
  margin-bottom: 4px;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.form-group label {
  font-size: 13px;
  color: #cbd5e1;
  font-weight: 500;
}

.form-group input {
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

.toggle-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 0;
  border-bottom: 1px solid #1f2937;
}

.toggle-row strong {
  display: block;
  font-size: 14px;
  color: #fff;
}

.toggle-row p {
  font-size: 12px;
  color: #94a3b8;
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
