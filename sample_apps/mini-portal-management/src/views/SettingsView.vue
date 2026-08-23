<script setup lang="ts">
import AdminLayout from '../layouts/AdminLayout.vue'
import { useSettingsViewModel } from '../viewmodels/useSettingsViewModel'

const {
  settings,
  saved,
  handleSave
} = useSettingsViewModel()
</script>

<template>
  <AdminLayout>
    <div class="settings-view">
      <div class="header-card glass-panel">
        <div>
          <h2>Portal Cluster & Security Policies</h2>
          <p>Configure portal branding, security authentication protocols, and global logging limits.</p>
        </div>
        <PPButton @click="handleSave" variant="primary" size="small">
          <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:6px;"><path d="M19 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11l5 5v11a2 2 0 0 1-2 2z"></path><polyline points="17 21 17 13 7 13 7 21"></polyline><polyline points="7 3 7 8 15 8"></polyline></svg>
          <span>Save Changes</span>
        </PPButton>
      </div>

      <div v-if="saved" class="alert-banner">
        <PPChip label="PERSISTED" color="success" size="sm" variant="soft" />
        <span>Portal settings updated across distributed edge nodes!</span>
      </div>

      <div class="settings-cards">
        <div class="card glass-panel">
          <h3>General Brand Configuration</h3>
          <div class="form-group">
            <label>Console Title</label>
            <PPInput v-model="settings.portalName" />
          </div>

          <div class="toggle-row">
            <div>
              <strong>Developer Sandbox Testing Mode</strong>
              <p>Allow unverified local mini apps to mount without cryptographic signature checks.</p>
            </div>
            <PPSwitch v-model="settings.sandboxMode" />
          </div>
        </div>

        <div class="card glass-panel">
          <h3>Authentication & Single Sign-On</h3>
          <div class="form-group">
            <label>Identity Provider</label>
            <PPInput v-model="settings.ssoProvider" />
          </div>

          <div class="toggle-row">
            <div>
              <strong>Enforce Hardware Multi-Factor Authentication (MFA)</strong>
              <p>Require FIDO2 WebAuthn / TOTP authenticators for all operator accounts.</p>
            </div>
            <PPSwitch v-model="settings.enforceMfa" />
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
  display: flex;
  align-items: center;
  gap: 10px;
}

.settings-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(380px, 1fr));
  gap: 20px;
}

.card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 24px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.card h3 {
  font-size: 16px;
  color: #fff;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.form-group label {
  font-size: 12px;
  color: #cbd5e1;
}

.toggle-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 14px;
  border-top: 1px solid #1f2937;
  gap: 16px;
}

.toggle-row strong {
  display: block;
  font-size: 13px;
  color: #fff;
}

.toggle-row p {
  font-size: 12px;
  color: #94a3b8;
  margin-top: 2px;
}
</style>
