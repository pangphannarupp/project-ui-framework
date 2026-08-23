<script setup lang="ts">
import AdminLayout from '../layouts/AdminLayout.vue'
import RichTextEditor from '../components/RichTextEditor.vue'
import { useConsentManagementViewModel } from '../viewmodels/useConsentManagementViewModel'

const {
  isLoading,
  activeTab,
  searchQuery,
  selectedCategory,
  selectedStatus,
  availableApps,
  filteredPolicies,
  filteredRecords,
  stats,
  showPolicyModal,
  isEditing,
  editingPolicy,
  showRecordDetailModal,
  selectedRecord,
  showToast,
  toastMessage,
  openCreateModal,
  openEditModal,
  savePolicy,
  togglePolicyStatus,
  deletePolicy,
  inspectRecord,
  revokeUserConsent
} = useConsentManagementViewModel()
</script>

<template>
  <AdminLayout>
    <div class="consent-view">
      <!-- Top Title & Quick Actions -->
      <div class="header-card glass-panel">
        <div>
          <h2>Consent & Privacy Governance</h2>
          <p>Manage customer terms of service, location permissions, auto-debit KHQR mandates, and user telemetry consent records.</p>
        </div>
        <PPButton variant="primary" size="small" @click="openCreateModal">
          <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" style="margin-right:6px;"><path d="M12 5v14M5 12h14"/></svg>
          <span>+ Create Consent Policy</span>
        </PPButton>
      </div>

      <!-- Feedback Banner -->
      <div v-if="showToast" class="alert-banner">
        <PPChip label="UPDATED" color="success" size="sm" variant="soft" />
        <span>{{ toastMessage }}</span>
      </div>

      <!-- KPI Summary Cards -->
      <div class="kpi-grid">
        <div class="kpi-card glass-panel">
          <div class="kpi-icon-wrap" style="background: rgba(59, 130, 246, 0.15); color: #60a5fa;">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
          </div>
          <div class="kpi-data">
            <span class="kpi-label">Active Policies</span>
            <strong class="kpi-val">{{ stats.activePolicies }}</strong>
            <small class="kpi-sub">Across All Mini Apps</small>
          </div>
        </div>

        <div class="kpi-card glass-panel">
          <div class="kpi-icon-wrap" style="background: rgba(16, 185, 129, 0.15); color: #34d399;">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
          </div>
          <div class="kpi-data">
            <span class="kpi-label">Consented Users</span>
            <strong class="kpi-val">{{ stats.totalUsersConsented.toLocaleString() }}</strong>
            <small class="kpi-sub" style="color: #34d399;">+12.4% this month</small>
          </div>
        </div>

        <div class="kpi-card glass-panel">
          <div class="kpi-icon-wrap" style="background: rgba(168, 85, 247, 0.15); color: #c084fc;">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
          </div>
          <div class="kpi-data">
            <span class="kpi-label">Compliance Rate</span>
            <strong class="kpi-val">{{ stats.complianceRate }}</strong>
            <small class="kpi-sub">GDPR & NBC Standards</small>
          </div>
        </div>

        <div class="kpi-card glass-panel">
          <div class="kpi-icon-wrap" style="background: rgba(245, 158, 11, 0.15); color: #fbbf24;">
            <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 14 14"></polyline></svg>
          </div>
          <div class="kpi-data">
            <span class="kpi-label">Audit Logs</span>
            <strong class="kpi-val">{{ filteredRecords.length }} Recorded</strong>
            <small class="kpi-sub">Immutable Telemetry</small>
          </div>
        </div>
      </div>

      <!-- Main Navigation Tabs -->
      <div class="tab-controls glass-panel">
        <div class="tab-pills">
          <button
            type="button"
            class="tab-btn"
            :class="{ active: activeTab === 'policies' }"
            @click="activeTab = 'policies'"
          >
            <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline></svg>
            <span>Consent Policies & Terms ({{ filteredPolicies.length }})</span>
          </button>
          <button
            type="button"
            class="tab-btn"
            :class="{ active: activeTab === 'records' }"
            @click="activeTab = 'records'"
          >
            <svg viewBox="0 0 24 24" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
            <span>Customer Consent Audit Records</span>
          </button>
        </div>

        <div class="tab-filters">
          <div class="search-box">
            <PPInput v-model="searchQuery" placeholder="Search title, app scope, or customer..." />
          </div>
          <div v-if="activeTab === 'policies'" class="filter-dropdown">
            <PPSelect
              v-model="selectedCategory"
              :options="[
                { label: 'All Categories', value: 'All' },
                { label: 'Terms of Service', value: 'Terms of Service' },
                { label: 'Privacy Policy', value: 'Privacy Policy' },
                { label: 'Location Access', value: 'Location Access' },
                { label: 'Payment Authorization', value: 'Payment Authorization' },
                { label: 'Push Alerts', value: 'Push Alerts' }
              ]"
            />
          </div>
          <div class="filter-dropdown">
            <PPSelect
              v-model="selectedStatus"
              :options="[
                { label: 'All Statuses', value: 'All' },
                { label: 'Active / Granted', value: activeTab === 'policies' ? 'Active' : 'Granted' },
                { label: 'Draft / Revoked', value: activeTab === 'policies' ? 'Draft' : 'Revoked' }
              ]"
            />
          </div>
        </div>
      </div>

      <!-- Loading Skeleton -->
      <PPSkeleton :loading="isLoading" :animated="true">
        <template #template>
          <div class="skeleton-table-card glass-panel" style="padding: 24px;">
            <div style="display: flex; flex-direction: column; gap: 16px;">
              <PPSkeletonItem variant="rect" height="42px" style="border-radius: 8px;" />
              <PPSkeletonItem v-for="i in 5" :key="i" variant="rect" height="56px" style="border-radius: 8px;" />
            </div>
          </div>
        </template>

        <!-- TAB 1: Policies Table -->
        <div v-if="activeTab === 'policies'" class="table-card glass-panel">
          <table class="portal-table">
            <thead>
              <tr>
                <th style="width: 280px;">CONSENT POLICY TITLE</th>
                <th>CATEGORY</th>
                <th>APPLICATION SCOPE</th>
                <th>VERSION</th>
                <th>MANDATORY</th>
                <th>USERS CONSENTED</th>
                <th>STATUS</th>
                <th>ACTIONS</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="p in filteredPolicies" :key="p.id">
                <td>
                  <div class="policy-meta-cell">
                    <strong>{{ p.title }}</strong>
                    <small class="text-muted">ID: {{ p.id }} · Updated: {{ p.lastUpdated }}</small>
                  </div>
                </td>
                <td>
                  <span class="category-badge">{{ p.category }}</span>
                </td>
                <td>
                  <code class="app-scope-code">{{ p.scopeApp }}</code>
                </td>
                <td>
                  <span class="version-tag">{{ p.version }}</span>
                </td>
                <td>
                  <PPChip
                    :label="p.isRequired ? 'MANDATORY' : 'OPTIONAL'"
                    :color="p.isRequired ? 'danger' : 'neutral'"
                    size="sm"
                    variant="soft"
                  />
                </td>
                <td>
                  <strong style="color: #f8fafc;">{{ p.consentedUsersCount.toLocaleString() }}</strong>
                </td>
                <td>
                  <PPChip
                    :label="p.status.toUpperCase()"
                    :color="p.status === 'Active' ? 'success' : 'neutral'"
                    size="sm"
                    variant="soft"
                  />
                </td>
                <td>
                  <div class="actions-group">
                    <PPButton variant="outline" size="small" @click="openEditModal(p)">
                      <span>Edit</span>
                    </PPButton>
                    <PPButton
                      :variant="p.status === 'Active' ? 'outline' : 'primary'"
                      size="small"
                      @click="togglePolicyStatus(p)"
                    >
                      <span>{{ p.status === 'Active' ? 'Pause' : 'Activate' }}</span>
                    </PPButton>
                    <button class="delete-icon-btn" @click="deletePolicy(p.id)" title="Delete policy">
                      <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>
                    </button>
                  </div>
                </td>
              </tr>
              <tr v-if="filteredPolicies.length === 0">
                <td colspan="8" class="empty-state-cell">
                  No consent policies match your filter query.
                </td>
              </tr>
            </tbody>
          </table>
        </div>

        <!-- TAB 2: User Records Table -->
        <div v-else class="table-card glass-panel">
          <table class="portal-table">
            <thead>
              <tr>
                <th>CUSTOMER ID & NAME</th>
                <th>PHONE NUMBER</th>
                <th>CONSENTED POLICY</th>
                <th>SCOPE</th>
                <th>VERSION</th>
                <th>CONSENT STATUS</th>
                <th>TIMESTAMP</th>
                <th>ACTIONS</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="r in filteredRecords" :key="r.id">
                <td>
                  <div class="customer-cell">
                    <strong>{{ r.customerName }}</strong>
                    <small class="text-muted">{{ r.customerId }}</small>
                  </div>
                </td>
                <td>
                  <span class="phone-code">{{ r.customerPhone }}</span>
                </td>
                <td>
                  <div class="policy-ref">
                    <span>{{ r.policyTitle }}</span>
                    <small class="text-muted">ID: {{ r.policyId }}</small>
                  </div>
                </td>
                <td>
                  <span class="app-scope-tag">{{ r.appScope }}</span>
                </td>
                <td>
                  <span class="version-tag">{{ r.consentedVersion }}</span>
                </td>
                <td>
                  <PPChip
                    :label="r.consentStatus.toUpperCase()"
                    :color="r.consentStatus === 'Granted' ? 'success' : r.consentStatus === 'Revoked' ? 'danger' : 'neutral'"
                    size="sm"
                    variant="soft"
                  />
                </td>
                <td>
                  <small class="text-muted">{{ r.consentedAt }}</small>
                </td>
                <td>
                  <div class="actions-group">
                    <PPButton variant="outline" size="small" @click="inspectRecord(r)">
                      <span>Audit Trail</span>
                    </PPButton>
                    <PPButton
                      :variant="r.consentStatus === 'Granted' ? 'outline' : 'primary'"
                      size="small"
                      @click="revokeUserConsent(r)"
                    >
                      <span>{{ r.consentStatus === 'Granted' ? 'Revoke' : 'Re-grant' }}</span>
                    </PPButton>
                  </div>
                </td>
              </tr>
              <tr v-if="filteredRecords.length === 0">
                <td colspan="8" class="empty-state-cell">
                  No customer consent records found.
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </PPSkeleton>

      <!-- POLICY CREATE / EDIT MODAL -->
      <div v-if="showPolicyModal" class="modal-backdrop">
        <div class="modal-card glass-panel modal-lg">
          <div class="modal-header">
            <div>
              <h3>{{ isEditing ? 'Edit Consent Policy' : 'Create New Consent Policy' }}</h3>
              <p class="modal-subtitle">Define terms of service, permissions scope, and user re-consent mandates</p>
            </div>
            <button class="close-modal-btn" @click="showPolicyModal = false">✕</button>
          </div>

          <form @submit.prevent="savePolicy" class="modal-body">
            <div class="form-row">
              <div class="form-group flex-2">
                <label>Policy Title <span class="required">*</span></label>
                <PPInput v-model="editingPolicy.title" placeholder="e.g. Precise Location & Bluetooth Beacon Terms" required />
              </div>
              <div class="form-group flex-1">
                <label>Policy Category</label>
                <PPSelect
                  v-model="editingPolicy.category"
                  :options="[
                    { label: 'Terms of Service', value: 'Terms of Service' },
                    { label: 'Privacy Policy', value: 'Privacy Policy' },
                    { label: 'Location Access', value: 'Location Access' },
                    { label: 'Payment Authorization', value: 'Payment Authorization' },
                    { label: 'Push Alerts', value: 'Push Alerts' },
                    { label: 'Camera & Media', value: 'Camera & Media' },
                    { label: 'Data Sharing', value: 'Data Sharing' }
                  ]"
                />
              </div>
            </div>

            <div class="form-row" style="margin-top: 12px;">
              <div class="form-group flex-2">
                <label>Application Scope</label>
                <PPSelect
                  v-model="editingPolicy.scopeApp"
                  :options="availableApps.map(a => ({ label: a, value: a }))"
                />
              </div>
              <div class="form-group flex-1">
                <label>Policy Version</label>
                <PPInput v-model="editingPolicy.version" placeholder="v1.0.0" required />
              </div>
              <div class="form-group flex-1">
                <label>Status</label>
                <PPSelect
                  v-model="editingPolicy.status"
                  :options="[
                    { label: 'Active', value: 'Active' },
                    { label: 'Draft', value: 'Draft' },
                    { label: 'Deprecated', value: 'Deprecated' }
                  ]"
                />
              </div>
            </div>

            <div class="switches-row" style="margin-top: 14px;">
              <div class="switch-item">
                <PPSwitch v-model="editingPolicy.isRequired" />
                <div class="switch-label">
                  <strong>Mandatory Consent Requirement</strong>
                  <small>User must accept before opening the target mini application</small>
                </div>
              </div>

              <div class="switch-item">
                <PPSwitch v-model="editingPolicy.requireReconsentOnUpdate" />
                <div class="switch-label">
                  <strong>Force Re-consent on Version Update</strong>
                  <small>Prompts user to re-accept when version increment is detected</small>
                </div>
              </div>
            </div>

            <div class="form-group" style="margin-top: 16px;">
              <label>Policy Terms & Legal Text (Rich Text Editor)</label>
              <RichTextEditor
                v-model="editingPolicy.content"
                placeholder="Write full legal policy clauses, user obligations, and privacy disclaimers..."
                min-height="160px"
              />
            </div>

            <div class="modal-footer">
              <PPButton type="button" variant="outline" size="small" @click="showPolicyModal = false">
                <span>Cancel</span>
              </PPButton>
              <PPButton type="submit" variant="primary" size="small">
                <span>{{ isEditing ? 'Save Changes' : 'Publish Policy' }}</span>
              </PPButton>
            </div>
          </form>
        </div>
      </div>

      <!-- AUDIT RECORD DETAIL MODAL -->
      <div v-if="showRecordDetailModal && selectedRecord" class="modal-backdrop">
        <div class="modal-card glass-panel" style="max-width: 600px;">
          <div class="modal-header">
            <div>
              <h3>Consent Audit Trail</h3>
              <p class="modal-subtitle">Cryptographic record timestamp and client telemetry</p>
            </div>
            <button class="close-modal-btn" @click="showRecordDetailModal = false">✕</button>
          </div>

          <div class="modal-body audit-details-grid">
            <div class="audit-row">
              <span class="audit-key">Audit Record ID:</span>
              <code class="audit-val">{{ selectedRecord.id }}</code>
            </div>
            <div class="audit-row">
              <span class="audit-key">Customer Name:</span>
              <strong class="audit-val">{{ selectedRecord.customerName }} ({{ selectedRecord.customerId }})</strong>
            </div>
            <div class="audit-row">
              <span class="audit-key">Phone Number:</span>
              <span class="audit-val">{{ selectedRecord.customerPhone }}</span>
            </div>
            <div class="audit-row">
              <span class="audit-key">Policy Title:</span>
              <span class="audit-val">{{ selectedRecord.policyTitle }}</span>
            </div>
            <div class="audit-row">
              <span class="audit-key">App Scope:</span>
              <span class="audit-val">{{ selectedRecord.appScope }}</span>
            </div>
            <div class="audit-row">
              <span class="audit-key">Accepted Version:</span>
              <span class="audit-val">{{ selectedRecord.consentedVersion }}</span>
            </div>
            <div class="audit-row">
              <span class="audit-key">Consent Status:</span>
              <PPChip
                :label="selectedRecord.consentStatus.toUpperCase()"
                :color="selectedRecord.consentStatus === 'Granted' ? 'success' : 'danger'"
                size="sm"
                variant="soft"
              />
            </div>
            <div class="audit-row">
              <span class="audit-key">Accepted Timestamp:</span>
              <span class="audit-val">{{ selectedRecord.consentedAt }}</span>
            </div>
            <div class="audit-row">
              <span class="audit-key">Origin IP Address:</span>
              <code class="audit-val">{{ selectedRecord.ipAddress }}</code>
            </div>
            <div class="audit-row">
              <span class="audit-key">Client User-Agent:</span>
              <span class="audit-val font-mono" style="font-size: 11px;">{{ selectedRecord.userAgent }}</span>
            </div>
          </div>

          <div class="modal-footer">
            <PPButton variant="outline" size="small" @click="showRecordDetailModal = false">
              <span>Close</span>
            </PPButton>
          </div>
        </div>
      </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
.consent-view {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.header-card {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 24px;
  border-radius: 14px;
}

.header-card h2 {
  font-size: 20px;
  font-weight: 700;
  color: #f8fafc;
  margin: 0 0 6px 0;
}

.header-card p {
  color: #94a3b8;
  font-size: 13px;
  margin: 0;
}

.alert-banner {
  display: flex;
  align-items: center;
  gap: 12px;
  background: rgba(16, 185, 129, 0.1);
  border: 1px solid rgba(16, 185, 129, 0.3);
  padding: 12px 18px;
  border-radius: 10px;
  font-size: 13px;
  color: #34d399;
}

/* KPI Grid */
.kpi-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 16px;
}

.kpi-card {
  display: flex;
  align-items: center;
  gap: 16px;
  padding: 20px;
  border-radius: 14px;
}

.kpi-icon-wrap {
  width: 48px;
  height: 48px;
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.kpi-data {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.kpi-label {
  font-size: 12px;
  font-weight: 600;
  color: #94a3b8;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.kpi-val {
  font-size: 22px;
  font-weight: 800;
  color: #f8fafc;
}

.kpi-sub {
  font-size: 11px;
  color: #64748b;
}

/* Tab Controls */
.tab-controls {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
  padding: 14px 20px;
  border-radius: 14px;
  position: relative;
  z-index: 20;
}

.tab-pills {
  display: flex;
  gap: 8px;
}

.tab-btn {
  display: flex;
  align-items: center;
  gap: 8px;
  background: #0f172a;
  border: 1px solid #1f2937;
  color: #94a3b8;
  font-size: 13px;
  font-weight: 600;
  padding: 8px 16px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
}

.tab-btn:hover {
  color: #f8fafc;
  border-color: #374151;
}

.tab-btn.active {
  background: #1e293b;
  color: #60a5fa;
  border-color: #3b82f6;
}

.tab-filters {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
  position: relative;
  z-index: 25;
}

.search-box {
  width: 260px;
}

.filter-dropdown {
  width: 170px;
  position: relative;
  z-index: 30;
}

/* Tables */
.table-card {
  padding: 6px;
  border-radius: 14px;
  overflow-x: auto;
}

.portal-table {
  width: 100%;
  min-width: 960px;
  border-collapse: collapse;
  text-align: left;
}

.portal-table th {
  padding: 14px 18px;
  font-size: 11px;
  font-weight: 700;
  color: #64748b;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  border-bottom: 1px solid #1f2937;
  white-space: nowrap;
}

.portal-table td {
  padding: 14px 18px;
  font-size: 13px;
  color: #cbd5e1;
  border-bottom: 1px solid rgba(31, 41, 55, 0.6);
  vertical-align: middle;
  white-space: nowrap;
}

.portal-table tr:hover td {
  background: rgba(255, 255, 255, 0.02);
}

.policy-meta-cell,
.customer-cell,
.policy-ref {
  display: flex;
  flex-direction: column;
  gap: 3px;
}

.category-badge {
  background: rgba(59, 130, 246, 0.1);
  color: #60a5fa;
  font-size: 11px;
  font-weight: 600;
  padding: 4px 8px;
  border-radius: 6px;
  border: 1px solid rgba(59, 130, 246, 0.2);
}

.app-scope-code {
  font-size: 12px;
  color: #38bdf8;
  background: #0f172a;
  padding: 3px 8px;
  border-radius: 4px;
  border: 1px solid #1e293b;
}

.app-scope-tag {
  font-size: 12px;
  color: #94a3b8;
}

.version-tag {
  font-size: 11px;
  font-family: monospace;
  font-weight: 700;
  color: #a855f7;
  background: rgba(168, 85, 247, 0.1);
  padding: 3px 8px;
  border-radius: 4px;
}

.phone-code {
  font-family: monospace;
  font-size: 12px;
  color: #cbd5e1;
}

.actions-group {
  display: flex;
  align-items: center;
  gap: 8px;
}

.delete-icon-btn {
  background: none;
  border: none;
  color: #64748b;
  padding: 6px;
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
}

.delete-icon-btn:hover {
  color: #ef4444;
  background: rgba(239, 68, 68, 0.1);
}

.empty-state-cell {
  text-align: center;
  padding: 40px !important;
  color: #64748b;
  font-style: italic;
}

/* Modals */
.modal-backdrop {
  position: fixed;
  inset: 0;
  background: rgba(0, 0, 0, 0.75);
  backdrop-filter: blur(6px);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
  padding: 20px;
}

.modal-card {
  width: 100%;
  max-width: 540px;
  max-height: 90vh;
  overflow-y: auto;
  border-radius: 16px;
  padding: 24px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.modal-lg {
  max-width: 780px;
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: flex-start;
}

.modal-header h3 {
  font-size: 18px;
  font-weight: 700;
  color: #f8fafc;
  margin: 0 0 4px 0;
}

.modal-subtitle {
  font-size: 12px;
  color: #94a3b8;
  margin: 0;
}

.close-modal-btn {
  background: none;
  border: none;
  color: #94a3b8;
  font-size: 18px;
  cursor: pointer;
}

.form-row {
  display: flex;
  gap: 14px;
}

.flex-1 { flex: 1; }
.flex-2 { flex: 2; }

.form-group {
  display: flex;
  flex-direction: column;
  gap: 6px;
}

.form-group label {
  font-size: 12px;
  font-weight: 600;
  color: #cbd5e1;
}

.switches-row {
  display: flex;
  flex-direction: column;
  gap: 14px;
  background: #090d16;
  border: 1px solid #1f2937;
  border-radius: 10px;
  padding: 14px;
}

.switch-item {
  display: flex;
  align-items: center;
  gap: 14px;
}

.switch-label {
  display: flex;
  flex-direction: column;
  gap: 2px;
}

.switch-label strong {
  font-size: 13px;
  color: #f8fafc;
}

.switch-label small {
  font-size: 11px;
  color: #94a3b8;
}

.modal-footer {
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  margin-top: 16px;
  padding-top: 16px;
  border-top: 1px solid #1f2937;
}

/* Audit Grid */
.audit-details-grid {
  display: flex;
  flex-direction: column;
  gap: 12px;
  background: #090d16;
  border: 1px solid #1f2937;
  border-radius: 10px;
  padding: 16px;
}

.audit-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 13px;
  padding-bottom: 8px;
  border-bottom: 1px solid rgba(31, 41, 55, 0.4);
}

.audit-key {
  color: #94a3b8;
  font-weight: 600;
}

.audit-val {
  color: #f8fafc;
}
</style>
