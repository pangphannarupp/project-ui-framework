<script setup lang="ts">
import AdminLayout from '../layouts/AdminLayout.vue'
import RichTextEditor from '../components/RichTextEditor.vue'
import { usePushManagementViewModel } from '../viewmodels/usePushManagementViewModel'

const {
  isLoading,
  activeTab,
  campaigns,
  pushConfigs,
  showConfigModal,
  isEditingConfig,
  configForm,
  newPush,
  appsList,
  audiences,
  isSending,
  handleSendPush,
  handleServiceAccountFileSelect,
  openCreateConfigModal,
  openEditConfigModal,
  handleSaveConfig,
  toggleConfigStatus,
  deleteConfig
} = usePushManagementViewModel()
</script>

<template>
  <AdminLayout>
    <div class="push-view">
      <!-- Top Navigation Tabs & Header -->
      <div class="top-nav glass-panel">
        <div class="header-left">
          <h2>Push Notification Dispatcher & Gateway Config</h2>
          <p>Configure Apple APNs certificates, Firebase FCM credentials, and broadcast push messages to mini app users.</p>
        </div>

        <div class="header-right">
          <div class="tab-segment-wrapper">
            <PPSegment v-model="activeTab" variant="pill">
              <PPSegmentButton value="campaigns">
                <span>Broadcast Campaigns</span>
              </PPSegmentButton>
              <PPSegmentButton value="configs">
                <span>Push Configurations ({{ pushConfigs.length }})</span>
              </PPSegmentButton>
            </PPSegment>
          </div>

          <PPButton
            v-if="activeTab === 'configs'"
            size="small"
            variant="primary"
            @click="openCreateConfigModal"
          >
            <span>+ Register Push Config</span>
          </PPButton>
        </div>
      </div>

      <!-- TAB 1: Push Campaigns Composer & History -->
      <PPSkeleton :loading="isLoading" :animated="true">
        <template #template>
          <div class="skeleton-grid">
            <div class="skeleton-card" style="height: 480px;">
              <PPSkeletonItem variant="text" width="60%" height="22px" />
              <PPSkeletonItem variant="text" width="40%" height="14px" />
              <div v-for="k in 4" :key="k" style="margin-top: 12px; display: flex; flex-direction: column; gap: 6px;">
                <PPSkeletonItem variant="text" width="30%" height="12px" />
                <PPSkeletonItem variant="rect" height="40px" style="border-radius: 8px;" />
              </div>
            </div>
            <div class="skeleton-card" style="height: 480px;">
              <PPSkeletonItem variant="text" width="50%" height="22px" />
              <div v-for="m in 4" :key="m" style="margin-top: 16px; display: flex; flex-direction: column; gap: 6px;">
                <PPSkeletonItem variant="text" width="70%" />
                <PPSkeletonItem variant="text" width="90%" height="12px" />
              </div>
            </div>
          </div>
        </template>

        <div v-if="activeTab === 'campaigns'" class="push-grid">
          <!-- Composer Form -->
          <div class="card glass-panel composer-card">
            <div class="card-header">
              <div class="section-title-row">
                <svg viewBox="0 0 24 24" width="18" height="18" fill="none" stroke="#60a5fa" stroke-width="2"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"></path><path d="M13.73 21a2 2 0 0 1-3.46 0"></path></svg>
                <h3>Compose Push Notification</h3>
              </div>
              <small>Dispatch notifications via Firebase Cloud Messaging & Apple APNs</small>
            </div>

            <form @submit.prevent="handleSendPush" class="push-form">
              <div class="form-group">
                <label>Target Mini Application</label>
                <PPSelect
                  v-model="newPush.targetApp"
                  :options="appsList.map(a => ({ label: a, value: a }))"
                />
              </div>

              <div class="form-group">
                <label>Audience Segment</label>
                <PPSelect
                  v-model="newPush.targetAudience"
                  :options="audiences.map(aud => ({ label: aud, value: aud }))"
                />
              </div>

              <div class="form-group">
                <label>Notification Title</label>
                <PPInput v-model="newPush.title" placeholder="e.g. Flash Deal for Lunch" required />
              </div>

              <div class="form-group">
                <label>Notification Body / Rich Message</label>
                <RichTextEditor
                  v-model="newPush.message"
                  placeholder="Enter notification message..."
                  min-height="90px"
                />
              </div>

              <!-- Preview Box -->
              <div class="preview-box">
                <span class="preview-label">Mobile Lockscreen Preview:</span>
                <div class="mobile-notification">
                  <div class="notif-header">
                    <span>Mini Portal • {{ newPush.targetApp || 'Mini App' }}</span>
                    <small>now</small>
                  </div>
                  <strong>{{ newPush.title || 'Notification Headline' }}</strong>
                  <div class="notif-body-preview" v-html="newPush.message || 'Notification preview text will appear right here.'"></div>
                </div>
              </div>

              <PPButton type="submit" variant="primary" :disabled="isSending" style="width: 100%;">
                <span v-if="isSending">Dispatching via Edge Push Nodes...</span>
                <span v-else style="display:inline-flex; align-items:center; gap:6px;">
                  <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><line x1="22" y1="2" x2="11" y2="13"></line><polygon points="22 2 15 22 11 13 2 9 22 2"></polygon></svg>
                  <span>Broadcast Notification Now</span>
                </span>
              </PPButton>
            </form>
          </div>

          <!-- History & Metrics -->
          <div class="card glass-panel history-card">
            <div class="card-header">
              <h3>Dispatched Campaigns History</h3>
              <PPChip label="LIVE FEED" color="info" size="sm" variant="soft" />
            </div>

            <div class="campaign-list">
              <div v-for="c in campaigns" :key="c.id" class="campaign-item">
                <div class="campaign-top">
                  <strong>{{ c.title }}</strong>
                  <PPChip
                    :label="c.status.toUpperCase()"
                    :color="c.status === 'Sent' ? 'success' : 'warning'"
                    size="sm"
                    variant="soft"
                  />
                </div>
                <div class="campaign-msg" v-html="c.message"></div>
                <div class="campaign-stats">
                  <span>{{ c.targetApp }}</span>
                  <span>{{ c.sentCount.toLocaleString() }} delivered</span>
                  <span>{{ c.openRate }} open rate</span>
                  <span class="font-mono text-muted">{{ c.sentAt }}</span>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- TAB 2: Push Configurations List -->
        <div v-else class="configs-container card glass-panel">
          <div class="table-container">
            <table class="portal-table">
              <thead>
                <tr>
                  <th>PROVIDER</th>
                  <th>APPLICATION SCOPE</th>
                  <th>ENVIRONMENT</th>
                  <th>ATTACHED KEY / CREDENTIALS</th>
                  <th>APP / BUNDLE ID</th>
                  <th>PROJECT / TEAM ID</th>
                  <th>STATUS</th>
                  <th>LAST TESTED</th>
                  <th>ACTIONS</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="cfg in pushConfigs" :key="cfg.id">
                  <td>
                    <div class="provider-cell">
                      <span class="provider-badge" :class="cfg.provider.toLowerCase()">{{ cfg.provider }}</span>
                    </div>
                  </td>
                  <td><strong>{{ cfg.appName }}</strong></td>
                  <td>
                    <PPChip
                      :label="cfg.environment"
                      :color="cfg.environment === 'Production' ? 'success' : 'warning'"
                      size="sm"
                      variant="soft"
                    />
                  </td>
                  <td>
                    <div class="key-file-badge">
                      <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="#60a5fa" stroke-width="2">
                        <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                        <polyline points="14 2 14 8 20 8"></polyline>
                      </svg>
                      <span class="font-mono">{{ cfg.serviceAccountFileName || 'Private Key Configured' }}</span>
                    </div>
                  </td>
                  <td class="font-mono">{{ cfg.appIdOrBundleId }}</td>
                  <td class="font-mono text-muted">{{ cfg.teamIdOrProject }}</td>
                  <td>
                    <PPChip
                      :label="cfg.status.toUpperCase()"
                      :color="cfg.status === 'active' ? 'success' : 'danger'"
                      size="sm"
                      variant="soft"
                    />
                  </td>
                  <td class="font-mono text-muted">{{ cfg.lastTestedAt }}</td>
                  <td>
                    <div class="config-actions">
                      <PPButton size="small" variant="outline" @click="toggleConfigStatus(cfg)">
                        <span>{{ cfg.status === 'active' ? 'Disable' : 'Enable' }}</span>
                      </PPButton>
                      <PPButton size="small" variant="outline" @click="openEditConfigModal(cfg)">
                        <span>Edit</span>
                      </PPButton>
                      <PPButton size="small" variant="outline" @click="deleteConfig(cfg.id)">
                        <span>Delete</span>
                      </PPButton>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>
      </PPSkeleton>

      <!-- Register / Edit Push Configuration Modal -->
      <div v-if="showConfigModal" class="modal-backdrop" @click.self="showConfigModal = false">
        <div class="modal-card glass-panel glow-blue">
          <div class="modal-header">
            <h3>{{ isEditingConfig ? 'Edit Push Configuration' : 'Register Push Gateway Configuration' }}</h3>
            <button class="close-btn" @click="showConfigModal = false">✕</button>
          </div>

          <form @submit.prevent="handleSaveConfig" class="modal-form">
            <div class="form-row">
              <div class="form-group">
                <label>Push Provider Service</label>
                <PPSelect
                  v-model="configForm.provider"
                  :options="[
                    { label: 'Firebase Cloud Messaging (FCM)', value: 'FCM' },
                    { label: 'Apple Push Notification service (APNs)', value: 'APNs' },
                    { label: 'OneSignal Multi-Channel', value: 'OneSignal' }
                  ]"
                />
              </div>

              <div class="form-group">
                <label>Target Mini Application</label>
                <PPSelect
                  v-model="configForm.appName"
                  :options="appsList.map(a => ({ label: a, value: a }))"
                />
              </div>
            </div>

            <div class="form-row">
              <div class="form-group">
                <label>Target Environment</label>
                <PPSelect
                  v-model="configForm.environment"
                  :options="[
                    { label: 'Production Live', value: 'Production' },
                    { label: 'Sandbox / Staging', value: 'Sandbox' }
                  ]"
                />
              </div>

              <div class="form-group">
                <label>Status</label>
                <PPSelect
                  v-model="configForm.status"
                  :options="[
                    { label: 'Active', value: 'active' },
                    { label: 'Inactive', value: 'inactive' }
                  ]"
                />
              </div>
            </div>

            <!-- Attach Firebase Admin SDK or APNs Auth Key File -->
            <div class="form-group">
              <label>
                {{ configForm.provider === 'FCM' ? 'Attach Firebase Admin SDK Private Key (JSON)' : 'Attach Gateway Key File (.p8 / JSON)' }}
              </label>
              <div class="file-upload-dropzone">
                <input
                  type="file"
                  :accept="configForm.provider === 'FCM' ? '.json,application/json' : '.p8,.json'"
                  class="file-input-hidden"
                  id="service-account-upload"
                  @change="handleServiceAccountFileSelect"
                />
                <label for="service-account-upload" class="dropzone-label">
                  <svg viewBox="0 0 24 24" width="24" height="24" fill="none" stroke="#60a5fa" stroke-width="2">
                    <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"></path>
                    <polyline points="17 8 12 3 7 8"></polyline>
                    <line x1="12" y1="3" x2="12" y2="15"></line>
                  </svg>
                  <div class="dropzone-text">
                    <span v-if="configForm.serviceAccountFileName" class="uploaded-filename">
                      📄 {{ configForm.serviceAccountFileName }} (Attached)
                    </span>
                    <span v-else>
                      Click or drag & drop <strong>{{ configForm.provider === 'FCM' ? 'serviceAccountKey.json' : 'AuthKey.p8' }}</strong>
                    </span>
                    <small>Auto-populates Project ID, Client Email & Key credentials</small>
                  </div>
                </label>
              </div>
            </div>

            <div class="form-group">
              <label>{{ configForm.provider === 'APNS' ? 'iOS App Bundle Identifier' : 'Client Email / App ID' }}</label>
              <PPInput
                v-model="configForm.appIdOrBundleId"
                :placeholder="configForm.provider === 'APNS' ? 'com.miniportal.coffeepickup' : 'firebase-adminsdk@miniportal-prod.iam.gserviceaccount.com'"
                required
              />
            </div>

            <div class="form-group">
              <label>{{ configForm.provider === 'APNS' ? 'Apple Team ID / Auth Key ID' : 'Firebase Project ID' }}</label>
              <PPInput
                v-model="configForm.teamIdOrProject"
                :placeholder="configForm.provider === 'APNS' ? 'TEAM_ID_849302KD' : 'miniportal-firebase-prod'"
                required
              />
            </div>

            <div class="form-group">
              <label>{{ configForm.provider === 'APNS' ? 'APNs Auth Key (.p8 text / token)' : 'Private Key / API Secret' }}</label>
              <PPInput
                v-model="configForm.apiKeyOrKeyId"
                type="password"
                placeholder="Auto-extracted from attached JSON or enter private key..."
                required
              />
            </div>

            <div class="modal-footer">
              <PPButton type="button" variant="outline" size="small" @click="showConfigModal = false">
                <span>Cancel</span>
              </PPButton>
              <PPButton type="submit" variant="primary" size="small">
                <span>{{ isEditingConfig ? 'Save Configuration' : 'Register Gateway Config' }}</span>
              </PPButton>
            </div>
          </form>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
.push-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.push-grid {
  display: grid;
  grid-template-columns: 1.2fr 1fr;
  gap: 24px;
}

@media (max-width: 900px) {
  .push-grid {
    grid-template-columns: 1fr;
  }
}

.card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 24px;
  display: flex;
  flex-direction: column;
}

.section-title-row {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 4px;
}

.card-header h3 {
  font-size: 16px;
  color: #fff;
  margin: 0;
}

.card-header small {
  color: #94a3b8;
  font-size: 12px;
}

.push-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
  margin-top: 16px;
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

.preview-box {
  margin-top: 6px;
}

.preview-label {
  font-size: 11px;
  color: #94a3b8;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  display: block;
  margin-bottom: 8px;
}

.mobile-notification {
  background: rgba(30, 41, 59, 0.85);
  border: 1px solid #374151;
  border-radius: 14px;
  padding: 14px 16px;
  display: flex;
  flex-direction: column;
  gap: 4px;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
}

.notif-header {
  display: flex;
  justify-content: space-between;
  font-size: 11px;
  color: #93c5fd;
  font-weight: 600;
}

.mobile-notification strong {
  font-size: 13px;
  color: #fff;
}

.notif-body-preview {
  font-size: 13px;
  color: #cbd5e1;
  line-height: 1.4;
}

.history-card {
  height: 100%;
}

.campaign-list {
  display: flex;
  flex-direction: column;
  gap: 16px;
  margin-top: 16px;
  max-height: 600px;
  overflow-y: auto;
}

.campaign-item {
  background: #0f172a;
  border: 1px solid #1f2937;
  border-radius: 12px;
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.campaign-top {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.campaign-msg {
  font-size: 13px;
  color: #94a3b8;
  line-height: 1.4;
}

.campaign-stats {
  display: flex;
  align-items: center;
  gap: 14px;
  font-size: 11px;
  color: #64748b;
  border-top: 1px solid #1f2937;
  padding-top: 10px;
}

/* Top Nav & Configuration Table */
.top-nav {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  padding: 20px 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
}

.header-left h2 {
  font-size: 18px;
  color: #fff;
  margin: 0 0 4px 0;
}

.header-left p {
  font-size: 13px;
  color: #94a3b8;
  margin: 0;
}

.header-right {
  display: flex;
  align-items: center;
  gap: 16px;
}

.provider-cell {
  display: flex;
  align-items: center;
}

.provider-badge {
  font-size: 11px;
  font-weight: 700;
  padding: 4px 8px;
  border-radius: 6px;
  text-transform: uppercase;
}

.provider-badge.fcm {
  background: rgba(245, 158, 11, 0.15);
  color: #f59e0b;
  border: 1px solid rgba(245, 158, 11, 0.3);
}

.provider-badge.apns {
  background: rgba(99, 102, 241, 0.15);
  color: #818cf8;
  border: 1px solid rgba(99, 102, 241, 0.3);
}

.provider-badge.onesignal {
  background: rgba(239, 68, 68, 0.15);
  color: #f87171;
  border: 1px solid rgba(239, 68, 68, 0.3);
}

.key-file-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  background: #0f172a;
  border: 1px solid #1f2937;
  padding: 4px 10px;
  border-radius: 6px;
  font-size: 12px;
  color: #cbd5e1;
}

.file-upload-dropzone {
  border: 2px dashed #374151;
  border-radius: 12px;
  background: #0f172a;
  transition: all 0.2s ease;
}

.file-upload-dropzone:hover {
  border-color: #3b82f6;
  background: rgba(59, 130, 246, 0.05);
}

.file-input-hidden {
  display: none;
}

.dropzone-label {
  display: flex;
  align-items: center;
  gap: 14px;
  padding: 16px 20px;
  cursor: pointer;
  width: 100%;
}

.dropzone-text {
  display: flex;
  flex-direction: column;
  gap: 2px;
  font-size: 13px;
  color: #cbd5e1;
}

.dropzone-text strong {
  color: #60a5fa;
}

.dropzone-text small {
  font-size: 11px;
  color: #64748b;
}

.uploaded-filename {
  font-weight: 600;
  color: #10b981;
}

.config-actions {
  display: flex;
  gap: 8px;
}

/* Modal Styling */
.modal-backdrop {
  position: fixed;
  top: 0;
  left: 0;
  width: 100vw;
  height: 100vh;
  background: rgba(0, 0, 0, 0.75);
  backdrop-filter: blur(8px);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 100;
  padding: 20px;
}

.modal-card {
  width: 100%;
  max-width: 600px;
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 18px;
  padding: 28px;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.modal-header h3 {
  font-size: 18px;
  color: #fff;
  margin: 0;
}

.close-btn {
  background: none;
  border: none;
  color: #94a3b8;
  font-size: 18px;
  cursor: pointer;
}

.modal-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 16px;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  margin-top: 12px;
  padding-top: 16px;
  border-top: 1px solid #1f2937;
}
</style>
