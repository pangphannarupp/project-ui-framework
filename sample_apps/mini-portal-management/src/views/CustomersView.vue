<script setup lang="ts">
import AdminLayout from '../layouts/AdminLayout.vue'
import { useCustomersViewModel } from '../viewmodels/useCustomersViewModel'

const {
  isLoading,
  searchQuery,
  selectedTier,
  tiers,
  filteredCustomers
} = useCustomersViewModel()
</script>

<template>
  <AdminLayout>
    <div class="customers-view">
      <div class="header-card glass-panel">
        <div>
          <h2>End-User Customers & Mini App Consumers</h2>
          <p>Inspect customer KYC tiering, spending volume, and linked mini app authorization states.</p>
        </div>
        <div class="header-controls">
          <div class="tier-segment-wrapper">
            <PPSegment v-model="selectedTier" variant="pill">
              <PPSegmentButton
                v-for="t in tiers"
                :key="t"
                :value="t"
              >
                {{ t }}
              </PPSegmentButton>
            </PPSegment>
          </div>
          <div class="search-box">
            <PPInput v-model="searchQuery" placeholder="Search phone, name..." />
          </div>
        </div>
      </div>

      <div class="card glass-panel">
        <!-- PPSkeleton Loading State -->
        <PPSkeleton :loading="isLoading" :animated="true">
          <template #template>
            <div class="skeleton-table">
              <div v-for="i in 5" :key="i" style="display: flex; align-items: center; justify-content: space-between; gap: 16px;">
                <div style="width: 25%; display: flex; flex-direction: column; gap: 4px;">
                  <PPSkeletonItem variant="text" width="80%" />
                  <PPSkeletonItem variant="text" width="50%" height="12px" />
                </div>
                <PPSkeletonItem variant="text" width="110px" />
                <PPSkeletonItem variant="rect" width="70px" height="24px" style="border-radius: 6px;" />
                <PPSkeletonItem variant="rect" width="60px" height="24px" style="border-radius: 6px;" />
                <PPSkeletonItem variant="text" width="80px" />
                <PPSkeletonItem variant="text" width="70px" />
                <PPSkeletonItem variant="text" width="90px" />
                <PPSkeletonItem variant="rect" width="90px" height="28px" style="border-radius: 6px;" />
              </div>
            </div>
          </template>

          <div class="table-container">
            <table class="portal-table">
              <thead>
                <tr>
                  <th>CUSTOMER</th>
                  <th>PHONE NUMBER</th>
                  <th>KYC STATUS</th>
                  <th>MEMBERSHIP TIER</th>
                  <th>TOTAL SPENT</th>
                  <th>LINKED MINI APPS</th>
                  <th>JOINED</th>
                  <th>ACTION</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="c in filteredCustomers" :key="c.id">
                  <td>
                    <strong>{{ c.name }}</strong>
                    <small class="block text-muted">{{ c.email }}</small>
                  </td>
                  <td class="font-mono">{{ c.phone }}</td>
                  <td>
                    <PPChip
                      :label="c.kycStatus.toUpperCase()"
                      :color="c.kycStatus === 'Verified' ? 'success' : c.kycStatus === 'Pending' ? 'warning' : 'danger'"
                      size="sm"
                      variant="soft"
                    />
                  </td>
                  <td>
                    <PPChip :label="c.tier" />
                  </td>
                  <td class="font-medium text-green">{{ c.totalSpent }}</td>
                  <td><strong>{{ c.usedAppsCount }}</strong> apps</td>
                  <td class="font-mono text-muted">{{ c.joinedDate }}</td>
                  <td>
                    <PPButton size="sm" variant="outline">
                      <span>View Profile</span>
                    </PPButton>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </PPSkeleton>
      </div>
    </div>
  </AdminLayout>
</template>

<style scoped>
.customers-view {
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

.header-controls {
  display: flex;
  align-items: center;
  gap: 14px;
  flex-wrap: wrap;
}

.tier-segment-wrapper :deep(.pp-segment) {
  background-color: #0f172a !important;
  border: 1px solid #1f2937 !important;
  padding: 3px !important;
}

.tier-segment-wrapper :deep(.pp-segment-button) {
  padding: 6px 14px !important;
  font-size: 13px !important;
  color: #94a3b8 !important;
  border-radius: 20px !important;
}

.tier-segment-wrapper :deep(.pp-segment-button--active) {
  color: #ffffff !important;
  font-weight: 600 !important;
}

.tier-segment-wrapper :deep(.pp-segment-indicator) {
  background-color: #2563eb !important;
  border-radius: 20px !important;
  box-shadow: 0 2px 8px rgba(37, 99, 235, 0.4) !important;
}

.search-box {
  width: 220px;
}

.card {
  background: #111827;
  border: 1px solid #1f2937;
  border-radius: 16px;
  overflow: hidden;
}

.table-container {
  overflow-x: auto;
}

.portal-table {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
}

.portal-table th {
  font-size: 11px;
  letter-spacing: 0.5px;
  color: #64748b;
  padding: 14px 18px;
  border-bottom: 1px solid #1f2937;
  background: #0d1321;
}

.portal-table td {
  padding: 16px 18px;
  font-size: 13px;
  border-bottom: 1px solid #1f2937;
  color: #e2e8f0;
}

.block {
  display: block;
}

.text-muted {
  color: #94a3b8;
}

.text-green {
  color: #10b981;
}
</style>
