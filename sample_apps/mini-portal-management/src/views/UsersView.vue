<script setup lang="ts">
import AdminLayout from '../layouts/AdminLayout.vue'
import { useUsersViewModel } from '../viewmodels/useUsersViewModel'

const {
  isLoading,
  searchQuery,
  filteredUsers,
  toggleUserStatus
} = useUsersViewModel()
</script>

<template>
  <AdminLayout>
    <div class="users-view">
      <div class="header-card glass-panel">
        <div class="header-text">
          <h2>Portal Administrator & Operator Accounts</h2>
          <p>Configure role-based permissions, API scopes, and administrative session policies.</p>
        </div>
        <div class="header-actions">
          <div class="search-box">
            <PPInput v-model="searchQuery" placeholder="Search team members..." />
          </div>
          <PPButton variant="filled">
            <span>+ Invite Team Member</span>
          </PPButton>
        </div>
      </div>

      <div class="card glass-panel">
        <!-- PPSkeleton Loading State -->
        <PPSkeleton :loading="isLoading" :animated="true">
          <template #template>
            <div class="skeleton-table">
              <div v-for="i in 5" :key="i" style="display: flex; align-items: center; justify-content: space-between; gap: 16px;">
                <div style="display: flex; align-items: center; gap: 12px; width: 30%;">
                  <PPSkeletonItem variant="circle" width="36px" height="36px" />
                  <div style="flex: 1; display: flex; flex-direction: column; gap: 4px;">
                    <PPSkeletonItem variant="text" width="70%" />
                    <PPSkeletonItem variant="text" width="45%" height="12px" />
                  </div>
                </div>
                <PPSkeletonItem variant="rect" width="80px" height="24px" style="border-radius: 6px;" />
                <PPSkeletonItem variant="rect" width="60px" height="24px" style="border-radius: 6px;" />
                <PPSkeletonItem variant="text" width="100px" />
                <PPSkeletonItem variant="text" width="90px" />
                <PPSkeletonItem variant="rect" width="120px" height="28px" style="border-radius: 6px;" />
              </div>
            </div>
          </template>

          <div class="table-container">
            <table class="portal-table">
              <thead>
                <tr>
                  <th>USER</th>
                  <th>ROLE</th>
                  <th>STATUS</th>
                  <th>MANAGED APPS</th>
                  <th>LAST LOGIN</th>
                  <th>ACTIONS</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="u in filteredUsers" :key="u.id">
                  <td>
                    <div class="user-cell">
                      <PPAvatar :src="u.avatar" :name="u.name" size="sm" />
                      <div>
                        <strong>{{ u.name }}</strong>
                        <small class="text-muted block">{{ u.email }}</small>
                      </div>
                    </div>
                  </td>
                  <td>
                    <PPChip :label="u.role" />
                  </td>
                  <td>
                    <PPChip
                      :label="u.status.toUpperCase()"
                      :color="u.status === 'active' ? 'success' : 'danger'"
                      size="sm"
                      variant="soft"
                    />
                  </td>
                  <td><strong>{{ u.assignedApps }}</strong> mini apps</td>
                  <td class="font-mono text-muted">{{ u.lastLogin }}</td>
                  <td>
                    <div class="actions">
                      <PPButton
                        size="sm"
                        :variant="u.status === 'active' ? 'outline' : 'filled'"
                        @click="toggleUserStatus(u)"
                      >
                        <span>{{ u.status === 'active' ? 'Suspend' : 'Activate' }}</span>
                      </PPButton>
                      <PPButton size="sm" variant="outline">
                        <span>Edit Roles</span>
                      </PPButton>
                    </div>
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
.users-view {
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

.header-text h2 {
  font-size: 20px;
  color: #fff;
  margin-bottom: 4px;
}

.header-text p {
  color: #94a3b8;
  font-size: 13px;
}

.header-actions {
  display: flex;
  align-items: center;
  gap: 12px;
}

.search-box {
  width: 240px;
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

.user-cell {
  display: flex;
  align-items: center;
  gap: 12px;
}

.text-muted {
  color: #94a3b8;
}

.block {
  display: block;
}

.actions {
  display: flex;
  gap: 8px;
}
</style>
